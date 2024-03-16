import Cutie
import QtQuick

CutieWindow {
	id: mainWindow
	width: 400
	height: 800
	visible: true
	title: qsTr("Settings")

	property var pages: [
		{
			text: qsTr("Wi-Fi"),
			icon: "image://icon/network-wireless-symbolic",
			component: Qt.createComponent("Wifi.qml")
		},
		{
			text: qsTr("Mobile Network"),
			icon: "image://icon/network-cellular-symbolic",
			component: Qt.createComponent("MobileNetwork.qml")
		},
		{
			text: qsTr("Audio"),
			icon: "image://icon/audio-speakers-symbolic",
			component: Qt.createComponent("Audio.qml")
		},
		{
			text: qsTr("About"),
			icon: "image://icon/help-about-symbolic",
			component: Qt.createComponent("About.qml")
		}
	]

	initialPage: CutiePage {
		width: mainWindow.width
		height: mainWindow.height
		ListView {
			model: mainWindow.pages
			anchors.fill: parent
			header: CutiePageHeader {
				id: header
				title: mainWindow.title
			}

			delegate: CutieListItem {
				text: mainWindow.pages[index]["text"]
				icon.source: mainWindow.pages[index]["icon"]

				onClicked: {
					if (mainWindow.pages[index]["component"].status === Component.Ready) {
						mainWindow.pageStack.push(
							mainWindow.pages[index]["component"]
							, {});
					}
				}
			}
		}	
	}

}
