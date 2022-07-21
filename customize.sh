OVERLAY="
/system/app/EasterEgg
/system/app/Stk
/system/product/app/Jelly
/system/product/app/LatinIME
/system/product/app/messaging
/system/product/app/webview
/system/product/etc/permissions/privapp-permissions-hotword.xml
/system/product/etc/sysconfig/com.android.messaging_whitelist.xml
/system/product/etc/sysconfig/google-hiddenapi-package-whitelist.xml
/system/product/etc/sysconfig/google.xml
/system/product/etc/sysconfig/nexus.xml
/system/product/etc/sysconfig/pixel_2016_exclusive.xml
/system/product/lib64/libjni_latinime.so
/system/product/overlay/LatinIME__auto_generated_rro_product.apk
/system/product/priv-app/HotwordEnrollmentOKGoogleHEXAGON
/system/product/priv-app/HotwordEnrollmentXGoogleHEXAGON
/system/system_ext/etc/permissions/com.android.hotwordenrollment.common.util.xml
/system/system_ext/framework/com.android.hotwordenrollment.common.util.jar
/system/system_ext/framework/oat/arm/com.android.hotwordenrollment.common.util.odex
/system/system_ext/framework/oat/arm/com.android.hotwordenrollment.common.util.vdex
/system/system_ext/framework/oat/arm64/com.android.hotwordenrollment.common.util.odex
/system/system_ext/framework/oat/arm64/com.android.hotwordenrollment.common.util.vdex
"

UNINSTALL="
com.android.egg
com.android.hotwordenrollment.okgoogle
com.android.hotwordenrollment.xgoogle
com.android.inputmethod.latin
com.android.messaging
com.android.stk
com.android.webview
org.lineageos.jelly
"

function overlay {
  for f in "$@"; do
    FULLPATH="$MODPATH$f"
    if [[ -d $f ]]; then
      mkdir -p $FULLPATH
      touch $FULLPATH/.replace
    elif [[ -f $f ]]; then
      mkdir -p $(dirname $FULLPATH)
      touch $FULLPATH
    elif [[ -d $FULLPATH ]]; then
      touch $FULLPATH/.placeholder
    fi
    ui_print "    Overlaid: $(basename $f)"
    sleep 0.1
  done
}

function uninstall {
  for p in "$@"; do
    pm uninstall --user 0 $p &>/dev/null
    ui_print "    Removed: $p"
    sleep 0.1
  done
}

function install {
  for d in $MODPATH/system/app/*/ $MODPATH/system/priv-app/*/ ; do
    pm install --user 0 "$d/$(basename $d).apk" &>/dev/null
    ui_print "    Installed: $(basename $d).apk"
    sleep 0.1
  done
}

function clean {
  rm -rf /data/resource-cache/*
  rm -rf /data/dalvik-cache/*
  rm -rf /data/system/package_cache/*
  rm -rf /cache/dalvik-cache/*
  rm -rf /cache/*
}

function setup {
  settings put global development_settings_enabled 1
  settings put global adb_enabled 1
  settings put global stay_on_while_plugged_in 2
  settings put global mobile_data_always_on 0
  settings put global wifi_scan_always_enabled 0
  settings put global ble_scan_always_enabled 0
  settings put global adaptive_battery_management_enabled 0
  settings put global captive_portal_detection_enabled 0
  settings put global art_verifier_verify_debuggable 0
  settings put global verifier_verify_adb_installs 0
  settings put global power_sounds_enabled 1

  settings put system accelerometer_rotation 0
  settings put system dtmf_tone 0
  settings put system haptic_feedback_enabled 0
  settings put system lockscreen_sounds_enabled 1
  settings put system notification_light_pulse 1
  settings put system screen_brightness_mode 0
  settings put system screen_off_timeout 120000
  settings put system sound_effects_enabled 0
  settings put system vibrate_when_ringing 1

  settings put secure double_tap_to_wake 1
  settings put secure wake_gesture_enabled 0
  settings put secure notification_badging 1
  settings put secure enabled_accessibility_services net.blumia.pineapple.lockscreen.oss/net.blumia.pineapple.accessibility.A11yService
  settings put secure enabled_input_methods rkr.simplekeyboard.inputmethod/.latin.LatinIME
  settings put secure default_input_method rkr.simplekeyboard.inputmethod/.latin.LatinIME
}

function main {
  if $BOOTMODE; then
    ui_print "- Uninstalling bloatware..."
    uninstall $UNINSTALL
    ui_print "- Overlaying artifacts..."
    overlay $OVERLAY
    ui_print "- Cleaning the cache..."
    clean
    ui_print "- Installing replacements..."
    install
    ui_print "- Setting up..."
    setup
    ui_print "- Done!"
    ui_print "- Rebooting in 5 secs..."
    sleep 5
    reboot
  else
    abort "- Error: Installation through Magisk Manager is required."
  fi
}

main