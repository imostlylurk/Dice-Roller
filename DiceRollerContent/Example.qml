import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import DiceRoller 1.0

Frame {
    id: root

    property real total: 0
    property real radius: 10

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
        Layout.fillWidth: true

        // Total Label
        Label {
            Layout.preferredWidth: 1 // Share space proportionally with buttons
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

            text: root.total
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            color: Theme.text
            font.weight: Font.Bold
            font.pointSize: Math.min(width / 10, 36) // Automatically scales with available height
        }

        // Common Button Style
        Repeater {
            model: [
                { "icon": "images/icons/add.svg", "action": () => root.total++ },
                { "icon": "images/icons/subtract.svg", "action": () => root.total > 0 ? root.total-- : root.total },
                { "icon": "images/icons/reset.svg", "action": () => root.total = 0 },
                { "icon": Theme.currentThemeIcon, "action": Theme.setNextTheme }
            ]

            delegate: OptionButton {
                Layout.minimumWidth: 60
                Layout.minimumHeight: 60
                Layout.maximumWidth: parent.height / 4
                Layout.maximumHeight: parent.height / 4
                Layout.alignment: Qt.AlignCenter

                icon.width: width * 0.5
                icon.height: height * 0.5
                icon.source: modelData.icon

                onClicked: modelData.action()
            }
        }
    }
}
