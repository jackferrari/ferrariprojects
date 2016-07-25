// Jack Ferrari, bonus problems
import UIKit

func isLeap(year: Int) -> Bool {
    return (year%4 == 0) && ( (year%100 != 0) || (year%400 == 0))
}

func julianDate(year: Int, month: Int, day: Int) -> Int {
    //add up the days from full prior years
    var ret = ((year-1900)*365) + ((year-1901)/4) - ((year-1901)/100) + ((year-1901)/400)
    //add up the days from full prior months
    ret += ([0, 31, (isLeap(year) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])[0...month-1].reduce(0, combine: +)
    //add in the days in the current month
    return ret + day
}


julianDate(1960, month:  9, day: 28)

julianDate(1900, month:  1, day: 1)

julianDate(1900, month: 12, day: 31)

julianDate(1901, month: 1, day: 1)

julianDate(1901, month: 1, day: 1) - julianDate(1900, month: 1, day: 1)

julianDate(2001, month: 1, day: 1) - julianDate(2000, month: 1, day: 1)

isLeap(1960)

isLeap(1900)

isLeap(2000)
