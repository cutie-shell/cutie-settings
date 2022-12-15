import Cutie 1.0
import QtQuick 2.14

CutiePage {
	Component.onDestruction: {
		console.log("D'oh!")
	}

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
			text: CutieWifiSettings.connections[index]["DisplayName"]
		}

		Component.onCompleted: {
			console.log(CutieWifiSettings.connections);
		}
	}
}
