import QtQuick
import QtQuick.Particles
import "qrc:/resources/scripts/DynamicComponents.js" as Components

Item {
	id: root

	anchors.fill: parent

	Rectangle {
		id: background

		anchors.fill: root

		gradient: Gradient {
			GradientStop { id: sunGradient; position: 0.0; color: "orange" }
			GradientStop { position: 1.0; color: "white" }
		}

		states: [
			State {
				name: "dawn_dusk"
				when: (sun.value >= 0 && sun.value <= 0.1) || (sun.value > 0.4 && sun.value <= 0.5)

				PropertyChanges {
					sunGradient {
						color: "orange"
					}
				}
			},
			State {
				name: "day"
				when: sun.value > 0.1 && sun.value <= 0.4

				PropertyChanges {
					sunGradient {
						color: "lightblue"
					}
				}
			},
			State {
				name: "night"
				when: sun.value > 0.5 && sun.value <= 1

				PropertyChanges {
					sunGradient {
						color: "darkblue"
					}
				}
			}
		]

		transitions: Transition {
			ColorAnimation {
				target: sunGradient
				duration: 10000
			}
		}
	}

	Timer {
		id: sun

		property double value: 0

		repeat: true
		running: true
		interval: 500
		onTriggered: {
			if (value >= 0.98)
				value = 0
			else
				value += 0.01

		}
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
		interval: weather.active ? 50 : 500
		triggeredOnStart: true
		repeat: true
		running: true
		onTriggered: {
			if (Math.random() < 0.01) {
				weather.active = !weather.active
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
}
