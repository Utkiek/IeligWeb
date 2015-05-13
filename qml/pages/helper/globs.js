function nimmAktTitel(neuerTitel) {
    if (neuerTitel == "") {
        haupt.aktTitel = "Ielig:Web"
    } else {
        haupt.aktTitel = neuerTitel
    }
}

function gibAktTitel() {
    return haupt.aktTitel
}

function gibThemeFontgroesse(fontStufe) {
    switch(fontStufe) {
    case 0: {
        return Theme.fontSizeSmall;
    }
    case 1: {
        return Theme.fontSizeMedium;
    }
    case 2: {
        return Theme.fontSizeLarge;
    }
    }
    return Theme.fontSizeMedium;
}


function gibSeitenFontstufe(seitenfontstufe) {
    switch(seitenfontstufe) {
    case 1: {
        defaultFontSize: 22
        defaultFixedFontSize: 20
        minimumFontSize: 16
    }
    case 2: {
        defaultFontSize: 24
        defaultFixedFontSize: 22
        minimumFontSize: 18
    }
    case 3: {
        defaultFontSize: 26
        defaultFixedFontSize: 24
        minimumFontSize: 20
    }
    }
}
