import QtQuick
import QtQuick.Controls
import DiceRoller 1.0

RoundButton {
    id: control

    display: AbstractButton.IconOnly

    icon.color: Theme.text
    background: Rectangle {
        implicitHeight: 40
        implicitWidth: 40
        color: Theme.background

        radius: control.radius
        border {
            color: control.checked ? Qt.alpha(Theme.border, 0.70) : (control.pressed ? Qt.alpha(Theme.border, 0.10) : Theme.border)
            width: Theme.borderWidth
        }
    }
}
