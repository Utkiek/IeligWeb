import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
//import QtWebKit.experimental 1.0

//rschroll.github.io/beru/2013/08/21/qtwebview.experimental.html
Page {
    id: page
    allowedOrientations: Orientation.All
    backNavigation: false
    forwardNavigation: false
    showNavigationIndicator: false

    property string seitenUrl

    function gibTextJavascriptAnAus() {
        if (aktJavascript) {return qsTr("Javascript aus")}
            else {return qsTr("Javascript ein")};
    }

    SilicaWebView {
        id: webView

        width: page.width
        height: page.height

        url: seitenUrl
        objectName: "SWebView"

        //die Einstellmöglichkeiten sind sehr schlecht in WebView
        experimental {
            preferences {
                javascriptEnabled: aktJavascript;
                cookiesEnabled: aktCookies;
                pluginsEnabled: aktPlugins;
                offlineWebApplicationCacheEnabled: aktOfflinecache;
                localStorageEnabled: aktLokalerspeicher;
                //javaEnabled: aktJava;
                //xssAuditingEnabled: false;
                privateBrowsingEnabled: aktPrivatmodus;
                //dnsPrefetchEnabled: false;

                minimumFontSize: minimumFontSize;
                defaultFontSize: defaultFontSize;
                defaultFixedFontSize: defaultFixedFontSize;

                // von WebCat:Scale the websites like g+ and others a little bit for better reading
                fullScreenEnabled: true
                developerExtrasEnabled: true
                //contentsScale: aktZoom;
           }

            //itemSelector: PopOver {}
            transparentBackground: false
            userAgent: gibUserAgent()
        }
        smooth: true;
        //preferredWidth: root.width
        //preferredHeight: root.height
        //pressGrabTime: 800;
        //setZoomFactor: aktZoom;
        //settings.setZoomFactor: aktZoom
        //implicitHeight: root.height * aktZoom
        //implicitWidth: root.width *aktZoom
        //width: root.width * aktZoom
        //height: root.height *aktZoom
        //scale: aktZoom
        //x: 0
        //y: 0
        //on_webPageChanged: {
        //    scaled =true
        //    webView.returnToBounds()
        //}
        //transformOrigin: root.TopLeft

        PullDownMenu {
            MenuItem {
                text: "diese Seite speichern"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("neueSeite.qml"), { seitenListe: seitenListe, editSeite: true, alterTitel: "", seitenTitel: "", seitenUrl: webView.url});
                    editEinstellung(Qt.resolvedUrl("neueSeite.qml"),"Privatmodus",seitenPrivatmodus.toString());
                    editEinstellung(Qt.resolvedUrl("neueSeite.qml"),"Javascript",seitenJavascript.toString());
                    editEinstellung(Qt.resolvedUrl("neueSeite.qml"),"Cookies",seitenCookies.toString());
                    editEinstellung(Qt.resolvedUrl("neueSeite.qml"),"Plugins",seitenPlugins.toString());
                    //editEinstellung(Qt.resolvedUrl("neueSeite.qml"),"Java",seitenJavascript.toString());
                    //editEinstellung(Qt.resolvedUrl("neueSeite.qml"),"Offlinecache",seitenJavascript.toString());
                    //editEinstellung(Qt.resolvedUrl("neueSeite.qml"),"LokalerSpeicher",seitenJavascript.toString());
                    editEinstellung(Qt.resolvedUrl("neueSeite.qml"),"Zoom",seitenZoom.toString());
                }
            }
            MenuItem {
                text: {
                    gibTextJavascriptAnAus();
                }
                onClicked: aktJavascript = !aktJavascript;
            }
        }
        ScrollDecorator {}

    }

    BusyIndicator {
            anchors.centerIn: parent
            running: webView.loading
        }

    Rectangle {
        id: kzurueck;
        anchors {
            left: parent.left
            bottom: parent.bottom
        }
        width: 65
        height: 65
        opacity: 0.3
        color: "lightgrey"
        //visible: page.backNavigation;
        MouseArea {
          id: mausGebietzurueck
          anchors.fill: parent
          onClicked: webView.goBack();
        }

    }


    Rectangle {
        id: kvor;
        anchors {
            right: parent.right
            bottom: parent.bottom
        }
        width: 65
        height: 65
        opacity: 0.3
        color: "lightgrey"
        //visible: webView.forwardNavigation;
        MouseArea {
          id: mausGebietvor
          anchors.fill: parent
          onClicked: webView.goForward();
        }

    }

    Rectangle {
        id: kaktualisiere;
        anchors {
            top: parent.top
            right: parent.right
        }
        width: 65
        height: 65
        opacity: 0.3
        color: "lightgrey"
        //visible: webView.forwardNavigation;
        MouseArea {
          id: mausAktualisiere
          anchors.fill: parent
          onClicked: {
              if (webView.loading) {
                webView.stop
              } else {
                webView.reload
              }
          }
        }

    }

    Rectangle {
        id: kauswahl;
        anchors {
            top: parent.top
            left: parent.left
        }
        width: 65
        height: 65
        opacity: 0.3
        color: "lightgrey"
        //visible: webView.forwardNavigation;
        MouseArea {
          id: mausZeigeAuswahl
          anchors.fill: parent
          onClicked: {
              //aktZoom: 1;
              pageStack.pop();
          }
        }

    }
}
