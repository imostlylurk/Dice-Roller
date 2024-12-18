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

    // These are needed for QSettings to properly work and save the configurations.
    QCoreApplication::setOrganizationName("DiceRoller");
    QCoreApplication::setOrganizationDomain("diceroller.com");

    QQmlApplicationEngine engine;

#ifdef Q_OS_ANDROID
    // JNI communicator class, being exposed through contextProperty.
    // Everything being singleton doesn't look good.
    AndroidJNI jni;
    engine.rootContext()->setContextProperty("androidJNI", &jni);
#endif

    // Just a utility class, although it could've been named better.
    DiceRoller diceRoller;
    engine.rootContext()->setContextProperty("diceUtilities", &diceRoller);

    // Normal template code a Qt Quick App.
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
