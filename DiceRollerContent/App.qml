// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import QtQuick.Controls
import DiceRoller

ApplicationWindow {
    width: Qt.platform.os === "android" ? Screen.width : Constants.width
    height: Qt.platform.os === "android" ? Screen.height : Constants.height

    visible: true
    title: "DiceRoller"

    MainScreen {
        id: mainScreen
        anchors.fill: parent
    }

}

