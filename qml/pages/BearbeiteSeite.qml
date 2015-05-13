import QtQuick 2.0
import Sailfish.Silica 1.0
import "helper/globs.js" as Globs

Page
{
    id: bearbeiteSeite
    allowedOrientations: Orientation.All
    backNavigation: false


    SilicaListView {
        id: auflistung
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        VerticalScrollDecorator {flickable: auflistung}
        model: seitenListe
        PullDownMenu {
            MenuItem {
                text: qsTr("About IeligWeb")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("Einstellungen.qml"), { seitenListe: seitenListe})
            }
            MenuItem {
                text: qsTr("Add url")
                onClicked: {
                    aktPrivatmodus = true
                    aktDoppelklick = true
                    pageStack.push(Qt.resolvedUrl("NeueSeite.qml"), { seitenListe: seitenListe})
                }
            }
        }


        header: PageHeader {
            id: topPanel
            title: "Ielig: Web"
        }

        TextArea {
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: TextEdit.AlignHCenter
            font.pixelSize: Theme.fontSizeHuge
            color: Theme.highlightColor
            font.family: Theme.fontFamily
            readOnly: true
            wrapMode: TextEdit.Wrap
            text: qsTr("Add a web page")
            visible: seitenListe.count == 0
        }

        delegate: ListItem {
            id: myListItem
            property bool menuOpen: contextMenu != null && contextMenu.parent === myListItem
            property Item contextMenu

            height: menuOpen ? contextMenu.height + contentItem.height : contentItem.height

            function loesche() {
                var loeschbar = removalComponent.createObject(myListItem)
                ListView.remove.connect(loeschbar.deleteAnimation.start)
                loeschbar.execute(contentItem, "Delete " + titel, function() { seitenListe.loescheSeite(url); } )
            }

            function schreibeSeite() {
                leseSeiteneinstellungen(url);
                pageStack.push(Qt.resolvedUrl("NeueSeite.qml"), { seitenListe: seitenListe, editSeite: true, alterTitel: titel, seitenTitel: titel, seitenUrl: url});
            }


            BackgroundItem {
                id: contentItem
                Label {
                    text: titel
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: contentItem.down || menuOpen ? Theme.highlightColor : Theme.primaryColor
                    font.pixelSize: Globs.gibThemeFontgroesse(aktFontstufe)
                }
                onClicked: {
                    Globs.nimmAktTitel(titel);
                    leseSeiteneinstellungen(url);
                    pageStack.clear()
                    pageStack.push(Qt.resolvedUrl("ZeigeSeite.qml"), {seitenUrl: url})
                }
                onPressAndHold: {
                    if (!contextMenu)
                        contextMenu = contextMenuComponent.createObject(auflistung)
                    contextMenu.show(myListItem)
                }
            }
            Component {
                id: removalComponent
                RemorseItem {
                    property QtObject deleteAnimation: SequentialAnimation {
                        PropertyAction { target: myListItem; property: "ListView.delayRemove"; value: true }
                        NumberAnimation {
                            target: myListItem
                            properties: "height,opacity"; to: 0; duration: 300
                            easing.type: Easing.InOutQuad
                        }
                        PropertyAction { target: myListItem; property: "ListView.delayRemove"; value: false }
                    }
                    onCanceled: destroy();
                }
            }
            Component {
                id: contextMenuComponent
                ContextMenu {
                    id: menu
                    MenuItem {
                        text: qsTr("Edit")
                        onClicked: {
                            menu.parent.schreibeSeite();
                        }
                    }
                    MenuItem {
                        text: qsTr("Delete")
                        onClicked: {
                            menu.parent.loesche();
                        }
                    }
                }
            }
        }
    }
}
