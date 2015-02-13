/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "pages/helper/db.js" as DB

ApplicationWindow
{   id: root

    property string aktDBVersion: "0.0.1"
    property string altVersion1: ""
    property string aktUrl
    property string aktTitel
    //property real aktZoom: 1
    property real aktHeight: 960
    property real aktWidth: 540
    property bool aktJavascript: false
    property bool aktCookies: false
    property bool aktPlugins: false
    property bool aktJava: false
    property bool aktOfflinecache: false
    property bool aktLokalerspeicher: false
    property bool aktPrivatmodus: true
    property int defaultFontSize: 26
    property int defaultFixedFontSize: 24
    property int minimumFontSize: 20
    property int fontpixelsize: 22
    property real orgHeight: 0
    property real orgWidth: 0
    property real neueHoehe: 960
    property real neueWeite: 540

    //Einstellungen
    property string ieligwebUrl: "ieligweb"
    property int aktFontstufe: 3
    property string aktUseragent: "Jolla/Sailfish"
    property string userAgentJollaIndex: "Jolla/Sailfish"
    property string userAgentOperaMini9Index: "Opera Mobile"
    property string userAgentMozillaDesktop25Index: "Mozilla Desktop"
    property string userAgentJolla: "Mozilla/5.0 (Maemo; Linux; Jolla; Sailfish; Mobile) AppleWebKit/534.13 (KHTML, like Gecko) NokiaBrowser/8.5.0 Mobile Safari/534.13"
    property string userAgentOperaMini9: "Opera/9.80 (J2ME/MIDP; Opera Mini/9 (Compatible; MSIE:9.0; iPhone; BlackBerry9700; AppleWebKit/24.746; U; en) Presto/2.5.25 Version/10.54"
    property string userAgentMozillaDesktop25: "Mozilla/5.0 (X11; U; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0"

    //property QtObject seitenStapel: pageStack
    //property QtObject firstPage

    signal clearCookies()
    signal clearCache()

    initialPage: Component { BearbeiteSeite { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    ListModel {
        id: seitenListe

        function enthaelt(siteUrl) {
            var suffix = "/";
            var str = siteUrl.toString();
            for (var i=0; i<count; i++) {
                if (get(i).url == str)  {
                    return true;
                }
                // check if url endswith '/' and return true if url-'/' = models url
                else if (str.indexOf(suffix, str.length - suffix.length) !== -1) {
                    if (get(i).url == str.substring(0, str.length-1)) return true;
                }
            }
            return false;
        }

        function editSeite(alterTitel, titel, url) {
            for (var i=0; i<count; i++) {
                if (get(i).titel === alterTitel) set(i,{"titel":titel, "url":url});
            }
            DB.schreibeSeite(titel, url);
        }

        function loescheSeite(seitenUrl) {
            for (var i=0; i<count; i++) {
                if (get(i).url === seitenUrl) remove(i);
            }
            DB.loescheSeite(seitenUrl);
        }

        function neueSeite(titel, url) {
            append({"titel":titel, "url": url})
            DB.schreibeSeite(titel, url);
        }
    }

   function gibEinstellung(url,parameter) {
       return DB.gibEinstellung(url,parameter)
   }

   function gibEinstellungBool(url,parameter) {
       return DB.gibEinstellungBool(url,parameter);
   }

   function gibEinstellungReal(url,parameter,vorgabe) {
       var s = "";
       s = DB.gibEinstellungReal(url,parameter,vorgabe.toString());
       return parseFloat(s);
   }

   function leseSeiteneinstellungen (url) {
       aktJavascript = gibEinstellungBool(url,"Javascript")
       aktCookies = gibEinstellungBool(url,"Cookies")
       aktPlugins = gibEinstellungBool(url,"Plugins")
       //aktJava: java
       //aktOfflinecache: offlinecache
       //aktLokalerspeicher: lokalerspeicher
       aktPrivatmodus = gibEinstellungBool(url,"Privatmodus")
       //aktZoom = gibEinstellungReal(url,"Zoom",aktZoom)
       neueHoehe = gibEinstellungReal(url,"ZoomHoehe",neueHoehe)
       neueWeite = gibEinstellungReal(url,"ZoomWeite",neueWeite)
       aktUseragent = gibEinstellung(url,"Useragent")
   }

   function editEinstellung(url, parameter, wert) {
     DB.schreibeEinstellung(url, parameter, wert);
   }

   function loescheEinstellung(seitenUrl) {
     DB.loescheEinstellung(seitenUrl);
   }

   function gibUserAgent() {
       var luserAgent = userAgentJolla

       if (aktUseragent == userAgentOperaMini9Index) {
         luserAgent = userAgentOperaMini9;
       }
       if (aktUseragent == userAgentMozillaDesktop25Index) {
         luserAgent = userAgentMozillaDesktop25;
       }
       return luserAgent;
   }

    Component.onCompleted: {
        DB.initialize(aktDBVersion);
        DB.gibSeite();

    }

}
