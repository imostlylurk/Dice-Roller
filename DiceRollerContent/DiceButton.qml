import QtQuick 6.0
import QtQuick.Controls 6.0
import DiceRoller

RoundButton {
    id: control

    // This property is used for exclusiveness among others, See MainScreen.ui.qml.
    property bool isCurrent: false

    flat: true
    radius: 10

    text: "Hello"

    // These seem redundant and a Label could be used/assigned to contentItem. But I'm too lazy...
    palette {
        buttonText: Theme.text
        brightText: Theme.text
        highlight: Theme.text
        windowText: Theme.text
    }

    background: Rectangle {
        color: Theme.background

        border {
            color: control.pressed && control.isCurrent ? Qt.alpha(Theme.border, 0.10) : Theme.border
            width: Theme.borderWidth
        }
        radius: control.radius
    }
}
