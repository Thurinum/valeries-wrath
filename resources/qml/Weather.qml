import QtQuick
import QtQuick.Particles

Emitter {
	id: weather

	property bool active: false

	ParticleSystem {
		id: weatherSystem
	}

	anchors.fill: root
	anchors.verticalCenterOffset: 200

	system: weatherSystem
	emitRate: active ? 10000 : 0
	lifeSpan: 500
	lifeSpanVariation: 250
	size: 2
	endSize: 3
	velocity: AngleDirection {
		angle: 135
		angleVariation: 5
		magnitude: 1000
		magnitudeVariation: 250
	}

	ImageParticle {
		source: "/resources/images/valerie.png"
		system: weatherSystem
		color: "lightblue"
	}
}
