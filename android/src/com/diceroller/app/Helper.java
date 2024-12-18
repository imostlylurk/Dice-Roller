package com.diceroller.app;

import android.content.Context;
import android.os.Vibrator;
import android.os.VibrationAttributes;
import android.os.VibrationEffect;
import android.os.Build;

public class Helper {
    private Vibrator vibrator;
    private VibrationAttributes attributes;

    public Helper(Context context)
    {
        if (context != null)
        {
            vibrator = (Vibrator) context.getSystemService(Context.VIBRATOR_SERVICE);
            // Initialize VibrationAttributes only for API 33+
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                attributes = VibrationAttributes.createForUsage(VibrationAttributes.USAGE_TOUCH);
            }
        }
    }

    // Function that vibrates on click
    // Vibrate in the context for given mili-seconds
    public boolean vibrate(int ms)
    {
        if (vibrator == null || !vibrator.hasVibrator())
            return false;

        VibrationEffect vibe = VibrationEffect.createOneShot(ms, VibrationEffect.DEFAULT_AMPLITUDE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU && attributes != null) {
            vibrator.vibrate(vibe, attributes);
        } else {
            vibrator.vibrate(vibe); // Use legacy method for older versions
        }
        return true;
    }
}
