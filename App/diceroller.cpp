#include "diceroller.h"
#include <ctime>

DiceRoller::DiceRoller(QObject *parent)
    : QObject{parent},
    generator(std::time(nullptr)) // Seeding the mt19937 with current time.
{}

int DiceRoller::roleDice(int max, int min)
{
    // Uniform distribution of the range.
    std::uniform_int_distribution<int> distr(min, max);
    // Return the rand number.
    return distr(generator);
}
