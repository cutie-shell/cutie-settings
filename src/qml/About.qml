import Cutie
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

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