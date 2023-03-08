import QtQuick
import QtQuick.Controls

Rectangle {
	id: quitBtn

	required property var target

	width: 60
	height: 40
	z: 3
	anchors.right: target.right
	anchors.top: target.top
	color: mousearea.containsMouse ? "#300c33" : "#401f66"
	opacity: 0.8
	radius: app.radius
	anchors.margins: 15

	Label {
		anchors.centerIn: parent
		text: "X"
		color: "white"
		font.family: "Segoe UI"
	}

	MouseArea {
		id: mousearea

		anchors.fill: quitBtn
		hoverEnabled: true
		focus: false

		onClicked: closeAnim.start()
	}

	NumberAnimation {
		id: closeAnim

		target: quitBtn.target
		properties: "opacity,scale"
		from: 1
		to: 0
		duration: 1000
		easing.type: Easing.InOutBack

		onFinished: Qt.quit()
	}
}
