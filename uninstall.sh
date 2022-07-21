MODPATH=${0%/*}

UNINSTALL="
com.android.vending
com.google.android.gms
com.google.android.gsf
com.simplemobiletools.smsmessenger
me.zhanghai.android.files
net.blumia.pineapple.lockscreen.oss
org.bromite.bromite
org.bromite.webview
org.fdroid.fdroid
org.fdroid.fdroid.privileged
rkr.simplekeyboard.inputmethod
"

INSTALL="
com.android.egg
com.android.hotwordenrollment.okgoogle
com.android.hotwordenrollment.xgoogle
com.android.inputmethod.latin
com.android.messaging
com.android.stk
com.android.webview
org.lineageos.jelly
"

function waitboot {
  until [[ "$(getprop sys.boot_completed)" == "1" ]]; do
    sleep 0.1
  done
}

function uninstall {
  for p in "$@"; do
    pm uninstall --user 0 $p
    sleep 0.1
  done
}

function install {
  for p in "$@"; do
    cmd package install-existing --wait --user 0 $p
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

function unwind {
  settings delete global development_settings_enabled
  settings delete global adb_enabled
  settings delete global stay_on_while_plugged_in
  settings delete global mobile_data_always_on
  settings delete global wifi_scan_always_enabled
  settings delete global ble_scan_always_enabled
  settings delete global adaptive_battery_management_enabled
  settings delete global captive_portal_detection_enabled
  settings delete global art_verifier_verify_debuggable
  settings delete global verifier_verify_adb_installs
  settings delete global power_sounds_enabled

  settings delete system accelerometer_rotation
  settings delete system dtmf_tone
  settings delete system haptic_feedback_enabled
  settings delete system lockscreen_sounds_enabled
  settings delete system notification_light_pulse
  settings delete system screen_brightness_mode
  settings delete system screen_off_timeout
  settings delete system sound_effects_enabled
  settings delete system vibrate_when_ringing

  settings delete secure double_tap_to_wake
  settings delete secure wake_gesture_enabled
  settings delete secure notification_badging
  settings delete secure enabled_accessibility_services

  settings put secure enabled_input_methods com.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME
  settings put secure default_input_method com.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME
}

function main {
  waitboot
  uninstall $UNINSTALL
  clean
  install $INSTALL
  unwind
  reboot
}

main