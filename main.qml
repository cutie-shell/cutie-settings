import Cutie 1.0
import QtQuick 2.14

CutieWindow {
	id: root
	width: u(400)
	height: u(800)
	visible: true
	title: qsTr("Settings")

	property var pages: [
		{
			text: qsTr("Wi-Fi"),
			icon: "qrc:///icons/network-wireless-connected.svg",
			incubator: Qt.createComponent("Wifi.qml").incubateObject(null, {})
		}
	]

	initialPage: CutiePage {
		width: root.width
		height: root.height
		ListView {
			model: root.pages
			anchors.fill: parent
			header: CutiePageHeader {
				id: header
				title: root.title
			}

			delegate: CutieListItem {
				text: root.pages[index]["text"]
				icon: root.pages[index]["icon"]

				onClicked: {
					if (root.pages[index]["incubator"].status === Component.Ready) {
						root.pageStack.push(
							root.pages[index]["incubator"].object
							, {});
					}
				}
			}
		}	
	}

}
