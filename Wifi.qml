import Cutie 1.0
import QtQuick 2.14

CutiePage {
	ListView {
		model: CutieWifiSettings.connections
		anchors.fill: parent
		anchors.margins: 10
		spacing: 0
		header: CutiePageHeader {
			id: header
			title: qsTr("Wi-Fi")
		}

		delegate: CutieListItem {
			icon: ("qrc:///icons/network-wireless-signal-" + (
				Math.floor((CutieWifiSettings.connections[index]["Strength"] - 1) / 20)
			).toString() + ".svg")
			text: CutieWifiSettings.connections[index]["DisplayName"]
		}
	}
}
