#ifndef ANDROIDJNI_H
#define ANDROIDJNI_H

#include <QObject>
#include <jni.h>
#include <QJniObject>
#include <QCoreApplication>
#include <QtCore/private/qandroidextras_p.h>
#include <QtConcurrent/QtConcurrent>

// Create a blueprint of the Java Helper class
Q_DECLARE_JNI_CLASS(Helper, "com/diceroller/app/Helper")

class AndroidJNI : public QObject {
    Q_OBJECT

public:
    explicit AndroidJNI(QObject *parent = nullptr)
        : QObject(parent) {}

    // Vibrate for mili-seconds
    Q_INVOKABLE void vibrate(int ms)
    {
        if (QNativeInterface::QAndroidApplication::sdkVersion() >= __ANDROID_API_I__)
        {
            // const auto vibratorPermission = "android.permission.VIBRATE";
            // auto requestResult = QtAndroidPrivate::requestPermission(vibratorPermission);
            // if (requestResult.result() != QtAndroidPrivate::Authorized)
            // {
            //     qWarning() << "Failed to acquire vibrator permission";
            //     return;
            // }
            // else
            // {
            // }
            auto future = QtConcurrent::run(
                [this, ms]()
                {
                    QJniEnvironment env;
                    if (env->ExceptionCheck()) { env->ExceptionClear(); }

                    // Your JNI calls here
                    QtJniTypes::Helper helper(QNativeInterface::QAndroidApplication::context());

                    if (!helper.isValid())
                    {
                        qWarning() << "Failed to initialize JNI Helper class";
                        return;
                    }

                    jboolean isSuccessful = helper.callMethod<jboolean>("vibrate", ms);
                    if (!isSuccessful)
                        qWarning() << "Failed to vibrate.";
                }
            );
        }
        else
        {
            qWarning() << "Invalid API, requires >=" << __ANDROID_API_I__;
        }
    }
};

#endif // ANDROIDJNI_H
