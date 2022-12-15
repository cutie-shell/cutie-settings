import Cutie 1.0
import QtQuick 2.14
import QtQuick.Layouts 1.15

CutiePage {
	ListView {
		model: CutieWifiSettings.connections
		anchors.fill: parent
		anchors.margins: 10
		spacing: 0
		header: ColumnLayout {
			CutiePageHeader {
				id: header
				title: qsTr("Wi-Fi")
			}
			Text {
				visible: "Strength" in CutieWifiSettings.activeConnection
				text: qsTr("Connected")
				font.pixelSize: u(16)
				font.family: "Lato"
				font.weight: Font.Normal
				horizontalAlignment: Text.AlignLeft
				color: (Atmosphere.variant == "dark") ? "#ffffff" : "#000000"
				Layout.leftMargin: u(20)
				Layout.rightMargin: u(20)
				Layout.topMargin: u(10)
				Layout.bottomMargin: u(3)
			}
			CutieListItem {
				visible: "Strength" in CutieWifiSettings.activeConnection
				icon: visible ? ("qrc:///icons/network-wireless-signal-" + (
					Math.floor((CutieWifiSettings.activeConnection["Strength"] - 1) / 20)
				).toString() + ".svg") : ""
				text: visible ? CutieWifiSettings.activeConnection["DisplayName"] : ""
			}
			Text {
				text: qsTr("Available")
				font.pixelSize: u(16)
				font.family: "Lato"
				font.weight: Font.Normal
				horizontalAlignment: Text.AlignLeft
				color: (Atmosphere.variant == "dark") ? "#ffffff" : "#000000"
				Layout.leftMargin: u(20)
				Layout.rightMargin: u(20)
				Layout.topMargin: u(10)
				Layout.bottomMargin: u(3)
			}
		}

		delegate: CutieListItem {
			visible: CutieWifiSettings.connections[index]["Path"] != CutieWifiSettings.activeConnection["Path"]
			height: visible ? u(30) : 0
			icon: ("qrc:///icons/network-wireless-signal-" + (
				Math.floor((CutieWifiSettings.connections[index]["Strength"] - 1) / 20)
			).toString() + ".svg")
			text: CutieWifiSettings.connections[index]["DisplayName"]
		}
	}
}
