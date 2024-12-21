import QtQuick
import QtQuick.Controls
import DiceRoller 1.0

Frame {
    id: root

    property int randomNum: 0
    property real radius: 10
    property bool isCoin: true

    implicitHeight: 120
    implicitWidth: 300

    background: Rectangle {
        anchors.fill: parent
        color: Theme.background
        border.width: Theme.borderWidth
        border.color: Theme.border
        radius: root.radius
    }

    // This really feels like a bad design, I'm just trying to avoid writing accessive code at this point
    // The coin doesn't care if it's a new property "flipped" in here or not, so we're just listening to
    // the randomNum change and flipping the coin. This way the randomNum can just act like a number
    // even for the coin button outside.
    Label {
        anchors.fill: parent

        visible: !isCoin

        text: root.randomNum
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: Theme.text
        font.weight: Font.DemiBold
        font.pointSize: parent.height * 0.16 // for the heads and tails to appear smaller
    }

    SpinnableCoin {
        id: spinnableCoin
        anchors.centerIn: parent

        height: root.height * 0.80 // 80%
        width: height

        visible: root.isCoin
        axis {
            x: 0
            y: 1
            z: 0
        }
    }

    onRandomNumChanged: {
        if (isCoin)
            spinnableCoin.flipped = !spinnableCoin.flipped
    }
}
