#ifndef DICEROLLER_H
#define DICEROLLER_H

#include <QQmlEngine>
#include <random>

class DiceRoller : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit DiceRoller(QObject *parent = nullptr);
    // Takes a max and min range. Max first as we will not be passing min anyway.
    Q_INVOKABLE int roleDice(int max, int min = 1);

private:
    // A static Mersenne Twister engine, PRNG (Psuedo Random Number Generator), for better rand generation.
    // Will be seeded with current time.
    std::mt19937 generator;
};

#endif // DICEROLLER_H
