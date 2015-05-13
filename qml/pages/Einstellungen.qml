import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: einstellungsSeite
    allowedOrientations: Orientation.All

    onAccepted: speicherEinstellungen()

    function speicherEinstellungen() {
        aktFontstufe = fontStufe.currentIndex;
        editEinstellung(ieligwebUrl,"Fontstufe",aktFontstufe);
    }

    Keys.onEnterPressed: speicherEinstellungen();
    Keys.onReturnPressed: speicherEinstellungen();

    Flickable {
        width:parent.width
        height: parent.height
        contentHeight: col.height + kopf.height

        DialogHeader {
            id: kopf
            acceptText: qsTr("Save")
            cancelText: qsTr("Cancel")
        }

        Column {
            id: col
            anchors.top: kopf.bottom
            anchors.topMargin: 25
            width: parent.width
            spacing: 25

            ComboBox {
                id: fontStufe
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 20
                label: qsTr("Font size")
                currentIndex: aktFontstufe

                menu: ContextMenu {
                    MenuItem { text: qsTr("small") }
                    MenuItem { text: qsTr("normal") }
                    MenuItem { text: qsTr("big") }
                }
            }
        }
    }

}
