UPDATE THE CURRENT LIFEMESH FLOW, SPLASH SCREEN, HOME SCREEN, AND HOME CONTROLLER.

IMPORTANT:
DO NOT remove existing UI design.
DO NOT redesign screens from scratch.
ONLY:

* connect real functionality
* remove dummy data
* improve app flow
* load real database data
* add shimmer loading
* add realtime nearby updates

====================================================

1. UPDATE APP START FLOW
   ====================================================

CURRENT FLOW:
SplashScreen
→ Click Create User ID
→ DiscoveringNearbyScreen
→ WelcomeScreen
→ HomeScreen

REMOVE THIS FLOW.

====================================================
NEW REQUIRED FLOW
=================

IF USER PROFILE ALREADY EXISTS IN DATABASE:

Flow:
SplashScreen
→ DiscoveringNearbyScreen
→ HomeScreen

NO:

* WelcomeScreen
* Create ID again

====================================================
IF USER PROFILE DOES NOT EXIST:
===============================

Flow:
SplashScreen
→ IdentityScreen
→ PersonalInfoScreen
→ ReviewScreen
→ PermissionScreen
→ DiscoveringNearbyScreen
→ HomeScreen

====================================================
SPLASH SCREEN LOGIC
===================

On app start:

Check Isar database:

* onboarding user exists?
* onboardingCompleted == true?

IF TRUE:
Automatically navigate:
SplashScreen → DiscoveringNearbyScreen

IF FALSE:
Navigate:
SplashScreen → IdentityScreen → PersonalInfoScreen → ReviewScreen → PermissionScreen → DiscoveringNearbyScreen → Welcome→ HomeScreen
keep as it now have on currently
====================================================
2. REMOVE UNNECESSARY BUTTON FROM SPLASH
   ========================================

REMOVE THIS BUTTON COMPLETELY:

* “Get Started” gradient button with arrow REMOVE FULL CONTAINER:


DO NOT SHOW:

* Get Started button
* Arrow button

====================================================
3. UPDATE SPLASH SCREEN BUTTON
   ==============================

KEEP ONLY ONE BUTTON:
onboardingCompleted == true?
IF TRUE:
“Mesh Discovery”

IF FALSE:
“Create My ID”


STYLE:

* same futuristic glowing design
* same gradient
* same animation
* same glassmorphism style

BUTTON ACTION:


====================================================
4. UPDATE HOMECONTROLLER
   ========================

IMPORTANT:
Remove ALL dummy/static data.

NO MORE:

* hardcoded nearby users
* hardcoded activities
* fake dashboard stats

====================================================
HOMECONTROLLER MUST:
====================

LOAD REAL DATA FROM ISAR DATABASE.

====================================================
LOAD:
=====

* onboarding user
* nearby users
* activities
* mesh status
* profile image
* username
* dashboard stats
* signal strength
* connection count

====================================================
IF DATA NOT AVAILABLE:
======================

DO NOT SHOW DUMMY DATA.

Instead:

* show empty state
* show shimmer loading
* show animated placeholders

====================================================
5. ADD SHIMMER LOADING EFFECTS
   ==============================

While loading:

* nearby users shimmer
* activity cards shimmer
* profile shimmer
* dashboard card shimmer
* quick action shimmer

STYLE:

* dark shimmer
* cyan/purple glow shimmer
* futuristic loading placeholders

Use:

* shimmer package

====================================================
6. HOME SCREEN REALTIME FUNCTIONALITY
   =====================================

HomeScreen() must now:

====================================================
USE REALTIME DATA
=================

Using:

* Obx()
* Isar watchers
* reactive GetX updates

====================================================
SECTIONS TO UPDATE
==================

====================================================
HEADER
======

Load:

* real username
* real profile image
* real mesh status

====================================================
MESH CARD
=========

Load:

* nearby user count
* connection count
* signal strength

REALTIME update.

====================================================
NEARBY USERS
============

Load from Isar:
nearby_user_model

Show:

* avatar
* name
* distance
* signal

If no users:
show empty state.

====================================================
RECENT ACTIVITY
===============

Load from:
activity_model

Show:

* shared files
* messages
* nearby joins
* mesh activity

If empty:
show empty state card.

====================================================
7. DISCOVERINGNEARBYSCREEN UPDATE
   =================================

Make discovery screen more functional.

====================================================
WHILE DISCOVERING:
==================

Simulate:

* nearby device scanning
* signal verification
* encrypted mesh setup
* nearby user detection

====================================================
SAVE DISCOVERED USERS
=====================

Save generated nearby users into:
Isar database

Use:
nearby_user_model.dart

====================================================
AFTER DISCOVERY COMPLETE:
=========================

Automatically navigate:
Get.offAll(() => HomeScreen());

REMOVE:
WelcomeScreen completely.

====================================================
8. REMOVE WELCOMESCREEN
   =======================

WelcomeScreen no longer needed.

DELETE:

* WelcomeScreen route
* navigation
* onboarding transition to welcome

====================================================
9. REALTIME NEARBY DEVICE SYSTEM
   ================================

Inside HomeController:

Create realtime nearby simulation system.

====================================================
FEATURES
========

Simulate:

* users joining
* users leaving
* signal updates
* nearby count changes

Use:
Timer.periodic()

Update:

* RxList nearbyUsers
* RxInt nearbyCount
* RxDouble signalStrength

====================================================
10. EMPTY STATES
    ================

If no nearby users:
Show futuristic empty card:

“No nearby mesh users found.”

If no activities:
Show:
“No recent activity yet.”

Use:

* glowing icons
* futuristic empty illustrations

====================================================
11. IMPORTANT RULES
    ===================

DO:

* keep existing UI
* preserve current visual design
* only improve functionality
* connect database properly
* use reactive architecture

DO NOT:

* redesign layout
* add dummy data
* break animations
* remove cyberpunk theme

====================================================
12. FINAL RESULT
    ================

The app should now feel:

* real
* reactive
* database-driven
* realtime
* immersive
* alive

HomeScreen must behave like:
a real futuristic decentralized network dashboard.
