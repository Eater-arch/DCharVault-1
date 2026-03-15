import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Vault.Security 1.0

Window {
    width: 300
    height: 200
    visible: true
    title: "QML Sample Login"

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        Label {
            text: "Enter Password"
            Layout.fillWidth: true
        }

        // The Visual Box
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            color: "#ffffff"
            border.color: secureInput.activeFocus ? "#3b82f6" : "#cccccc"
            border.width: 1
            radius: 8
            // The invisible C++ key interceptor
            SecurePasswordInput {
                id: secureInput
                anchors.fill: parent
                focus: true // Give it focus so it catches the keystrokes

                // Visual feedback: Draw the asterisks
                Text {

                    anchors.fill: parent
                    anchors.margins: 12
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 24
                    color: "#111111"
                    // This dynamically creates a string of dots exactly as long as your password
                    text: "".padStart(secureInput.passwordLength, "•")
                }

                // When the user hits Enter on their keyboard
                onEnterPressed: {
                    console.log("QML: Enter pressed. Triggering C++ authentication.")
                    // Pass the actual component to C++, NOT a text string
                    loginViewModel.authenticate(secureInput)
                }
            }
        }

        Button {
            text: "Unlock Vault"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                loginViewModel.authenticate(secureInput)
            }
        }
    }

    Connections {
        target: loginViewModel
        function onLoginSuccess() {
            console.log("QML: Vault unlocked! Time to change screens.")
            // TODO : Actually change the screen to the diary list
        }
        function onLoginFailed() {
            console.log("QML: Wrong password or crypto error.")
            // TODO tomorrow: Show a red error text on the UI
        }
    }
}
