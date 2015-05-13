# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = IeligWeb

CONFIG += sailfishapp

SOURCES += src/IeligWeb.cpp

OTHER_FILES += qml/IeligWeb.qml \
    qml/cover/CoverPage.qml \
    rpm/IeligWeb.changes.in \
    rpm/IeligWeb.spec \
    rpm/IeligWeb.yaml \
    translations/*.ts \
    IeligWeb.desktop \
    qml/pages/helper/db.js \
    qml/pages/BearbeiteSeite.qml \
    qml/pages/About.qml \
    qml/pages/NeueSeite.qml \
    qml/pages/ZeigeSeite.qml \
    qml/pages/Einstellungen.qml \
    qml/pages/helper/globs.js \
    translations/IeligWeb.ts \
    translations/IeligWeb-de.ts

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/IeligWeb-de.ts

