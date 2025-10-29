# source_base

This's a source create by GoTrust Team

## Getting Started
   All folders in this source:
   - api: contain all method GET, POST, DELETE, PUT and use DIO to call server to get data
   - firebase: contain all function work with firebase
        # Firebase Social Service  
        # Firebase Push Notification
        # Firebase Crashlytics
   - model: contain all object model
   - modules: contain all screen 
   - resource: contain file config (load the first time when app run), file language of app and file setup deeplink
   - routes: use to define navigator screen on app 
   - utils: contain common data file, logic file(validate, ...)

******************************* PROTECT *******************************
# Android: app use "ProGuard" to optimize apk file after build and minimization case of reverse engineering to protect apk file
# IOS: Go to Runner.xcodeproj -> Runner -> Build Settings -> Enable Bitcode -> No to block reverse engineering
******************************* CONFIG FIRST *******************************

## Deeplink was setup, you need add this config to use

## With Android: android/app/src/main/AndroidManifest.xml
     
      <!-- Deep Links -->
      <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <!-- Accepts URIs that begin with YOUR_SCHEME://YOUR_HOST -->
        <data
          android:scheme="[YOUR_SCHEME]"
          android:host="[YOUR_HOST]" />
      </intent-filter>

      <!-- App Links -->
      <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <!-- Accepts URIs that begin with https://YOUR_HOST -->
        <data
          android:scheme="https"
          android:host="[YOUR_HOST]" />
     </intent-filter>

## With IOS: ios/Runner/Info.plist
     
    <!-- ... other tags -->
    <key>CFBundleURLTypes</key>
    <array>
    <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLName</key>
    <string>[ANY_URL_NAME]</string>
    <key>CFBundleURLSchemes</key>
    <array>
    <string>[YOUR_SCHEME]</string>
    </array>
    </dict>
    </array>
    <!-- ... other tags -->

# ============================ Firebase ============================
# Setup your firebase connect with this project
    - Config firebase project - FlutterFire to setup config -- *** flutterfire configure ***

# Firebase Social Service
    - Config service login (Google, Facebook, Apple)

# Firebase push notification
    - Config push noti ------ Note: Android is so easy to push noti, IOS must to setup APNs (Apple Dev) to push noti

# Firebase Crashlytics
    - Firebase web -> Your project -> Release & Monitor -> Crashlytics -> Choose IOS and Android to setup
    - Xcode project -> Runner -> Build Phases -> Add (+) -> New Run Script Phases 
        - Add this line
             "${PODS_ROOT}/FirebaseCrashlytics/run"
        - Add this line to Input Files
         ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME} 
# ===================================================================

# ===================== CHECK LIST =====================

    - Firebase
    - Notification setup
    - Firebase crashlytics
    - Deeplink setup
    - Login Google, Facebook, Apple setup# Mobile.Common
