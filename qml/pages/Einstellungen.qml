import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: einstellungsSeite
    allowedOrientations: Orientation.All
    backNavigation: true


    onAccepted: speicherEinstellungen()

    function speicherEinstellungen() {
        aktFontstufe = fontStufe.value;
        editEinstellung(ieligwebUrl,"Fontstufe",aktFonstufe);
    }

    Keys.onEnterPressed: ok();
    Keys.onReturnPressed: ok();

    Flickable {
        width:parent.width
        height: parent.height
        contentHeight: col.height + kopf.height

        DialogHeader {
            id: kopf
            acceptText: editSeite ? qsTr("speichern") : qsTr("speichern")
            cancelText: qsTr("abbrechen")
        }

        Column {
            id: col
            anchors.top: kopf.bottom
            anchors.topMargin: 25
            width: parent.width
            spacing: 25
            function ok() {
                if (seitenTitel.focus == true && editSeite == false) seitenUrl.focus = true
                else if (seitenUrl.focus == true) { seitenUrl.text = fixUrl(seitenUrl.text);}
                else if (seitenTitel.focus == true && editSeite == true) { accepted(); } //pageStack.pop(); }
            }


            ComboBox {
                id: fontStufe
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 20
                label: qsTr("Schriftgröße")

                menu: ContextMenu {
                    MenuItem { text: qsTr("groß") }
                    MenuItem { text: qsTr("normal") }
                    MenuItem { text: qsTr("klein") }
                }
            }
        }
    }

}
