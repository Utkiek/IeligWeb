import QtQuick 2.0
import Sailfish.Silica 1.0

Page
{
    id: bearbeiteSeite    
    allowedOrientations: Orientation.All
    backNavigation: true

    SilicaListView {
        id: auflistung
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        VerticalScrollDecorator {}
        model: seitenListe
        PullDownMenu {
            MenuItem {
                text: "über IeligWeb"
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
            MenuItem {
                text: "neue Seite"
                onClicked: pageStack.push(Qt.resolvedUrl("NeueSeite.qml"), { seitenListe: seitenListe})
            }
        }


        header: PageHeader {
            id: topPanel
            title: qsTr("Ielig: Web")
        }
        delegate: ListItem {
            id: myListItem
            property bool menuOpen: contextMenu != null && contextMenu.parent === myListItem
            property Item contextMenu

            height: menuOpen ? contextMenu.height + contentItem.height : contentItem.height

            function loesche() {
                var loeschbar = removalComponent.createObject(myListItem)
                ListView.remove.connect(loeschbar.deleteAnimation.start)
                loeschbar.execute(contentItem, "Lösche " + titel, function() { seitenListe.loescheSeite(url); } )
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
                }
                onClicked: {
                    clearCookies();
                    clearCache();
                    leseSeiteneinstellungen(url);
                    //console.debug("ZEIGE Seite: Aufruf von:" + titel + " " + url + " UserAgent: " + aktUseragent);
                    //if (aktZoom == 0) {
                    //    aktZoom = 1
                    //}
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
                        text: qsTr("bearbeiten")
                        onClicked: {
                            menu.parent.schreibeSeite();
                        }
                    }
                    MenuItem {
                        text: qsTr("löschen")
                        onClicked: {
                            menu.parent.loesche();
                        }
                    }
                }
            }
        }
    }
}
