import Cutie 1.0
import QtQuick 2.14
import QtQuick.Layouts 1.15

CutiePage {
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
				visible: "Strength" in CutieWifiSettings.activeAccessPoint.data
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
				visible: "Strength" in CutieWifiSettings.activeAccessPoint.data
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
			visible: (modelData.path != CutieWifiSettings.activeAccessPoint.path &&
				litem.text != "")
			height: visible ? litem.height : 0
			width: parent.width
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
		property var page: Qt.createComponent("SavedWifis.qml")
		onClicked: {
			if (page.status === Component.Ready) {
				root.pageStack.push(page, {});
			}
		}
	}
}
