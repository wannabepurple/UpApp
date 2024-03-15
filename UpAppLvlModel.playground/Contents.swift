import UIKit

var total: Int64 = 0
var lvl = 0
let fiveHoursInSec: Int64 = 5 * 3600
let tenHoursInSec: Int64 = 10 * 3600
let fifteenHoursInSec: Int64 = 15 * 3600
let twentyFiveHoursInSec: Int64 = 25 * 3600
let fiftyFiveHoursInSec: Int64 = 50 * 3600


while total < 10000 * 3600 {
    switch lvl {
    case 0:
        total += fiveHoursInSec
    case 1:
        total += tenHoursInSec
    case 2:
        total += fifteenHoursInSec
    case 3:
        total += twentyFiveHoursInSec
    default:
        total += fiftyFiveHoursInSec
    }

    lvl += 1
    print("Lvl = \(lvl), TotalSec = \(total)")

}


