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
	CutieTextField {
		id: pskText
		text: ""
		anchors.top: header.bottom
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.margins: 20
		echoMode: TextInput.Password
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