import QtQuick

Image {
	id: enemy

	width: 100
	height: 100
	source: "/resources/images/valerie.png"
	anchors.centerIn: parent
	scale: 0

	Behavior on scale {
		NumberAnimation {
			duration: 300
			easing.type: Easing.OutBounce
		}
	}

	Component.onCompleted: {
		scale = 1
	}
}
