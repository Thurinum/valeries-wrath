import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.folderlistmodel

ColumnLayout {
    id: selector

    property string selectedSprite

    anchors.fill: parent
    anchors.margins: 25
    spacing: 10

    Label {
        text: "<h1>Choose your character</h1>"
        Layout.alignment: Qt.AlignHCenter
    }

    ListView {
        id: listView

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

        delegate: PlayerSelectorDelegate {}
    }
}
