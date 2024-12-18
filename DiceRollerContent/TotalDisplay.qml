import QtQuick
import QtCore
import QtQuick.Controls
import QtQuick.Layouts
import DiceRoller 1.0

Frame {
    id: root

    property real total: 0
    property real radius: 10
    property alias vibrate: vibrateButton.checked

    implicitHeight: 120
    implicitWidth: 300

    background: Rectangle {
        anchors.fill: parent
        color: Theme.background
        border {
            color: Theme.border
            width: Theme.borderWidth
        }
        radius: root.radius
    }

    RowLayout {
        anchors.fill: parent
        spacing: 10

        Label {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

            text: root.total
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            // padding: parent.height * 0.31 // 30 of 96 (height)

            color: Theme.text
            font.weight: Font.Bold
            font.pointSize: parent.height * 0.12 // around 39
        }

        property real buttonSize: height * 0.35 // 0.42 // 40 of 96 (height)

        // Increment -------------------------
        OptionButton {
            id: incrementbutton

            Layout.preferredHeight: parent.buttonSize
            Layout.preferredWidth: parent.buttonSize

            icon.width: parent.buttonSize * 0.52
            icon.height: parent.buttonSize * 0.52
            icon.source: "images/icons/add.svg"

            onClicked: {
                root.total++
            }

            onPressAndHold: {
                timer.shouldIncrement = true
                timer.start()
            }

            onReleased: {
                timer.stop()
                timer.interval = 100
            }

            onCanceled: {
                incrementbutton.released()
            }
        }

        // Decrement -------------------------
        OptionButton {
            id: decrementbutton

            Layout.preferredHeight: parent.buttonSize
            Layout.preferredWidth: parent.buttonSize

            icon.width: parent.buttonSize * 0.52    // 20 icon.width of 40
            icon.height: parent.buttonSize * 0.075  // 3 icon.height of 40
            icon.source: "images/icons/subtract.svg"

            onClicked: {
                if (root.total > 0)
                    root.total--
            }

            onPressAndHold: {
                timer.shouldIncrement = false
                timer.start()
            }

            onReleased: {
                timer.stop()
                timer.interval = 100 // Reset the interval
            }

            onCanceled: {
                decrementbutton.released()
            }
        }

        Timer {
            id: timer

            // Just a simple tag to distinguish the usage
            property bool shouldIncrement: true

            interval: 100 // Update interval in milliseconds
            repeat: true
            running: false

            onTriggered: {
                if (shouldIncrement)
                    root.total++
                else if (root.total > 0)
                    root.total--

                // Increase the speed over time
                if (interval > 50)
                    interval--
            }
        }

        // Reset -----------------------------
        OptionButton {
            id: resetbutton

            Layout.preferredHeight: parent.buttonSize
            Layout.preferredWidth: parent.buttonSize
            icon.height: parent.buttonSize * 0.55 // 22 of 40
            icon.width: parent.buttonSize * 0.50  // 20 of 40
            icon.source: "images/icons/reset.svg"

            onClicked: {
                root.total = 0
            }
        }

        // Theme -----------------------------
        OptionButton {
            id: themebutton

            Layout.preferredHeight: parent.buttonSize
            Layout.preferredWidth: parent.buttonSize

            // All this long ah thing due to the SolarizedDark icon's stretching too much, vertically.
            icon.height: Theme.currentTheme === Theme.SolarizedLight ? parent.buttonSize * 0.6 : parent.buttonSize * 0.52 // 20 of 40
            icon.width: parent.buttonSize * 0.52
            icon.source: Theme.currentThemeIcon

            onClicked: {
                Theme.setNextTheme()
            }
        }

        OptionButton {
            id: vibrateButton

            Layout.preferredHeight: parent.buttonSize
            Layout.preferredWidth: parent.buttonSize

            checkable: true
            icon.height: parent.buttonSize * 0.6 // 24 of 40
            icon.width: parent.buttonSize * 0.6
            icon.source: "images/icons/vibration"
            // icon.color: vibrateButton.checked ? Qt.alpha(Theme.text, 0.50) : Theme.text

            onClicked: {
                console.log("Vibrate", vibrateButton.checked)
            }
        }

        Settings {
            id: totalDisplaySettings

            category: "Configurations"

            property alias vibrate: vibrateButton.checked
        }
    }
}
