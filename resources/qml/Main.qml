import QtQuick
import QtQuick.Particles
import QtQuick.Controls
import "qrc:/resources/scripts/DynamicComponents.js" as Components

Rectangle {
	id: app

	property int daynight_cycle_duration: 24000

	anchors.fill: parent
	radius: 15
	color: "red"
	clip: true

	Sky {
		id: background
		anchors.fill: app
	}

	Weather {
		id: weather
	}

	Rectangle {
		id: foreground
		width: app.width
		height: app.height
		color: "transparent"

		Player {
			id: player
			z: 0
			anchors.centerIn: parent

			sprite: playerSelector.selectedSprite

			function processMovement(key, value) {
				switch (key) {
				case Qt.Key_Left:
					player.movement.isLeft = value
					break
				case Qt.Key_Right:
					player.movement.isRight = value
					break
				case Qt.Key_Up:
					player.movement.isTop = value
					break
				case Qt.Key_Down:
					player.movement.isBottom = value
					break
				}
			}

			onMove: (xOffset, yOffset) => {
					  foreground.x += xOffset
					  foreground.y += yOffset

					  player.anchors.horizontalCenterOffset -= xOffset
					  player.anchors.verticalCenterOffset -= yOffset
				  }

			Keys.onPressed: (e) => {
						    if (e.isAutoRepeat)
						    return

						    processMovement(e.key, true)
					    }
			Keys.onReleased: (e) => {
						     if (e.isAutoRepeat)
						     return

						     processMovement(e.key, false)
					     }

			Behavior on anchors.horizontalCenterOffset {
				NumberAnimation {
					duration: 500
					easing.type: Easing.OutElastic
				}
			}
			Behavior on anchors.verticalCenterOffset {
				NumberAnimation {
					duration: 500
					easing.type: Easing.OutElastic
				}
			}
		}

		Behavior on x {
			NumberAnimation {
				duration: 500
				easing.type: Easing.OutElastic
			}
		}
		Behavior on y {
			NumberAnimation {
				duration: 500
				easing.type: Easing.OutElastic
			}
		}
	}

	Drawer {
		id: drawer
		width: 0.25 * app.width
		height: app.height
		dragMargin: 100

		PlayerSelector {
			id: playerSelector

			selectedSprite: "/resources/images/playersprites/leduc.png"
		}
	}

	RoundButton {
		id: drawerButton
		z: 4
		anchors.margins: 15
		anchors.left: app.left
		anchors.top: app.top
		icon.source: playerSelector.selectedSprite
		onClicked: drawer.open()
	}

	Timer {
		id: valerieTimer

		interval: 50
		triggeredOnStart: true
		running: true
		repeat: true
		onTriggered: {
			Components.spawn("Valerie", foreground,
					     {
						     "anchors.horizontalCenterOffset": Math.random() * app.width / 2 - foreground.x,
						     "anchors.verticalCenterOffset": (Math.random() > 0.5 ? 1 : -1) * Math.random() * app.height / 2,
						     z: Math.random() > 0.5 ? -1 : 1
					     })
		}
	}

	Timer {
		id: weatherTimer
		interval: weather.active ? 50 : 500 // more clouds when raining
		triggeredOnStart: true
		repeat: true
		running: true
		onTriggered: {
			if (!weather.active && Math.random() < 0.03) {
				weather.active = true
			}
			if (weather.active && Math.random() < 0.01) {
				weather.active = false
			}

			Components.spawn("Cloud", foreground,
					     {
						     x: player.anchors.horizontalCenterOffset + app.width + 250,
						     y: Math.random() * app.height * 0.9,
						     z: Math.random() > 0.5 ? -1 : 2,
						     rotation: Math.random() > 0.5 ? 180 : 0
					     })
		}
	}

	NumberAnimation {
		id: startupAnim

		target: app
		properties: "opacity,scale"
		from: 0
		to: 1
		duration: 1000
		easing.type: Easing.InOutBack
		running: true
	}

	RoundButton {
		id: resize_toggle

		z: 2
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		anchors.margins: 15
		icon.source: "/resources/images/icons/resize.png"
		opacity: 0.5
		focusPolicy: Qt.NoFocus

		onPressed: {
			Window.window.startSystemResize(Qt.BottomEdge | Qt.RightEdge)
		}
	}

	MouseArea {
		id: invisible_titlebar

		z: 1
		anchors.top: app.top
		width: app.width
		height: 50
		acceptedButtons: Qt.LeftButton
		onPressed: Window.window.startSystemMove()
	}

	QuitButton {
		target: app
	}
}
