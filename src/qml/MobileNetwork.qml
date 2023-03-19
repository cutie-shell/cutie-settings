import Cutie
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

CutiePage {
	id: mobileDataPage
	property var apnPage: Qt.createComponent("ApnCfg.qml")

	CutieListView {
		id: contextList
		model: CutieMobileNetwork.availableConnections
		anchors.fill: parent
		spacing: 0

		header: ColumnLayout {
			width: parent.width
			CutiePageHeader {
				id: header
				title: qsTr("Mobile Network")
				width: parent.width

				CutieToggle {
					id: networkToggle
					anchors.right: parent.right
					anchors.verticalCenter: parent.verticalCenter
					anchors.verticalCenterOffset: 5
					anchors.rightMargin: 15
					checked: CutieMobileNetwork.cellularEnabled

					onToggled: {
						CutieMobileNetwork.cellularEnabled = checked;
					}
				}
			}

			Row {
				id: mDataRow
				Layout.leftMargin: 20
				Layout.rightMargin: 20
				Layout.topMargin: 10
				Layout.bottomMargin: 3
				CutieLabel {
					text: qsTr("Mobile Data")
					horizontalAlignment: Text.AlignLeft
					topPadding: 10
					bottomPadding: 10
				}
				CutieToggle {
					id: dataToggle
					checked: CutieMobileNetwork.mobileDataEnabled

					onToggled: {
						CutieMobileNetwork.mobileDataEnabled = checked;
					}
				}
			}

			CutieLabel {
				text: qsTr("Access Point Names")
				horizontalAlignment: Text.AlignLeft
				Layout.leftMargin: 20
				Layout.rightMargin: 20
				Layout.topMargin: 10
				Layout.bottomMargin: 3
			}

			CutieButton {
				visible: contextList.model.length < 1
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignBottom
				Layout.leftMargin: 20
				Layout.rightMargin: 20
				Layout.topMargin: 10
				Layout.bottomMargin: 3
				text: "+"
				onClicked: {
					mainWindow.pageStack.push(mobileDataPage.apnPage);
				}
			}
		}

		delegate: Item {
			height: litem.height
			width: parent ? parent.width : 0
			CutieListItem {
				id: litem
				text: modelData.name
				subText: modelData.apn
				onClicked: {
					mainWindow.pageStack.push(mobileDataPage.apnPage, {apnData: modelData});
				}
			}
		}
	}
}