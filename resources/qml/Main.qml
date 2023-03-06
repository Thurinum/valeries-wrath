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

            property var movementState: {
                "isLeft": false,
                "isRight": false,
                "isTop": false,
                "isBottom": false
            }

            Keys.onPressed: (e) => {
                                if (e.isAutoRepeat) {
                                    return
                                }

                                keyStateChanged(e.key, true)
                            }

            Keys.onReleased: (e) => {
                                 if (e.isAutoRepeat) {
                                     return
                                 }

                                 keyStateChanged(e.key, false)
                             }

            function keyStateChanged(key, value) {
                switch (key) {
                case Qt.Key_Left:
                    movementState.isLeft = value
                    break
                case Qt.Key_Right:
                    movementState.isRight = value
                    break
                case Qt.Key_Up:
                    movementState.isTop = value
                    break
                case Qt.Key_Down:
                    movementState.isBottom = value
                    break
                }

                player.isMoving = (movementState.isLeft || movementState.isRight || movementState.isTop || movementState.isBottom)

                if (player.isMoving)
                    rightTimer.start()
                else rightTimer.stop()
            }

            function move() {
                let xOffset = 0;
                let yOffset = 0;

                if (movementState.isLeft) {
                    xOffset += player.speed
                }

                if (movementState.isRight) {
                    xOffset -= player.speed
                }

                if (movementState.isTop) {
                    yOffset += player.speed
                }

                if (movementState.isBottom) {
                    yOffset -= player.speed
                }

                console.log("Let's move" + Math.random())

                foreground.x += xOffset
                player.anchors.horizontalCenterOffset -= xOffset

                foreground.y += yOffset
                player.anchors.verticalCenterOffset -= yOffset
            }

            Timer {
                id: rightTimer
                interval: 50
                running: player.movementState.isRight
                repeat: true
                triggeredOnStart: true
                onTriggered: {
                    player.move()
                }
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

    Timer {
        id: enemyTimer

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
