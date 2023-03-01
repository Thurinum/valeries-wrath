import QtQuick
import QtQuick.Particles
import QtQuick.Controls
import "qrc:/resources/scripts/DynamicComponents.js" as Components

Item {
	id: root

    property int daynight_cycle_duration: 24000

	anchors.fill: parent

    Sky {
        id: background
        anchors.fill: root
    }

	Weather {
		id: weather
	}

	Rectangle {
		id: foreground
		width: root.width
		height: root.height
		color: "transparent"

		Player {
			id: player
			z: 0
			anchors.centerIn: parent


			Keys.onLeftPressed: {
				player.anchors.horizontalCenterOffset -= player.speed
				foreground.x += player.speed
				isMoving = true
			}
			Keys.onRightPressed: {
				player.anchors.horizontalCenterOffset += player.speed
				foreground.x -= player.speed
				isMoving = true
			}

			Keys.onUpPressed: {
				player.anchors.verticalCenterOffset -= player.speed / 2
				isMoving = true
			}
			Keys.onDownPressed: {
				player.anchors.verticalCenterOffset += player.speed / 2
				isMoving = true
			}

			Keys.onReleased: (e) => {
						     if (e.isAutoRepeat)
						     return
						     isMoving = false
					     }


			Behavior on anchors.horizontalCenterOffset {
				NumberAnimation {
					duration: 50
					easing.type: Easing.OutQuad
				}
			}
			Behavior on anchors.verticalCenterOffset {
				NumberAnimation {
					duration: 100
					easing.type: Easing.OutQuad
				}
			}
		}

		Behavior on x {
			NumberAnimation {
				duration: 50
				easing.type: Easing.OutQuad
			}
		}
	}

	Timer {
		id: enemyTimer

        interval: 50
		triggeredOnStart: true
		running: true
		repeat: true
		onTriggered: {
			Components.spawn("Valerie", foreground,
					     {
						     "anchors.horizontalCenterOffset": Math.random() * root.width / 2 - foreground.x,
						     "anchors.verticalCenterOffset": (Math.random() > 0.5 ? 1 : -1) * Math.random() * root.height / 2,
                             z: Math.random() > 0.5 ? -1 : 1
					     })
		}
	}

	Timer {

		id: cloudTimer
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
						     x: player.anchors.horizontalCenterOffset + root.width + 250,
						     y: Math.random() * root.height * 0.9,
						     z: Math.random() > 0.5 ? -1 : 2,
						     rotation: Math.random() > 0.5 ? 180 : 0
					     })
		}
	}

    Button {
        text: "owo"
        onClicked: {
            Backend.blah()

//            Backend.name = "dummy"
//            console.log(Backend.name)
        }
    }

}
