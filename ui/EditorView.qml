import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

// CHANGE THIS FROM 'Item' TO 'Page'
Page {
    id: root

    // 1 settings
    // readonly property bool isMobile: Qt.platform.os === "android"
    // for testing switched to android view
    readonly property bool isMobile: true


    // --- API ---
    property alias entryTitle: titleField.text
    property alias entryContent: editorArea.text
    property alias readOnly: editorArea.readOnly

    // 2 Toolbar logic
    Component {
        id: toolbarComponent
        EditorToolbar {
            isMobile: root.isMobile

            // Handle signal from toolbar
            onBoldClicked: console.log("Bold requested")
            onItalicClicked: console.log("Italic requested")
            onUnderlineClicked: console.log("Underline Clicked")
            onDoneClicked: Qt.inputMethod.hide()
        }
    }

    // 3 Dynamic Placement
    // Desktop: Toolbar goes in header
    header: Loader {
        sourceComponent: toolbarComponent
        active: !root.isMobile
        visible: active
    }

    // Mobile: Toolbar goes in footer
    footer: Loader {
        sourceComponent: toolbarComponent
        active: root.isMobile
        visible: active
    }

    // The editor content
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 10

        // Divider
        Rectangle { Layout.fillWidth: true; height: 1; color: "#DDDDDD" }

        // --- HEADER ---
        TextField {
            id: titleField
            Layout.fillWidth: true
            font.pixelSize: 24
            font.bold: true
            background: null
            selectByMouse: true
        }

        Text {
            id: dateLabel
            text: Qt.formatDateTime(new Date(), "dddd, MMMM d • h:mm AP")
            color: "#C4A484"
            font.pixelSize: 12
        }

        // --- EDITOR ---
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            TextArea {
                id: editorArea
                font.pixelSize: 16
                font.family: "Georgia"
                wrapMode: Text.Wrap
                textFormat: TextEdit.RichText
                selectByMouse: true
                background: null
                color: "#7B3F00"
            }
        }
    }
}
