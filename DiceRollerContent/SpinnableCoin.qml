import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects 1.0
import DiceRoller

// Coin
Flipable {
    id: flipable

    property bool flipped: false
    property alias axis: rotation.axis
    property alias frontImage: frontImg
    property alias backImage: backImg
    property color color: Theme.text

    implicitHeight: 100
    implicitWidth: 100
    front: Image {
        id: frontImg

        anchors.fill: parent
        anchors.centerIn: parent

        source: "images/icons/coin-heads"
        sourceSize {
            width: flipable.front.width
            height: flipable.front.height
        }

        ColorOverlay {
            anchors.fill: parent
            source: parent
            color: flipable.color
        }
    }

    back: Image {
        id: backImg
        anchors.centerIn: parent
        anchors.fill: parent

        source: "images/icons/coin-tails"
        sourceSize {
            width: flipable.back.width
            height: flipable.back.height
        }
        ColorOverlay {
            anchors.fill: parent
            source: parent
            color: flipable.color
        }
    }


    transform: Rotation {
        id: rotation
        origin.x: flipable.width/2
        origin.y: flipable.height/2
        angle: 0    // the default angle
    }

    states: State {
        name: "back"
        when: flipable.flipped
        PropertyChanges {
            target: rotation;
            angle: 180
        }
    }

    transitions: Transition {
        NumberAnimation { target: rotation; property: "angle"; duration: 100;}
    }
}
