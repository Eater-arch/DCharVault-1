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
    // new signal to tell editor the font changed
    signal mobileMenuClicked

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

        ToolButton{
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
            Layout.leftMargin: 5// Breathing room

        }
        ComboBox {
            model: ["12", "14", "16", "18"]
            Layout.preferredWidth: 69
            Layout.preferredHeight: 50
            Layout.leftMargin: 5// Breathing room
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

        // Mobile menu button (visible only on Mobile)
        ToolButton {
            visible: root.isMobile
            text: "Aa ▼" // improved text to show it has fonts

            onClicked: mobileMenu.open() // Opens the menu instead of just closing keyboard

            // This Menu lives "inside" the button logic
            Menu {
                id: mobileMenu
                y: -height // makes it pop up instead of down(since we are at bottom)

                // The Fonts (Moved inside here for Mobile)
                Label {
                    text: "Select Font"
                } // header
                MenuItem {
                    text: "Segoe UI"
                    onTriggered: root.fontSelected("Segoe UI")
                }
                MenuItem {
                    text: "Georgia"
                    onTriggered: root.fontSelected("Georgia")
                }
                MenuItem {
                    text: "Roboto"
                    onTriggered: root.fontSelected("Roboto")
                }

                MenuSeparator {}

                MenuItem {
                    text: "▼ Hide Keyboard"
                    onTriggered: root.doneClicked()
                }
            }
        }
    }
}
