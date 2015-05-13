import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import "helper/globs.js" as Globs

Page {
    id: page
    allowedOrientations: Orientation.All
    backNavigation: false
    forwardNavigation: false
    showNavigationIndicator: false

    property string seitenUrl
    property bool urlPause: aktDoppelklick

    function gibTextJavascriptAnAus() {
        if (aktJavascript) {return qsTr("Javascript off")}
            else {return qsTr("Javascript on")};
    }

    SilicaWebView {
        id: webView

        width: page.width
        height: page.height

        url: seitenUrl
        objectName: "SWebView"

        onNavigationRequested: {
            switch (request.navigationType)
            {
            case WebView.LinkClickedNavigation: {
                if (urlPause) {
                    urlPause = false
                    request.action = WebView.IgnoreRequest
                } else {
                    urlPause = true
                    request.action = WebView.AcceptRequest
                }
                return
            }

            case WebView.FormSubmittedNavigation:
            case WebView.BackForwardNavigation:
            case WebView.ReloadNavigation:
            case WebView.FormResubmittedNavigation:
            case WebView.OtherNavigation:
            {
                    request.action = WebView.AcceptRequest
                    return
                }
            }
            request.action = WebView.AcceptRequest
        }

        //die Einstellmöglichkeiten sind sehr schlecht in WebView

        experimental {
            preferences {
                javascriptEnabled: aktJavascript;
                cookiesEnabled: aktCookies;
                pluginsEnabled: aktPlugins;
                offlineWebApplicationCacheEnabled: aktOfflinecache;
                localStorageEnabled: aktLokalerspeicher;
                //javaEnabled: aktJava;
                privateBrowsingEnabled: aktPrivatmodus;
                dnsPrefetchEnabled: false;

                minimumFontSize: minimumFontSize;
                defaultFontSize: defaultFontSize;
                defaultFixedFontSize: defaultFixedFontSize;
                fullScreenEnabled: true
                developerExtrasEnabled: true
                //contentsScale: aktZoom;
                //setDefautZoom: 125;
           }

            transparentBackground: false
            userAgent: gibUserAgent()
            //deviceWidth: page.width / aktZoom
            //deviceHeight: page.height / aktZoom

        }
        smooth: false;
        onScaleChanged: {
            urlPause = aktDoppelklick
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Save url")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("NeueSeite.qml"), { seitenListe: seitenListe, editSeite: true, alterTitel: "", seitenTitel: "", seitenUrl: webView.url});
                    editEinstellung(seitenUrl,"Privatmodus",seitenPrivatmodus.toString());
                    editEinstellung(seitenUrl,"Javascript",seitenJavascript.toString());
                    editEinstellung(seitenUrl,"Cookies",seitenCookies.toString());
                    editEinstellung(seitenUrl,"Plugins",seitenPlugins.toString());
                    //editEinstellung(seitenUrl,"Java",seitenJavascript.toString());
                    //editEinstellung(seitenUrl,"Zoom",seitenZoom.toString());;
                    editEinstellung(seitenUrl,"Useragent",aktUseragent);
                    editEinstellung(seitenUrl,"Font",aktseitenFontstufe);
                    editEinstellung(seitenUrl,"Doppelklick",aktDoppelklick);
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
            top: parent.top
        }
        width: 65
        height: 65
        opacity: 0.3
        color: "lightgrey"
        visible: webView.canGoBack;
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
            top: parent.top
        }
        width: 65
        height: 65
        opacity: 0.3
        color: "lightgrey"
        visible: webView.canGoForward;
        MouseArea {
          id: mausGebietvor
          anchors.fill: parent
          onClicked: webView.goForward();
        }

    }

    Rectangle {
        id: kaktualisiere;
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
        width: 65
        height: 65
        opacity: 0.3
        color: "lightgrey"
        MouseArea {
          id: mausAktualisiere
          anchors.fill: parent
          onClicked: {
              if (webView.loading) {
                webView.stop()
              } else {
                webView.reload()
              }
          }
        }

    }

    Rectangle {
        id: kauswahl;
        anchors {
            bottom: parent.bottom
            left: parent.left
        }
        width: 65
        height: 65
        opacity: 0.3
        color: "lightgrey"
        MouseArea {
          id: mausZeigeAuswahl
          anchors.fill: parent
          onClicked: {
              Globs.nimmAktTitel("")
              pageStack.clear();
              pageStack.push(Qt.resolvedUrl("BearbeiteSeite.qml"), {seitenUrl: seitenUrl});
          }
        }

    }

}
