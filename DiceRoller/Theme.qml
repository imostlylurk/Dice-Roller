pragma Singleton

import QtQuick
import QtCore

QtObject {
    id: root

    // Light
    readonly property color lightBackground: "#CDCDCD"
    readonly property color lightText: "#282828"
    readonly property real lightBorderOpacity: 0.22

    // Dark
    readonly property color darkBackground: "#282828"
    readonly property color darkText: "#CDCDCD"
    readonly property real darkBorderOpacity: 0.20

    // Solarized Light
    readonly property color slightBackground: "#FDF6E3"
    readonly property color slightText: "#073642"
    readonly property real slightBorderOpacity: 0.27

    // Solarized Dark
    readonly property color sdarkBackground: "#002B36"
    readonly property color sdarkText: "#EEE8D5"
    readonly property real sdarkBorderOpacity: 0.20

    // AMOLED Black
    readonly property color oblackBackground: "#000000"
    readonly property color oblackText: "#FFFFFF"
    readonly property real oblackBorderOpacity: 0.20
    readonly property real borderWidth: 2

    property int currentTheme: Theme.Light
    property string currentThemeIcon: icon("sun-filled")
    property color background: lightBackground
    property color text: lightText
    property color border: Qt.alpha(lightText, lightBorderOpacity)

    enum Themes {
        Light,
        Dark,
        SolarizedLight,
        SolarizedDark,
        OLEDBlack
    }

    function setNextTheme() {
        currentTheme++
        currentTheme = currentTheme % (Theme.OLEDBlack + 1)
        setTheme(currentTheme)
    }

    function setTheme(val: real) {
        // if (currentTheme === val)
        //     return

        switch(val) {
        case Theme.Light:
            setColors(lightBackground, lightText, Qt.alpha(lightText, lightBorderOpacity))
            currentThemeIcon = icon("moon")
            break
        case Theme.Dark:
            setColors(darkBackground, darkText, Qt.alpha(darkText, darkBorderOpacity))
            currentThemeIcon = icon("solarized-light")
            break
        case Theme.SolarizedLight:
            setColors(slightBackground, slightText, Qt.alpha(slightText, slightBorderOpacity))
            currentThemeIcon = icon("solarized-dark")
            break
        case Theme.SolarizedDark:
            setColors(sdarkBackground, sdarkText, Qt.alpha(sdarkText, sdarkBorderOpacity))
            currentThemeIcon = icon("oled-black")
            break
        case Theme.OLEDBlack:
            setColors(oblackBackground, oblackText, Qt.alpha(oblackText, oblackBorderOpacity))
            currentThemeIcon = icon("sun-filled")
            break
        }

        currentTheme = val
    }

    function setColors(bkg, txt, brdr)
    {
        background = bkg
        text = txt
        border = brdr
    }

    property Settings themeSettings : Settings {
        category: "Configurations"

        property alias theme: root.currentTheme
        property alias bckgrnd: root.background
        property alias txt: root.text
        property alias brder: root.border
        property alias crntThemeIcon: root.currentThemeIcon
    }

    ////////////////////////
    // Icons
    ////////////////////////
    function icon(name)
    {
        return Qt.resolvedUrl("../DiceRollerContent/images/icons/" + name + ".svg")
    }
}
