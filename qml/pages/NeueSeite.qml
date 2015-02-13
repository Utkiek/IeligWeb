import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: neueSeiteSeite
    allowedOrientations: Orientation.All
    backNavigation: true

    onAccepted: einfuegenNeueSeite()
    property bool editSeite: false
    property string alterTitel;
    property alias seitenTitel: seitenTitel.text
    property alias seitenUrl: seitenUrl.text
    property string dbEigenschaft
    property ListModel seitenListe
    property real neueZoomWeite: 0
    property real neueZoomHoehe: 0

    // Easy fix only for when http:// or https:// is missing
    function fixUrl(nonFixedUrl) {
        var valid = nonFixedUrl
        if (valid.indexOf(":")<0) {
            return "http://"+valid;
        } else return valid
    }

    function einfuegenNeueSeite() {
        var gefixteUrl = fixUrl(seitenUrl.text)
        if (editSeite && alterTitel != "") seitenListe.editSeite(alterTitel,seitenTitel.text,gefixteUrl);
        else seitenListe.neueSeite(seitenTitel.text,gefixteUrl);

        aktPrivatmodus = seitenPrivatmodus.checked;
        editEinstellung(gefixteUrl,"Privatmodus",seitenPrivatmodus.checked.toString());
        aktJavascript = seitenJavascript.checked;
        editEinstellung(gefixteUrl,"Javascript",seitenJavascript.checked.toString());
        aktCookies = seitenCookies.checked;
        editEinstellung(gefixteUrl,"Cookies",seitenCookies.checked.toString());
        aktPlugins = seitenPlugins.checked;
        editEinstellung(gefixteUrl,"Plugins",seitenPlugins.checked.toString());
        //aktZoom = parseFloat(seitenZoom.text);
        editEinstellung(gefixteUrl,"Zoom",seitenZoom.text.toString());
        //console.debug("Speicher " + seitenZoom.text + " " + root.height)
        neueZoomHoehe = root.height * parseFloat(seitenZoom.text)
        neueZoomWeite = root.width * parseFloat(seitenZoom.text)
        editEinstellung(gefixteUrl,"ZoomHöhe",neueZoomHoehe.toString());
        editEinstellung(gefixteUrl,"ZoomWeite",neueZoomWeite.toString());
        aktUseragent = userAgent.value;
        //console.debug("Speicher:" + gefixteUrl + " UserAgent: " + aktUseragent);
        editEinstellung(gefixteUrl,"Useragent",aktUseragent);
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

            TextField {
                id: seitenTitel
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 20
                placeholderText: "Name der Seite"
                focus: true
            }
            TextField {
                id: seitenUrl
                width: parent.width - 20
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: "URL der Seite"
                inputMethodHints: Qt.ImhUrlCharactersOnly
                //visible: editSeite ? false : true
            }
            TextField {
                id: seitenZoom
                label: "Zoom"
                //text: root.aktZoom.toString()
                text: "1"
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                onFocusChanged: if (focus == true) selectAll();
                //placeholderText: "1.5        "
                visible: false;

            }
            TextSwitch {
                id: seitenPrivatmodus
                text: "privates Browsen"
                checked: aktPrivatmodus
            }
            TextSwitch {
                id: seitenJavascript
                text: "Javascript aktivieren"
                checked: aktJavascript
            }
            TextSwitch {
                id: seitenCookies
                text: "Cookies erlauben"
                checked: aktCookies
            }
            TextSwitch {
                id: seitenPlugins
                text: "Plugins erlauben"
                checked: aktPlugins
            }

            ComboBox {
                id: userAgent
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 20
                label: qsTr("ausgeben als")

                menu: ContextMenu {
                    MenuItem { text: userAgentJollaIndex }
                    MenuItem { text: userAgentOperaMini9Index }
                    MenuItem { text: userAgentMozillaDesktop25Index }
                }
            }

        }
    }

}
