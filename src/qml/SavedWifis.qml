import Cutie 1.0
import QtQuick 2.14
import QtQuick.Layouts 1.15

CutiePage {
	ListView {
		model: CutieWifiSettings.savedConnections
		anchors.fill: parent
		anchors.margins: 10
		spacing: 0

		header: ColumnLayout {
			width: parent.width
			CutiePageHeader {
				id: header
				title: qsTr("Saved Networks")
			}
		}

		delegate: Item {
			height: litem.height
			width: parent.width
			CutieListItem {
				id: litem
				text: "connection" in modelData.data ? ("id" in modelData.data.connection ? modelData.data.connection.id: "") : ""
				subText: CutieWifiSettings.activeAccessPoint 
					&& "Ssid" in CutieWifiSettings.activeAccessPoint.data 
					&& "connection" in modelData.data ?
					(CutieWifiSettings.activeAccessPoint.data["Ssid"] == modelData.data.connection.id 
					? qsTr("Connected") :
					((CutieWifiSettings.accessPoints.filter(
					e => e.data["Ssid"] == modelData.data.connection.id)
					.length > 0) ? qsTr("Available") : qsTr("Unavailable"))) : ""
				icon: CutieWifiSettings.activeAccessPoint 
					&& "Ssid" in CutieWifiSettings.activeAccessPoint.data 
					&& "connection" in modelData.data &&
					(CutieWifiSettings.accessPoints.filter(
					e => e.data["Ssid"] == modelData.data.connection.id)
					.length > 0) ? ("qrc:///icons/network-wireless-signal-" + (
					Math.floor((CutieWifiSettings.accessPoints.filter(
					e => e.data["Ssid"] == modelData.data.connection.id
					)[0].data["Strength"] - 1) / 20)
					).toString() + ".svg") 
					: "qrc:///icons/network-wireless-offline.svg"
				onClicked: {
					CutieWifiSettings.activateConnection(modelData, null);
					CutieWifiSettings.requestScan();
				}
			}
		}
	}
}
