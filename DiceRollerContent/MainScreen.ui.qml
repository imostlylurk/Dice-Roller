

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import DiceRoller
import QtQuick.Layouts

Rectangle {
    id: root

    implicitWidth: Constants.width
    implicitHeight: Constants.height
    color: Theme.background

    property real currentRandomNum: 0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        // Random Display
        RandomDisplay {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.167 // 130.2 of 780
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop

            radius: 10

            // If range is 1-2, means Coin
            isCoin: randomTimer.currentRange === 2
            randomNum: root.currentRandomNum
        }

        // Dice Buttons
        GridLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true

            columns: 2
            rows: 3

            Repeater {
                id: diceButtons

                // Property to achieve autoExclusiveness, since autoExclusive works with checkable only
                // and Button.checked is set on release by default, leaving it checked after.
                property int currentPressed: -1

                model: [{
                        "label": "Coin",
                        "range": 2
                    }, {
                        "label": "D3",
                        "range": 3
                    }, {
                        "label": "D4",
                        "range": 4
                    }, {
                        "label": "D6",
                        "range": 6
                    }, {
                        "label": "D8",
                        "range": 8
                    }, {
                        "label": "D10",
                        "range": 10
                    }, {
                        "label": "D12",
                        "range": 12
                    }, {
                        "label": "D20",
                        "range": 20
                    }]

                delegate: DiceButton {
                    id: dbutton
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    text: modelData.label
                    radius: 10
                    font.pointSize: 16
                    isCurrent: diceButtons.currentPressed === model.index

                    Connections {
                        target: dbutton

                        onPressed: {

                            // Some of these are part of the exclusiveness.
                            // If currentPressed is -1, means no button is pressed yet.
                            if (diceButtons.currentPressed !== -1)
                                return
                            diceButtons.currentPressed = model.index

                            // Set the range and start randomizing valuess
                            randomTimer.currentRange = modelData.range
                            randomTimer.start()

                            // Only vibrate if it's Android. Otherwise throw error, due to Android code in main not being compiled.
                            if (Qt.platform.os === "android"
                                    && totalDisplay.vibrate)
                                androidJNI.vibrate(50)
                        }

                        onReleased: {
                            // If it isn't the current button releasing, then don't release.
                            if (!dbutton.isCurrent)
                                return

                            // Stop the timer and add the total value
                            randomTimer.stop()
                            // If it's range 1-2 (Coin flip), don't add it
                            if (randomTimer.currentRange !== 2)
                                totalDisplay.total += currentRandomNum

                            // Reset the exclusive state
                            diceButtons.currentPressed = -1
                        }

                        // For a weird behavior I noticed (not a bug though), when you hold and
                        // move the pointer outside, it kept the randomTimer going, which shouldn't be.
                        onCanceled: {
                            dbutton.released()
                        }
                    }
                }
            }

            Timer {
                id: randomTimer

                // A property to hold the range for currently pressed dice.
                // I don't know much about this approach, but DiceButton delegates uses shared timer
                // and the Timer needs the range of currently pressed button. But it's not a good practice to get range
                // using the model of repeater or something. So, we'll use a property inside the timer.
                property real currentRange: 1

                interval: 50 // Update interval in milliseconds
                repeat: true
                running: false
            }

            Connections {
                target: randomTimer
                onTriggered: {
                    // This won't work in QDS, because it's C++ code.
                    root.currentRandomNum = diceUtilities.roleDice(
                                randomTimer.currentRange)
                    // root.currentRandomNum = Math.floor(
                    //             Math.random() * randomTimer.currentRange) + 1
                }
            }
        }

        // Total Display
        TotalDisplay {
            id: totalDisplay
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.167 // 130.2 of 780
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }
    }
}
