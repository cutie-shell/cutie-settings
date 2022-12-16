import Cutie 1.0
import QtQuick 2.14
import QtQuick.Layouts 1.15

CutiePage {
	id: page
	property var pskPage: Qt.createComponent("WifiPsk.qml")
	property var savedPage: Qt.createComponent("SavedWifis.qml")
	ListView {
		model: CutieWifiSettings.accessPoints
		anchors.fill: parent
		anchors.margins: 10
		spacing: 0

		Component.onCompleted: {
			CutieWifiSettings.requestScan();
		}

		header: ColumnLayout {
			width: parent.width
			CutiePageHeader {
				id: header
				title: qsTr("Wi-Fi")
			}
			Text {
				visible: CutieWifiSettings.activeAccessPoint
				text: qsTr("Connected")
				font.pixelSize: 16
				font.family: "Lato"
				font.weight: Font.Normal
				horizontalAlignment: Text.AlignLeft
				color: (Atmosphere.variant == "dark") ? "#ffffff" : "#000000"
				Layout.leftMargin: 20
				Layout.rightMargin: 20
				Layout.topMargin: 10
				Layout.bottomMargin: 3
			}
			CutieListItem {
				visible: CutieWifiSettings.activeAccessPoint
				icon: visible ? ("qrc:///icons/network-wireless-signal-" + (
					Math.floor((CutieWifiSettings.activeAccessPoint.data["Strength"] - 1) / 20)
				).toString() + ".svg") : ""
				text: visible ? CutieWifiSettings.activeAccessPoint.data["Ssid"] : ""
				subText: visible ? ((CutieWifiSettings.activeAccessPoint.data["Frequency"] > 4 ? "5GHz " : "2.4GHz ") 
					+ ((CutieWifiSettings.activeAccessPoint.data["Flags"] & 0x1) == 0 ? "Open" : 
					((CutieWifiSettings.activeAccessPoint.data["RsnFlags"] & 0x100) > 0 ? "WPA2-PSK" :
					(CutieWifiSettings.activeAccessPoint.data["WpaFlags"] & 0x100) > 0 ? "WPA1-PSK" : 
					"Unknown Security"))) : ""
			}
			Text {
				text: qsTr("Available")
				font.pixelSize: 16
				font.family: "Lato"
				font.weight: Font.Normal
				horizontalAlignment: Text.AlignLeft
				color: (Atmosphere.variant == "dark") ? "#ffffff" : "#000000"
				Layout.leftMargin: 20
				Layout.rightMargin: 20
				Layout.topMargin: 10
				Layout.bottomMargin: 3
			}
		}

		delegate: Item {
			visible: CutieWifiSettings.activeAccessPoint ? (modelData.path != CutieWifiSettings.activeAccessPoint.path &&
				litem.text != "") : true
			height: visible ? litem.height : 0
			width: parent ? parent.width : 0
			CutieListItem {
				id: litem
				icon: ("qrc:///icons/network-wireless-signal-" + (
					Math.floor((modelData.data["Strength"] - 1) / 20)
				).toString() + ".svg")
				text: modelData.data["Ssid"]
				subText: ((modelData.data["Frequency"] > 4000 ? "5GHz " : "2.4GHz ") 
					+ ((modelData.data["Flags"] & 0x1) == 0 ? "Open" : 
					((modelData.data["RsnFlags"] & 0x100) > 0 ? "WPA2-PSK" :
					(modelData.data["WpaFlags"] & 0x100) > 0 ? "WPA1-PSK" : 
					"Unknown Security")))
				onClicked: {
					var conn = CutieWifiSettings.savedConnections.filter(
						e => e.data["connection"]["id"] == modelData.data["Ssid"])[0];
					if (conn)
						CutieWifiSettings.activateConnection(conn, modelData);
					else if ((modelData.data["Flags"] & 0x1) == 1) {
						if (page.pskPage.status === Component.Ready) {
							mainWindow.pageStack.push(page.pskPage, {ap: modelData});
						}
					} else {
						CutieWifiSettings.addAndActivateConnection(modelData, "");
					}
					CutieWifiSettings.requestScan();
				}
			}
		}

		footer: Item {
			height: footbutton.height + 40
		}
	}

	CutieButton {
		id: footbutton
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.margins: 20
		buttonText: qsTr("Saved Networks")
		onClicked: {
			if (page.savedPage.status === Component.Ready) {
				mainWindow.pageStack.push(page.savedPage, {});
			}
		}
	}
}
