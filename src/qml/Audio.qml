import Cutie 1.0
import QtQuick 2.14
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.14

CutiePage {
	id: audioPage
	CutiePageHeader {
		id: header
		title: qsTr("Audio")
		width: parent.width

		CutieToggle {
			id: muteToggle
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			anchors.margins: 10
			value: !CutieVolume.muted

			onToggled: {
				CutieVolume.muted = !value;
			}
			Connections {
				target: CutieVolume
				function onMutedChanged(m) {
					muteToggle.value = !m;
				}
			}
		}
	}

	CutieSlider {
		id: volSlider
		value: CutieVolume.volume
		anchors.top: header.bottom
		anchors.topMargin: 20
		anchors.horizontalCenter: parent.horizontalCenter
		width: parent.width - 40
		onMoved: {
			CutieVolume.volume = value;
		}
		Connections {
			target: CutieVolume
			function onVolumeChanged(vol) {
				volSlider.value = vol;
			}
		}
	}
}