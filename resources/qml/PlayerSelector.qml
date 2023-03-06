import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.folderlistmodel

ColumnLayout {
    anchors.fill: parent
    anchors.margins: 25

    spacing: 10

    Label {
        text: "<h1>Choose your character</h1>"
        Layout.alignment: Qt.AlignHCenter
    }

    ListView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true

        orientation: Qt.Vertical
        spacing: 25

        model: FolderListModel {
            id: spritesFolder

            property string path: "/resources/images/playersprites/"

            nameFilters: ["*.png"]
            folder: "qrc:" + path
        }

        delegate: Column {
            anchors.horizontalCenter: parent?.horizontalCenter ?? undefined
            spacing: -5

            Label {
                text: "<h2>" + fileName.split(".")[0] + "</h2>"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                width: 100
                height: 100
                source: spritesFolder.path + fileName
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
