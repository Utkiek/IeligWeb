import QtQuick 2.0
import Sailfish.Silica 1.0
import "helper/globs.js" as Globs

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
        //aktZoom = parseFloat(seitenZoom.text);
        //editEinstellung(gefixteUrl,"Zoom",seitenZoom.text.toString());
        //neueZoomHoehe = haupt.height * parseFloat(seitenZoom.text)
        //neueZoomWeite = haupt.width * parseFloat(seitenZoom.text)
        //editEinstellung(gefixteUrl,"ZoomHöhe",neueZoomHoehe.toString());
        //editEinstellung(gefixteUrl,"ZoomWeite",neueZoomWeite.toString());
        aktUseragent = userAgent.value;
        editEinstellung(gefixteUrl,"Useragent",aktUseragent);
        aktseitenFontstufe = seitenfontStufe.currentIndex;
        editEinstellung(gefixteUrl,"Font",seitenfontStufe.currentIndex);
        aktDoppelklick = seitenDoppelklick.checked;
        editEinstellung(gefixteUrl,"Doppelklick",seitenDoppelklick.checked.toString());
    }

    Keys.onEnterPressed: einfuegenNeueSeite();
    Keys.onReturnPressed: einfuegenNeueSeite();

    Flickable {
        width:parent.width
        height: parent.height
        contentHeight: col.height + kopf.height

        DialogHeader {
            id: kopf
            acceptText: editSeite ? qsTr("Save") : qsTr("Save")
            cancelText: qsTr("Cancel")
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
                placeholderText: qsTr("Name")
                focus: true
                font.pixelSize: Globs.gibThemeFontgroesse(aktFontstufe)
            }
            TextField {
                id: seitenUrl
                width: parent.width - 20
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("URL")
                inputMethodHints: Qt.ImhUrlCharactersOnly
                font.pixelSize: Globs.gibThemeFontgroesse(aktFontstufe)
            }
            //TextField {
            //    id: seitenZoom
            //    label: qsTr("Zoom")
            //    text: "1"
            //    inputMethodHints: Qt.ImhFormattedNumbersOnly
            //    onFocusChanged: if (focus == true) selectAll();
            //    placeholderText: "1.5        "
            //    font.pixelSize: Globs.gibThemeFontgroesse(aktFontstufe)

            //}
            TextSwitch {
                id: seitenPrivatmodus
                text: qsTr("Private mode")
                checked: aktPrivatmodus
            }
            TextSwitch {
                id: seitenJavascript
                text: qsTr("Activate javascript")
                checked: aktJavascript
            }
            TextSwitch {
                id: seitenCookies
                text: qsTr("Allow cookies")
                checked: aktCookies
            }
            TextSwitch {
                id: seitenDoppelklick
                text: qsTr("LinkStop (ignore first click)")
                checked: aktDoppelklick
            }

            ComboBox {
                id: userAgent
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 20
                label: qsTr("User agent")

                menu: ContextMenu {
                    MenuItem { text: userAgentJollaIndex }
                    MenuItem { text: userAgentOperaMini9Index }
                    MenuItem { text: userAgentMozillaDesktop25Index }
                }
            }

            ComboBox {
                id: seitenfontStufe
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 20
                label: qsTr("Font size")
                currentIndex: aktseitenFontstufe

                menu: ContextMenu {
                    MenuItem { text: qsTr("big") }
                    MenuItem { text: qsTr("normal") }
                    MenuItem { text: qsTr("small") }
                }
            }
        }
    }

}
