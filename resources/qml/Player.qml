import QtQuick
import QtQuick.Particles

Emitter {
	id: player

	property color particlesColor: Qt.rgba(0.1, 0.1, 0.1, 0.4)
	property double speed: 100

	property bool isMoving: false

	width: 100
	height: 100
	focus: true
	system: playerTrail
	emitRate: 10000
	lifeSpan: 0
	lifeSpanVariation: 0
	size: 8
	endSize: 24
	velocity: AngleDirection {
		angle: 180
		angleVariation: 5
		magnitude: 1000
		magnitudeVariation: 250
	}
	velocityFromMovement: -15

	states: [
		State {
			when: isMoving

			PropertyChanges {
				player {
					lifeSpan: 1000
					lifeSpanVariation: 50
					particlesColor: Qt.rgba(1.0, 0.9, 0.9, 0.6)
				}
			}
		}
	]

	transitions: Transition {
		reversible: true

		NumberAnimation {
			properties: "lifeSpan,lifeSpanVariation"
			easing.type: Easing.InOutQuad
			duration: 1000
		}
		ColorAnimation {
			easing.type: Easing.InOutQuad
			duration: 1000
		}
	}


	ParticleSystem {
		id: playerTrail
	}

	ImageParticle {
		source: "/resources/images/valerie.png"
		system: playerTrail
		color: player.particlesColor
	}

	Image {
		id: playerSprite
		anchors.fill: parent
		source: "/resources/images/player.png"
	}
}
