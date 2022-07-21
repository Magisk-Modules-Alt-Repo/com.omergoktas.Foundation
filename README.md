# Foundation
Magisk module comprising essential apps (including a patched version of Google Play Store compatible with microG) and convenient settings for vanilla Android builds.

## Installation
Installation can be done through the [Magisk Manager](https://github.com/topjohnwu/Magisk). We recommend that you install this module right after flashing your rom.

## Features
A brief list of many features provided by this module can be found below.

### New apps
- microG (an open-source replacement for Google Play Services) [^1]
- Google Play Store (patched to support in-app purchases along with successful microG integration) [^2]
- F-Droid (an app store for free and open-source apps) [^3]
- F-Droid Privileged Extension (provides automated updates support to F-Droid) [^4]
- Material Files (providing many features on top of vanilla file manager of Android) [^5]
- Pineapple Lock Screen (provides a simple screen locking shortcut) [^6]

### Replaced apps
- Android Internet Browser is replaced with Bromite (chromium-based, de-Googled browser with built-in ad blocking functionality) [^7]
- Android System WebView is replaced with Bromite WebView (providing built-in ad blocking functionality, etc.) [^8]
- Built-in texting app is replaced with Simple SMS Messenger (supports marking messages as 'read' from the notification bubble) [^9]
- Built-in keyboard is replaced with Simple Keyboard (tightened privacy, does not require internet access, nothing but a keyboard (FYI. no built-in emojis either)) [^10]

### Other
- Black Planet (a beautiful boot animation) [^11]
- Following bloatware removed (on top of all the replacements listed above):
	- EasterEgg
	- Stk
	- HotwordEnrollmentOKGoogleHEXAGON
	- HotwordEnrollmentXGoogleHEXAGON
- The following features are enabled:
	- Notification badging
	- Double tap to wake
	- Vibrate when ringing
	- Notification light pulse
	- Lockscreen sounds
	- Power sounds
	- Stay on while plugged in
	- Development settings
	- USB debugging
	- Screen rotation lock
- The following features are disabled:
	- Wake gestures
	- Sound effects when tapping
	- Sound effects when dialing a phone number
	- Auto screen brightness
	- Haptic feedback (vibrate when tapping)
	- Captive portal detection [^12]
	- Adaptive battery management
	- Always scan bluetooth devices in the background
	- Always scan wifi devices in the background
	- Mobile data always on
	- Verify adb installs
	- Art verifier verifies debuggable

## Potential issues
- Boot animation may not work on some devices due to some strange behavior of Magisk [^13]
- The module is only tested on crDroid, though it should work on other builds too.

> **Note**  
> All apps provided, including the Google Play Store patches, are open source and taken from official websites.

## References
[^1]: https://github.com/microg
[^2]: https://gitlab.com/Nanolx/microg-phonesky-iap-support
[^3]: https://f-droid.org/en/packages/org.fdroid.fdroid
[^4]: https://f-droid.org/en/packages/org.fdroid.fdroid.privileged
[^5]: https://f-droid.org/en/packages/me.zhanghai.android.files
[^6]: https://f-droid.org/en/packages/net.blumia.pineapple.lockscreen.oss
[^7]: https://www.bromite.org
[^8]: https://www.bromite.org/system_web_view
[^9]: https://f-droid.org/en/packages/com.simplemobiletools.smsmessenger
[^10]: https://f-droid.org/en/packages/rkr.simplekeyboard.inputmethod
[^11]: https://forum.xda-developers.com/t/bootanimations-collection.3721978
[^12]: https://en.wikipedia.org/wiki/Captive_portal
[^13]: https://github.com/topjohnwu/Magisk/issues/562