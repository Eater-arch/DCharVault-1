import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: root

    // Detect Mobile
    readonly property bool isMobile: true// Change to 'true' to test Drawer on PC

    background: Rectangle { color: "#FAFAFA" }

    // --- 1. THE DRAWER (For Mobile Only) ---
    Drawer {
        id: mobileDrawer
        width: Math.min(parent.width * 0.8, 300)
        height: parent.height
        interactive: root.isMobile // Only swipe-able on mobile

        SidebarView {
            anchors.fill: parent
            onEntrySelected: mobileDrawer.close() // Close drawer after picking
        }
    }

    // --- 2. THE MAIN LAYOUT ---
    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        // Custom Handle (Invisible on mobile, nice on desktop)
        handle: Rectangle {
            implicitWidth: root.isMobile ? 0 : 1 // No handle on mobile
            color: "#E0E0E0"
        }

        // --- LEFT PANE (Desktop Only) ---
        // On Mobile, we hide this because we use the Drawer instead
        SidebarView {
            visible: !root.isMobile
            SplitView.preferredWidth: 300
            SplitView.minimumWidth: 200
            SplitView.maximumWidth: 400
        }

        // --- RIGHT PANE (Editor) ---
        // Always visible
        EditorView {
            SplitView.fillWidth: true

            // Link the Mobile Menu Button to the Drawer
            // (We will add a menu button to EditorToolbar later if needed)
            onMenuClicked: mobileDrawer.open()
        }
    }
}
