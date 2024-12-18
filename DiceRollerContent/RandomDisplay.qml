import QtQuick
import QtQuick.Controls
import DiceRoller 1.0

Frame {
    id: root

    property int randomNum: 0
    property real radius: 10
    property bool isCoin: false

    implicitHeight: 120
    implicitWidth: 300

    background: Rectangle {
        anchors.fill: parent
        color: Theme.background
        border.width: Theme.borderWidth
        border.color: Theme.border
        radius: root.radius
    }

    Label {
        anchors.fill: parent

        // Choos Heads/Tails if it's a coin
        text: root.isCoin ? (root.randomNum === 1 ? "Heads" : "Tails") : root.randomNum
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: Theme.text
        font.weight: Font.DemiBold
        font.pointSize: parent.height * (root.isCoin ? 0.14 : 0.16) // for the heads and tails to appear smaller
    }
}
