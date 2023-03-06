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
                    duration: 50
                    easing.type: Easing.OutQuad
                }
            }
            Behavior on anchors.verticalCenterOffset {
                NumberAnimation {
                    duration: 50
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
        Behavior on y {
            NumberAnimation {
                duration: 50
                easing.type: Easing.OutQuad
            }
        }
    }

    Drawer {
        id: drawer
        width: 0.25 * root.width
        height: root.height
        dragMargin: 100

        PlayerSelector {
            id: playerSelector

            selectedSprite: "/resources/images/playersprites/leduc.png"
        }
    }

    Timer {
        id: valerieTimer

        interval: 50
        triggeredOnStart: true
        running: false
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
                                 x: player.anchors.horizontalCenterOffset + root.width + 250,
                                 y: Math.random() * root.height * 0.9,
                                 z: Math.random() > 0.5 ? -1 : 2,
                                 rotation: Math.random() > 0.5 ? 180 : 0
                             })
        }
    }
}
