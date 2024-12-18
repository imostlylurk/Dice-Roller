# 🎲 TableTop Games Assistant: Dice Roller

A simple and efficient **Dice Roller** app for tabletop games, allowing you to simulate dice rolls with various dice sizes, closely mimicking real-world behavior.

---

## 🚀 Building the App

It is recommended to use the [Qt Online Installer](https://www.qt.io/download) to download **Qt** and related tools. While the app builds and runs on non-Android devices, it may not appear the same due to DPI differences.

For easier experience, use **Qt Creator** or **Android Studio's SDK Manager** to set up Android Virtual Devices (AVDs) for running/testing. You can also test directly on your physical Android device.

---

### 🔧 Prerequisites

To build the project, you will need:
- **Qt for Android**
- **Android Development Enviroment** (described later)
- **An AVD or a Physical Device** 

---

## 📱 Setting Up an AVD in Qt Creator

Follow these steps to configure an Android emulator:

1. Open **Qt Creator** and navigate to `Edit → Preferences → Devices → Android`.
2. Download the required tools either manually or use the provided buttons to let Qt Creator handle it. The **JDK** setup, however, must be done manually.
3. Ensure that all the checks below **Android NDK List** are green-ticked.
4. Click `SDK Manager` and download an appropriate Android system image (not too old, Android 10+ recommended).
5. Restart Qt Creator to apply changes.
6. Go back to the **Device** tab and click `Add → Android Device`. Enter the correct details for the image you downloaded.
7. After adding a device, the **Kits** will be available in the `Projects` tab (left sidebar).
8. Under `Projects → Build Steps → Build Android APK`, you can customize the Manifest file (do NOT replace it, if you've no idea about it) through `Create Template` or you can find it at `<Project> -> android`.
9. Provide a **KeyStore file** for signing the APK:
   - Use the debug KeyStore at `C:\Users\<UserName>\.android\debug.keystore` (provided by Qt Creator for debugging), or create your own (MUST, if you're publishing).
   - Check the `Sign Package` option.
10. In the **Build and Kit Configuration** dropdown (above the "Run" button), ensure the correct device is selected and go ahead with the build.

---

## 📲 Setting Up Your Android Device

To test the app directly on a physical Android device:

1. Go to `Settings → About Phone` and repeatedly tap the **OS version** until you enable Developer Mode.
2. Navigate to `Developer Options → Debugging` and enable:
   - **USB Debugging**
   - **Install via USB**
3. Follow Steps **8, 9, and 10** from the [AVD Setup](#setting-up-an-avd-in-qt-creator) section.

---

## ✨ Features

- **Real-Time Dice Rolling**:  

    Press and hold any dice button to continuously generate random numbers within the dice range until released. The last rolled value is added to the total. Button press gives vibration feedback, if enabled.

- **Increment/Decrement/Reset Controls**:  
  
    Click to increment/decrement values by **+1/-1**, or hold for continuous adjustment. Can Reset the total as well.

- **Customizable Themes**:  
   
    Choose from **5 themes**.

- **Persistence**:  
   
    The app remembers your **last set theme** and **vibration mode**.

- **Exclusive Button Behavior**:  

   Prevents pressing or holding multiple dice buttons simultaneously.

---

## 🐞 Known Issues

- The app works seamlessly on mobile devices but is **not fully scalable** for desktop screens (when developing).

---

## 🛠️ Future Improvements (Optional)

- Add support for desktop scalability.

---

Feel free to report issues.
