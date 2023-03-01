import QtQuick

Rectangle {
    id: sky

    gradient: Gradient {
        GradientStop {
            id: horizon
            position: 0.0
            color: "orange"
        }
        GradientStop { position: 1.0; color: "white" }
    }

    SequentialAnimation {
        id: animation
        loops: Animation.Infinite
        running: true

        property double transitionDuration: 0.05

        ColorAnimation {
            target: horizon
            property: "color"
            from: "orange"
            to: "lightblue"
            duration: root.daynight_cycle_duration * animation.transitionDuration
        }
        PauseAnimation {
            duration: root.daynight_cycle_duration * 0.3
        }
        ColorAnimation {
            target: horizon
            property: "color"
            from: "lightblue"
            to: "orange"
            duration: root.daynight_cycle_duration * animation.transitionDuration
        }
        PauseAnimation {
            duration: root.daynight_cycle_duration * 0.1
        }
        ColorAnimation {
            target: horizon
            property: "color"
            from: "orange"
            to: "darkblue"
            duration: root.daynight_cycle_duration * animation.transitionDuration
        }
        PauseAnimation {
            duration: root.daynight_cycle_duration * 0.3
        }
        ColorAnimation {
            target: horizon
            property: "color"
            from: "darkblue"
            to: "orange"
            duration: root.daynight_cycle_duration * animation.transitionDuration
        }
        PauseAnimation {
            duration: root.daynight_cycle_duration * 0.1
        }
    }
}
