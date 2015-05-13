import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    allowedOrientations: Orientation.All

    SilicaFlickable {
        id: aboutFlickable

        anchors.fill: parent
        contentHeight: about1.height + about2.height + about3.height + about4.height + about5.height + about6.height

        VerticalScrollDecorator {
            flickable: aboutFlickable
        }
        HorizontalScrollDecorator {
            flickable: aboutFlickable
        }

        TextArea {
            id: about1
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            readOnly: true
            wrapMode: TextEdit.Wrap
            text: qsTr("Ielig: Web\nFor your favourite links.")
        }

        TextArea {
            id: about2
            anchors {
                top: about1.bottom
                left: parent.left
                right: parent.right
            }
            readOnly: true
            wrapMode: TextEdit.Wrap
            text: qsTr("Stupid app\nThis app is good for quick information. For ambitious tasks use the native browser.")
        }

        TextArea {
            id: about3
            anchors {
                top: about2.bottom
                left: parent.left
                right: parent.right
            }
            readOnly: true
            wrapMode: TextEdit.Wrap
            text: qsTr("Website navigation\nTap one of the four light grey squares in the corners:\nupper left corner: back\nupper right corner: forward\nlower left corner: back to site list\nlower right corner: stop or reload\n\nLinkStop: Stop unwanted calls when zooming. The first click will be ignored. Manage LinkStop in settings.")
        }

        TextArea {
            id: about4
            anchors {
                top: about3.bottom
                left: parent.left
                right: parent.right
            }
            readOnly: true
            wrapMode: TextEdit.Wrap
            text: qsTr("Privacy\nEnable private mode for enhanced privacy. Activate Javascript only if necessary. Most pages loads faster with disabled javascript. There is a option for temporary activating javascript.")
        }

        TextArea {
            id: about5
            anchors {
                top: about4.bottom
                left: parent.left
                right: parent.right
            }
            readOnly: true
            wrapMode: TextEdit.Wrap
            text: qsTr("Senior\nThis app address the demands of elderly jolla users. If you like to talk about this demands send me a mail: utkiek@public-files.de or lets drink a beer here in Bremen.")
        }

        TextArea {
            id: about6
            anchors {
                top: about5.bottom
                left: parent.left
                right: parent.right
            }
            readOnly: true
            wrapMode: TextEdit.Wrap
            text: qsTr("Open source\nThis app is pure QML with Webview.\nGithub: https://github.com/Utkiek/IeligWeb\nLicense: GPLv3")
        }
    }
}
