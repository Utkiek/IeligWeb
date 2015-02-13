import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    allowedOrientations: Orientation.All

    Label {
        x: Theme.paddingLarge
        text: "Ielig: Web - experimentale Version\n\n Speichern Sie Ihre Seite mit Ihren seitenspezifischen Einstellungen\n\nBei Anzeige einer Webseite haben Sie 4 Navigationsmöglichkeiten:\nlinke obere Ecke: zurück zur Seitenauswahl\nobere rechte Ecke: Seite wird neu geladen\nuntere linke Ecke: zurück (letzte Webseite)\nuntere rechte Ecke: vor (folgende Webseite)"
    }
    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        text: "zurück"
        onClicked: pageStack.pop()
    }
}
