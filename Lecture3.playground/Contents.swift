//: Playground - noun: a place where people can play

import Foundation

let immutableString = "hello, playground-world"
var str = "Hello, playground-world"

str = "another String"
//immutableString = "some String" -- wrong

var mayInt = 64
let myConstant = 50

let implicitDouble = 70.5
let explicitDouble: Double = 70

let label = "the width is"
let width = 90
let widthLabel = label + " " + String(width)
String(94)
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples"
let orangeSummary = "I have \(oranges) oranges"

//var aFloat: Float -- float is a thing
// a var can be changed, a let can't

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList.append("toothpaste")
//shoppingList.append(47) -- doesn't work because of implicit arrays

var shoppingList2 = ["catfish", "water", "tulips", "blue paint", 47]
shoppingList2.append("toothpaste")
shoppingList2.append(47)
// works with highest type of array from original

//var shoppingList3: Array<String> = ["catfish", "water", "tulips", "blue paint", 47]
//shoppingList3.append("toothpaste")
//shoppingList3.append(47)
// this makes the ints stop working

// copies of arrays are not changed with the original

var shoppingList4: NSMutableArray = ["catfish", "water", "tulips", "blue paint"]
shoppingList4.addObject(47)


var occupation = [
    "malcom":"captain",
    "Kalyee": "mechanic"
]

occupation["jayne"] = "Public Relations"


var r = 50...100
var g = r.generate()
g.next()
g.next()


var g1 = [11, 21, 31, 41, 51].generate()
g1.next()



var tuple1 = (1, 2)

tuple1.0
tuple1.1

var tuple2 = (First:"Jack", last:"Ferrari")
tuple2.0
tuple2.last

for(k,v) in occupation {
    print("\(k),\(v)")
}

func doubler(x:Int) -> Int {
    return x*2
}

doubler(4)

func doubleDoubler(x:Double) -> Double {
    return x*2
}

doubleDoubler(3.1343141342543542155)

func progression(v:Int, f:Int ->Int) -> Int {
    return (f(v))
}

progression(4, f:doubler)
//progression(3, f:doubleDoubler) -- wrong type

var ja = false
ja = true

var ck: Array<Dictionary<Int, Bool>> = [[1: true]]

var closure = {(x:Int) -> Int in
    return 2*x
}
progression(6, f:closure)

progression(6) {(x:Int) -> Int in
    return x*2
}
// = 
progression(6, f: {(x:Int) -> Int in
    return x*2
})

var occupationNames = occupation.map { (k:String, v:String) -> String in
    return k
}
var occupationNames2 = occupation.map {return $0.0}
var occupationNames3 = occupation.map { $0.0 }
// avoid for-loops



var n:String? = nil
// can be string or nothing -- nothing is not an empty string
// nil is not a string
// question amrk means it could be nil

var m:Int? = nil

//doubler(m)
//does not work because it is possible for somthing other than an int to be passed in

var optional:Int? = nil
var implicitOptionalN:Int! = 12

if let l = optional {
    let doubleN = doubler(l)
}

doubler(implicitOptionalN)

// Int! is the same type as Int

//







