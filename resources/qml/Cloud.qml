import QtQuick

Image {
    id: cloud

    width: Math.max(250, Math.random() * 500)
    fillMode: Image.PreserveAspectFit
    source: "/resources/images/cloud.png"
    opacity: 0.85

    NumberAnimation {
	    target: cloud
	    property: "x"
	    to: -width

	    duration: 10000 + x
	    easing.type: Easing.Bezier
	    running: true
    }
}
