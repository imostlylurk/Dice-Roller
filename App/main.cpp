// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <qguiapplication.h>
#include <qqml.h>
#include <qsettings.h>

// #include "App/ScaleUI.h"
#include "App/diceroller.h"
#include "autogen/environment.h"
#include <QStandardPaths>

#ifdef Q_OS_ANDROID
#include "../android/src/AndroidJNI.h"
#endif

int main(int argc, char *argv[])
{
    set_qt_environment();
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("DiceRoller");
    QCoreApplication::setOrganizationDomain("diceroller.com");

    QQmlApplicationEngine engine;

#ifdef Q_OS_ANDROID
    AndroidJNI jni;
    engine.rootContext()->setContextProperty("androidJNI", &jni);
#endif

    DiceRoller diceRoller;
    engine.rootContext()->setContextProperty("diceUtilities", &diceRoller);


    qDebug() << QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);

    // This class is kinda underdevelopement. It is supposed to provide methods for DPI scaling
    // qmlRegisterSingletonType<ScaleUI>(
    //     "ScaleUI",
    //     1, 0,
    //     "ScaleUI",
    //     [](QQmlEngine *, QJSEngine *) -> QObject*
    //     {
    //         return new ScaleUI();
    //     });

    const QUrl url(mainQmlFile);
    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated, &app,
                [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");
    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

/*
    Issues to solve

    -.... Android specific code
    - Permission request before vibrate
    - DPI problem
    -.... Coin
    -.... Vibration option
    -.... C++ randomizer
    - Saving settings (Android)
    -... Correct icons and logo
    - Comments
    - AutoExclusive Dice buttons
*/
