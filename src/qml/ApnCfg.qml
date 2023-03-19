import Cutie
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

CutiePage {
	id: apnPage
	property var apnData: null

	CutiePageHeader {
		id: header
		title: "Access Point Name"
		description: !apnData ? "Create new Access Point Name" : "Edit Access Point Name"
	}

	GridLayout {
		anchors.top: header.bottom
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.margins: 20
		columnSpacing : 25
		rowSpacing: 15
		columns: 2

		CutieLabel {
			text: "Name:";
			Layout.alignment: Qt.AlignBottom
			verticalAlignment: Text.AlignBottom
		}
		CutieTextField {
			id: connName
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignRight
			horizontalAlignment: TextInput.AlignHCenter
			text: !apnData ? "" : apnData.name;
		}

		CutieLabel {
			text: "AccessPointName:";
			Layout.alignment: Qt.AlignBottom
			verticalAlignment: Text.AlignBottom
		}
		CutieTextField {
			id: connApn
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignRight
			horizontalAlignment: TextInput.AlignHCenter
			text: !apnData ? "" : apnData.apn;
		}

		CutieButton {
			Layout.columnSpan: 2
			Layout.topMargin: 15
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignBottom
			text: !apnData ? "Add" : "Update"
			onClicked: {
				if(!apnData){
					CutieMobileNetwork.addAndActivateConnection(connName.displayText, connApn.displayText);
					mainWindow.pageStack.pop();
				} else {
					CutieMobileNetwork.updateConnection(apnData.path, connName.displayText, connApn.displayText);
					mainWindow.pageStack.pop();
				}
			}
		}
	}
}