#ifndef SCALEUI_H
#define SCALEUI_H

#include <QObject>
#include <QGuiApplication>
#include <QScreen>
#include <QDebug>
#include <qqmlintegration.h>

// Device specific baseline values, this app is currently being tested on.
// Device: Lenovo V14 G3 IAP, the lazy bad dog.
// #ifdef Q_OS_ANDROID
//     #define BASELINE_WIDTH 1080
//     #define BASELINE_HEIGHT 2340
//     #define BASELINE_DPI 198
// #else
    #define BASELINE_WIDTH 1920
    #define BASELINE_HEIGHT 1080
    #define BASELINE_DPI 120
// #endif

class ScaleUI : public QObject
{
    Q_OBJECT
public:
    explicit ScaleUI(QObject *parent = nullptr)
        : QObject(parent)
    {
        updateScreenMetrics();
        connect(QGuiApplication::primaryScreen(), &QScreen::geometryChanged, this, &ScaleUI::updateScreenMetrics);
    }

    // Method to scale font size Q_INVOKABLE
    Q_INVOKABLE qreal scaleFont(qreal baseFontSize) const
    {
        qreal scaledFontSize = baseFontSize * calculateScaleFactor();
        qDebug() << "Scaled font" << getNearestStandardFontSize(scaledFontSize);
        return getNearestStandardFontSize(scaledFontSize);
    }

    // Method to get the nearest standard font size
    qreal getNearestStandardFontSize(qreal scaledFontSize) const
    {
        static std::vector<qreal> standardFontSizes = {8, 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36, 48, 72};
        auto it = std::min_element(standardFontSizes.begin(),
                                   standardFontSizes.end(),
                                   [scaledFontSize](qreal a, qreal b)
                                   {
                                       return std::abs(a - scaledFontSize) < std::abs(b - scaledFontSize);
                                   });
        return *it;
    }

    // Method to scale any control's size
    Q_INVOKABLE qreal scaleSize(qreal baseSize) const
    {
        return baseSize * calculateScaleFactor();
    }

    // Method to get the scaled width of a control
    Q_INVOKABLE qreal scaleWidth(qreal baseWidth) const
    {
        qDebug() << "Scaled width" << baseWidth * calculateWidthScaleFactor() << " factor " << calculateWidthScaleFactor();
        return baseWidth * calculateWidthScaleFactor();
    }

    // Method to get the scaled height of a control
    Q_INVOKABLE qreal scaleHeight(qreal baseHeight) const
    {
        qDebug() << "Scaled height" << baseHeight * calculateHeightScaleFactor() << "factor" << calculateHeightScaleFactor();
        return baseHeight * calculateHeightScaleFactor();
    }

private:
    int screenWidth = BASELINE_WIDTH;  // Default fallback resolution
    int screenHeight = BASELINE_HEIGHT; // Default fallback resolution
    qreal dpi = BASELINE_DPI;          // Default fallback DPI

    // Update screen metrics dynamically
    void updateScreenMetrics()
    {
        QScreen *screen = QGuiApplication::primaryScreen();
        if (screen) {
            screenWidth = screen->size().width();
            screenHeight = screen->size().height();
            dpi = screen->logicalDotsPerInch();
            qDebug() << "Screen metrics available:" << screen->size().width() << "x" << screen->size().height() << "DPI:" << screen->logicalDotsPerInch();
            qDebug() << "Screen metrics updated:" << screenWidth << "x" << screenHeight << "DPI:" << dpi;
        }
    }

    // Calculate a general scale factor based on resolution and DPI
    qreal calculateScaleFactor() const
    {
        return dpi / BASELINE_DPI;
    }

    // Scale factor based on width
    qreal calculateWidthScaleFactor() const
    {
        return screenWidth / BASELINE_WIDTH;
    }

    // Scale factor based on height
    qreal calculateHeightScaleFactor() const
    {
        return screenHeight / BASELINE_HEIGHT;
    }
};


#endif // SCALEUI_H
