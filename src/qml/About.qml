import Cutie 1.0
import QtQuick 2.14
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.14

CutiePage {
	id: aboutPage
	CutiePageHeader {
		id: header
		title: qsTr("About")
	}

	Image {
		id: logo
		width: height * sourceSize.width / sourceSize.height
		height: (parent.width - 80) / 3
		anchors.top: header.bottom
		anchors.topMargin: 20
		anchors.horizontalCenter: parent.horizontalCenter
		source: "qrc:///icons/cutie.png"
	}

	Text {
		text: "Cutie Shell"
		font.family: "Lato"
		font.pixelSize: 20
		color: (Atmosphere.variant == "dark") ? "#ffffff" : "#000000"
		anchors.top: logo.bottom
		anchors.topMargin: 10
		anchors.horizontalCenter: parent.horizontalCenter
	}
}