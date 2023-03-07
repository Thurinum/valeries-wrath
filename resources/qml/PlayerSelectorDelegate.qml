import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

MouseArea {
    width: 200
    height: 200

    property string rootPath
    property string spritePath

    signal selected(spritePath: string)

    function capitalize(str) {
        return str.charAt(0).toUpperCase() + str.substring(1, str.length)
    }

    onClicked: selected(rootPath + spritePath)

    Column {
        anchors.fill: parent
        spacing: 10

        Image {
            id: image

            anchors.horizontalCenter: parent.horizontalCenter
            source: rootPath + spritePath
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: capitalize(spritePath.split('.')[0])
            font.pointSize: 16
        }
    }
}
