import QtQuick
import QtQuick.Particles

Emitter {
    id: player

	property color particlesColor: Qt.rgba(0.1, 0.1, 0.1, 0.4)
    property double speed: 100

    QtObject {
        id: movement
        property bool isLeft: false
        property bool isRight: false
        property bool isTop: false
        property bool isBottom: false
        property bool isMoving: isLeft || isRight || isTop || isBottom
    }
    property alias movement: movement

    width: 100
	height: 40
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
            when: movement.isMoving

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
		fillMode: Image.PreserveAspectFit
        height: player.height + 50
		anchors.centerIn: parent
        source: "/resources/images/cloud.png"
	}

    function move() {
        let xOffset = 0;
        let yOffset = 0;

        if (movement.isLeft) {
            xOffset += player.speed
        }

        if (movement.isRight) {
            xOffset -= player.speed
        }

        if (movement.isTop) {
            yOffset += player.speed
        }

        if (movement.isBottom) {
            yOffset -= player.speed
        }

        foreground.x += xOffset
        player.anchors.horizontalCenterOffset -= xOffset

        foreground.y += yOffset
        player.anchors.verticalCenterOffset -= yOffset
    }
}
