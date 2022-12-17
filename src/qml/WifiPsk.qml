import Cutie 1.0
import QtQuick 2.14
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.14

CutiePage {
	id: pskPage
	property var ap: null
	CutiePageHeader {
		id: header
		title: qsTr("Password")
		description: qsTr("Network \"%1\" requires authentication.").arg(ap.data["Ssid"])
	}
	Rectangle {
		color: (Atmosphere.variant == "dark") ? "#ffffff" : "#000000"
		visible: true
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.top: header.bottom
		anchors.topMargin: 40
		anchors.margins: 20
		height: 40
		radius: 8 
		clip: true
		TextField {
			id: pskText
			text: ""
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.margins: 10
			color: (Atmosphere.variant == "dark") ? "#000000" : "#ffffff"
			clip: true
			font.family: "Lato"
			font.pixelSize: 15 
			background: Item { }
			echoMode: TextInput.Password
		}
	}
	CutieButton {
		id: connectbutton
		buttonText: qsTr("Connect")
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.margins: 20
		onClicked: {
			CutieWifiSettings.addAndActivateConnection(ap, pskText.text);
			mainWindow.pageStack.pop()
		}
	}
}