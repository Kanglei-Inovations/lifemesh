package com.kangleiinnovations.lifemesh;

import android.Manifest;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothManager;
import android.bluetooth.le.AdvertiseCallback;
import android.bluetooth.le.AdvertiseData;
import android.bluetooth.le.AdvertiseSettings;
import android.bluetooth.le.BluetoothLeAdvertiser;
import android.bluetooth.le.BluetoothLeScanner;
import android.bluetooth.le.ScanCallback;
import android.bluetooth.le.ScanFilter;
import android.bluetooth.le.ScanRecord;
import android.bluetooth.le.ScanResult;
import android.bluetooth.le.ScanSettings;
import android.content.Context;
import android.content.pm.PackageManager;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.ParcelUuid;
import android.provider.Settings;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String METHOD_CHANNEL = "lifemesh/ble_rssi";
    private static final String EVENT_CHANNEL = "lifemesh/ble_rssi/events";
    private static final ParcelUuid LIFEMESH_SERVICE_UUID =
            new ParcelUuid(UUID.fromString("7b5d0001-4f45-4d45-5348-4c4946450001"));

    private final Handler mainHandler = new Handler(Looper.getMainLooper());
    private EventChannel.EventSink rssiEventSink;
    private BluetoothLeAdvertiser advertiser;
    private BluetoothLeScanner scanner;
    private AdvertiseCallback advertiseCallback;
    private ScanCallback scanCallback;
    private final Map<String, Long> lastRssiEventAt = new HashMap<>();

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(
                flutterEngine.getDartExecutor().getBinaryMessenger(),
                METHOD_CHANNEL
        ).setMethodCallHandler((call, result) -> {
            switch (call.method) {
                case "startBleAdvertising":
                    String fingerprint = call.argument("fingerprint");
                    result.success(startBleAdvertising(fingerprint));
                    break;
                case "stopBleAdvertising":
                    stopBleAdvertising();
                    result.success(null);
                    break;
                case "startBleScanning":
                    result.success(startBleScanning());
                    break;
                case "stopBleScanning":
                    stopBleScanning();
                    result.success(null);
                    break;
                case "isBluetoothEnabled":
                    result.success(isBluetoothEnabled());
                    break;
                case "isWifiEnabled":
                    result.success(isWifiEnabled());
                    break;
                case "getDeviceName":
                    result.success(getDeviceName());
                    break;
                default:
                    result.notImplemented();
                    break;
            }
        });

        new EventChannel(
                flutterEngine.getDartExecutor().getBinaryMessenger(),
                EVENT_CHANNEL
        ).setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                rssiEventSink = events;
            }

            @Override
            public void onCancel(Object arguments) {
                rssiEventSink = null;
            }
        });
    }

    private boolean startBleAdvertising(String fingerprint) {
        BluetoothAdapter adapter = bluetoothAdapter();
        if (adapter == null || !adapter.isEnabled() || !hasBlePermissions()) {
            return false;
        }

        if (!getPackageManager().hasSystemFeature(PackageManager.FEATURE_BLUETOOTH_LE)
                || !adapter.isMultipleAdvertisementSupported()) {
            return false;
        }

        byte[] serviceData = hexToBytes(fingerprint);
        if (serviceData.length == 0) {
            return false;
        }

        stopBleAdvertising();
        advertiser = adapter.getBluetoothLeAdvertiser();
        if (advertiser == null) {
            return false;
        }

        AdvertiseSettings settings = new AdvertiseSettings.Builder()
                .setAdvertiseMode(AdvertiseSettings.ADVERTISE_MODE_LOW_LATENCY)
                .setTxPowerLevel(AdvertiseSettings.ADVERTISE_TX_POWER_HIGH)
                .setConnectable(false)
                .build();

        AdvertiseData data = new AdvertiseData.Builder()
                .addServiceData(LIFEMESH_SERVICE_UUID, serviceData)
                .setIncludeDeviceName(false)
                .build();

        advertiseCallback = new AdvertiseCallback() {
            @Override
            public void onStartSuccess(AdvertiseSettings settingsInEffect) {
                super.onStartSuccess(settingsInEffect);
            }

            @Override
            public void onStartFailure(int errorCode) {
                super.onStartFailure(errorCode);
            }
        };

        try {
            advertiser.startAdvertising(settings, data, advertiseCallback);
            return true;
        } catch (SecurityException exception) {
            return false;
        }
    }

    private void stopBleAdvertising() {
        if (advertiser == null || advertiseCallback == null) {
            return;
        }

        try {
            advertiser.stopAdvertising(advertiseCallback);
        } catch (SecurityException ignored) {
        } finally {
            advertiseCallback = null;
            advertiser = null;
        }
    }

    private boolean startBleScanning() {
        BluetoothAdapter adapter = bluetoothAdapter();
        if (adapter == null || !adapter.isEnabled() || !hasBlePermissions()) {
            return false;
        }

        stopBleScanning();
        scanner = adapter.getBluetoothLeScanner();
        if (scanner == null) {
            return false;
        }

        List<ScanFilter> filters = new ArrayList<>();

        ScanSettings settings = new ScanSettings.Builder()
                .setScanMode(ScanSettings.SCAN_MODE_LOW_LATENCY)
                .build();

        scanCallback = new ScanCallback() {
            @Override
            public void onScanResult(int callbackType, ScanResult result) {
                emitRssi(result);
            }

            @Override
            public void onBatchScanResults(List<ScanResult> results) {
                for (ScanResult result : results) {
                    emitRssi(result);
                }
            }
        };

        try {
            scanner.startScan(filters, settings, scanCallback);
            return true;
        } catch (SecurityException exception) {
            return false;
        }
    }

    private void stopBleScanning() {
        if (scanner == null || scanCallback == null) {
            return;
        }

        try {
            scanner.stopScan(scanCallback);
        } catch (SecurityException ignored) {
        } finally {
            scanCallback = null;
            scanner = null;
            lastRssiEventAt.clear();
        }
    }

    private void emitRssi(ScanResult result) {
        if (rssiEventSink == null) {
            return;
        }

        ScanRecord record = result.getScanRecord();
        if (record == null) {
            return;
        }

        byte[] serviceData = record.getServiceData(LIFEMESH_SERVICE_UUID);
        if (serviceData == null || serviceData.length == 0) {
            return;
        }

        String fingerprint = bytesToHex(serviceData);
        long now = System.currentTimeMillis();
        Long lastSentAt = lastRssiEventAt.get(fingerprint);
        if (lastSentAt != null && now - lastSentAt < 1000) {
            return;
        }
        lastRssiEventAt.put(fingerprint, now);

        Map<String, Object> payload = new HashMap<>();
        payload.put("fingerprint", fingerprint);
        payload.put("rssi", result.getRssi());
        mainHandler.post(() -> {
            if (rssiEventSink != null) {
                rssiEventSink.success(payload);
            }
        });
    }

    private boolean isBluetoothEnabled() {
        BluetoothAdapter adapter = bluetoothAdapter();
        return adapter != null && adapter.isEnabled();
    }

    private boolean isWifiEnabled() {
        try {
            WifiManager wifiManager =
                    (WifiManager) getApplicationContext().getSystemService(Context.WIFI_SERVICE);
            return wifiManager != null && wifiManager.isWifiEnabled();
        } catch (Exception exception) {
            return false;
        }
    }

    private String getDeviceName() {
        try {
            String name = Settings.Global.getString(
                    getContentResolver(),
                    Settings.Global.DEVICE_NAME
            );
            if (name != null && !name.trim().isEmpty()) {
                return name.trim();
            }
        } catch (Exception ignored) {
        }
        return Build.MANUFACTURER + " " + Build.MODEL;
    }

    private BluetoothAdapter bluetoothAdapter() {
        BluetoothManager manager =
                (BluetoothManager) getSystemService(Context.BLUETOOTH_SERVICE);
        if (manager == null) {
            return null;
        }
        return manager.getAdapter();
    }

    private boolean hasBlePermissions() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return true;
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            return checkSelfPermission(Manifest.permission.BLUETOOTH_ADVERTISE)
                    == PackageManager.PERMISSION_GRANTED
                    && checkSelfPermission(Manifest.permission.BLUETOOTH_SCAN)
                    == PackageManager.PERMISSION_GRANTED
                    && checkSelfPermission(Manifest.permission.BLUETOOTH_CONNECT)
                    == PackageManager.PERMISSION_GRANTED;
        }
        return checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION)
                == PackageManager.PERMISSION_GRANTED;
    }

    private byte[] hexToBytes(String value) {
        if (value == null) {
            return new byte[0];
        }

        String clean = value.replaceAll("[^A-Fa-f0-9]", "");
        if (clean.length() % 2 != 0) {
            clean = "0" + clean;
        }

        byte[] output = new byte[clean.length() / 2];
        for (int i = 0; i < clean.length(); i += 2) {
            output[i / 2] = (byte) Integer.parseInt(clean.substring(i, i + 2), 16);
        }
        return output;
    }

    private String bytesToHex(byte[] bytes) {
        StringBuilder builder = new StringBuilder();
        for (byte b : bytes) {
            builder.append(String.format(Locale.US, "%02x", b));
        }
        return builder.toString();
    }

    @Override
    protected void onDestroy() {
        stopBleAdvertising();
        stopBleScanning();
        super.onDestroy();
    }
}
