import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ToolBar {
    id: root

    // 1-- inputs and outputs
    // the parent tell us: "Are we on Mobile?"
    property bool isMobile: false

    // hardcoded height:
    height: 63

    // We tell parent: "User clicked Bold!"
    signal boldClicked
    signal italicClicked
    signal underlineClicked
    signal colorClicked
    signal highlighterClicked
    signal doneClicked
    signal fontSelected(string fontName)
    signal menuClicked

    // 2 Visuals
    Material.background: "#FFFFFF"
    Material.elevation: isMobile ? 8 : 0 // Shadow only on mobile

    // a tiny border line for desktop mode
    Rectangle {
        visible: !root.isMobile
        width: parent.width
        height: 5
        anchors.bottom: parent.bottom
        color: "#E0E0E0"
    }

    // 3 Buttons
    RowLayout {
        anchors.fill: parent
        spacing: 5

        // 1. MOBILE MENU BUTTON (Hamburger)
        ToolButton {
            visible: root.isMobile
            text: "☰" // Hamburger Icon
            font.pixelSize: 20
            onClicked: root.menuClicked() // Emit signal
        }

        ToolButton {
            id: insert
            text: "+"
            font.bold: true
            font.pixelSize: 20
            Layout.preferredHeight: 50
        }

        //Font Family(hidden on mobile
        ComboBox {
            visible: !root.isMobile
            model: ["Segoe UI", "Georgia", "Roboto"]
            Layout.preferredWidth: 150
            Layout.preferredHeight: 50
            Layout.leftMargin: 5 // Breathing room
        }
        ComboBox {
            model: ["12", "14", "16", "18"]
            Layout.preferredWidth: 69
            Layout.preferredHeight: 50
            Layout.leftMargin: 5 // Breathing room
        }

        ToolButton {
            text: "<b>B</b>"
            onClicked: root.boldClicked()
        }
        ToolButton {
            text: "<i>I</i>"
            onClicked: root.italicClicked()
        }
        ToolButton {
            text: "<u>U</u>"
            onClicked: root.underlineClicked()
        }
        ToolSeparator {}

        // Group 3: Colors (The new request)
        ToolButton {
            text: "A"
            font.bold: true
            palette.buttonText: "red" // Visual clue
            onClicked: root.colorClicked()
            // To make this real, we'd open a ColorDialog here
        }

        ToolButton {
            text: "🖊️" // Highlighter
            palette.buttonText: "#FFA500"
            onClicked: root.highlighterClicked()
        }

        // spacer pushes next items to right
        // "Done" Button (Only for Mobile)
        Item {
            Layout.fillWidth: true
        }
    }
}
