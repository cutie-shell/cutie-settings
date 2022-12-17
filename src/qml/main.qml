import Cutie 1.0
import QtQuick 2.14

CutieWindow {
	id: mainWindow
	width: 400
	height: 800
	visible: true
	title: qsTr("Settings")

	property var pages: [
		{
			text: qsTr("Wi-Fi"),
			icon: "qrc:///icons/network-wireless.svg",
			component: Qt.createComponent("Wifi.qml")
		},
		{
			text: qsTr("About"),
			icon: "qrc:///icons/info.svg",
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
				icon: mainWindow.pages[index]["icon"]

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
