import UIKit

//MARK: - Optionals Example
var myString: String?

//optional'i nerde kullanirsak kullanalim unwrap etmeliyiz.
if let myString = myString {
    print(myString)
} else {
    print("Burasi nil geldi.")
}

//nil coalescing
print(myString ?? "Burasi bos")

//guard let
//guard let myString else { return }

//kod devam etsin istiyorsak if- if let, istemiyorsak da guard let'i kullanabiliriz.

var myArr = [1, 2, 3, 4, 5, 1]
for arrayElement in myArr {
    if arrayElement == 3 {
        continue
    }
    print(arrayElement)
}

for arrayElement in myArr where arrayElement == 3 {
    print(arrayElement)
}

//array'in elemanlarini ve index'ini almak:
for (index, _) in myArr.enumerated() {
    if index == 2 {
        print("2. index.")
    }
}
//_ ile yazilan yer -> array'in her bir elemani, yukaridaki orneklerdeki arrayElement.

//tuple ornegi
var userCred: (String, Int)?

userCred?.0 = "Ilk deger"
userCred?.1 = 2
   
//optional chaining -> ?.

var str = readLine()
//print(str)

userCred = ("Ahmet", 2)

if let userCred {
    print(userCred)
}

userCred?.0 = "Mehmet"
print(userCred ?? ("Bos", 2))

//dictionary & set
var myDict: [String: Any] = ["Ahmet": 3]
var mySet: Set<String> = ["1", "2", "3", "1"]

print(mySet.sorted(by: >))

myDict["Ahmet"]


#warning("Burayi unutma")
//TODO: -

//hard skill lesson - live coding 1
class Urun {
    var boyut: Int
    var renk: String
    var fiyat: Double
    
    init(boyut: Int, renk: String, fiyat: Double) {
        self.boyut = boyut
        self.fiyat = fiyat
        self.renk = renk
    }
    
    func changeColor() {
        self.renk = "Mavi"
    }
    
    func haberVer() {
        print("boyut: \(boyut)")
    }
}

struct IkinciUrun {
    var boyut: Int
    var renk: String
    var fiyat: Double
    
    init(boyut: Int, renk: String, fiyat: Double) {
        self.boyut = boyut
        self.fiyat = fiyat
        self.renk = renk
    }
    
    mutating func changeColor() {
        self.renk = "Mavi"
    }
}

let myUrun = Urun(boyut: 10, renk: "Kirmizi", fiyat: 25.0)
let yourUrun = IkinciUrun(boyut: 5, renk: "Yesil", fiyat: 10.5)

//dump(myUrun)

class Phone: Urun {
    func changeBoyut() {
        print("Boyut degistiriliyor.")
    }
}

var benimTel = Phone(boyut: 10, renk: "yesil", fiyat: 23.4)
benimTel.haberVer()

//MARK: - getter - setter
class Time {
    var seconds: Double
    
    init(seconds: Double) {
        self.seconds = seconds
    }
    
    var minutes: Double {
        get {
            return seconds / 60.0
        }
        
//        set(yeniDeger) {
//            seconds = yeniDeger
//        }
        
        set {
            seconds = newValue * 60
        }
    }
    
    var hours: Double {
        get {
            return (seconds) / 60 * 60
        }
        
        set {
            seconds = newValue * (60 * 60)
        }
    }
    
    var days: Double {
        get {
            return (seconds) / 60 * 60 * 24
        }
        
        set {
            seconds = newValue * (60 * 60 * 24)
        }
    }
}

var myTime = Time(seconds: 456)
print(myTime.minutes)

myTime.minutes = 32.0
print(myTime.seconds)


//MARK: - lazy properties
class Urun2 {
    var boyut: Int
    var renk: String
    
    init(boyut: Int, renk: String) {
        self.boyut = boyut
        self.renk = renk
        
        print("Urun2 init() cagrildi.")
    }
}

class Telefon {
    lazy var benimUrun = Urun2(boyut: 15, renk: "Mavi")
}

let telefon = Telefon() 
//print(telefon)

//MARK: - functions
func multiply(with num1: Int, with num2: Int) -> Int {
    return 2 + 3
}
multiply(with: 45, with: 32)


enum Operation: String {
    case topla = "Toplaniyor..."
    case cikart = "Cikartiliyor..."
    case bol = "Bolunuyor..."
    case carp = "Carpiliyor..."
}


func calculate(operation: Operation, num1: Int, num2: Int) {
    switch operation {
    case .topla:
        print(operation.rawValue)
        print(num1 + num2)
    case .carp:
        print(num1 * num2)
    case .cikart:
        print(num1 - num2)
    case .bol:
        print(num1 / num2)
    }
}

calculate(operation: .topla, num1: 5, num2: 1)

//MARK: - Enum

enum Coffee {
    case latte
    case tea
    case greenTea
    case turkishCoffee
    
    var coffeePrice: Double? {
        switch self {
        case .latte:
            return 20.0
        case .turkishCoffee:
            return 32.0
        case .tea:
            return 12.0
        case .greenTea:
            return 18.8
        }
    }
}

enum Size {
    case large
    case medium
    case small
    
    var size: Double? {
        switch self {
            
        case .large:
            return 3.0
        case .medium:
            return 2.0
        case .small:
            return 1.0
        }
    }
}

func orderCoffee(coffeeType: Coffee, coffeeSize: Size) -> (coffeeSize: Size, coffeePrice: Double) {
//    var returnCoffeeSize: Size = coffeeSize
//    var returnPrice: Double = 0
//
//    switch coffeeType {
//    case .latte:
//        returnPrice = ((coffeeType.coffeePrice ?? 0.0) * (coffeeSize.size ?? 0.0))
//    case .tea:
//        returnPrice = ((coffeeType.coffeePrice ?? 0.0) * (coffeeSize.size ?? 0.0))
//    case .greenTea:
//        returnPrice = ((coffeeType.coffeePrice ?? 0.0) * (coffeeSize.size ?? 0.0))
//    case .turkishCoffee:
//        returnPrice = ((coffeeType.coffeePrice ?? 0.0) * (coffeeSize.size ?? 0.0))
//    }
//
//
//    return (returnCoffeeSize, returnPrice)
    return (coffeeSize, (coffeeType.coffeePrice ?? 0.0) * (coffeeSize.size ?? 0.0))
}

print(orderCoffee(coffeeType: .latte, coffeeSize: .medium))

//MARK: - Closures
var myClosure = {
    print("MyClosure printed.")
}

myClosure()

var intArray: [Int] = [1, 67, 23, 65, 23, 5, 34]
print(intArray.sorted(by: <)) // sorts in ascending order

print(intArray.filter { $0 < 30 })

intArray.sorted { sayi1, sayi2 in
    return sayi1 > sayi2
}

print(intArray.sorted { $0 < $1 })

var myIntArr: [Int] = [1, 3, 62, 512, 34, 21]

func maxAndMin(intArr: [Int]) -> (min: Int, max: Int) {
    var currentMin = intArr[0]
    var currentMax = intArr[0]
    
    for value in intArr {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    
    return (currentMin, currentMax)
}

print("Max value: \(maxAndMin(intArr: myIntArr).max)")
print("Min value: \(maxAndMin(intArr: myIntArr).min)")

func closureFilter(closure: (Int) -> Bool, numbers: [Int]) -> [Int] {
    var returnArr = [Int]()
    
    for number in numbers {
        if closure(number) {
            returnArr.append(number)
        }
    }
    
    return returnArr
}

let filteredNumbers = closureFilter(closure: { num in
    return num > 50
}, numbers: myIntArr)
print(filteredNumbers)


var myStr: String?

func islemSonuc(numbers: [Int], closure: () -> ()) {
    var returnArr = [Int]()
    for (index,_) in numbers.enumerated() {
        if index == 3 {
            myStr = "Geldi"
            closure()
        }
    }
}

let myClosure2 = islemSonuc(numbers: intArray) {
    print("Islem bitti.")
}

//MARK: - Extensions

extension String {
    func replaceVoids() -> String {
        
        return self.replacingOccurrences(of: " ", with: "")
    }
}

print("Benim adim Ceren.".replaceVoids())


//MARK: - Protocols
protocol SeaAnimalsProtocol {
    func swim()
    func breathUnderWater()
}

protocol AirAnimalsProtocol {
    func fly()
}

protocol EarthAnimalsProtocol {
    func walk()
    func run()
}

class Penguin: SeaAnimalsProtocol, EarthAnimalsProtocol {
    func swim() {
        print("Yuz...")
    }
    
    func breathUnderWater() {
        print("Suda nefes al...")
    }
    
    func walk() {
        print("Yuru...")
    }
    
    func run() {
        print("Kos...")
    }
    
        
}

class Albatros: AirAnimalsProtocol, EarthAnimalsProtocol {
    func fly() {
        
    }
    
    func walk() {
        
    }
   
    func run() {
        //optional cunku EarthAnimalsProtocol'e bir extension yazdik.
    }
    
}

//Albatros class'inin icinde run() fonksiyonunu tanimlamak istemiyorsam, run fonksiyonunun geldigi protokole bir extension yazip class disinda o run fonksiyonunu tanimlayabilirim.

extension EarthAnimalsProtocol {
    func run() { }
}


//MARK: - rock - paper - scissors examples

//Solution #1
/*
enum GameElement: String {
    case rock, paper, scissors
    
    static var allCases: [GameElement] {
        return [.rock, .paper, .scissors]
    }
    
    var gameElement: String {
        switch self {
        case .rock:
            return "✊"
        case .paper:
            return "✋"
        case .scissors:
            return "👉"
        }
    }
}

enum GameState {
    case win, lose, scoreless
    
    var gameState: String {
        switch self {
            
        case .win:
            return "You win"
        case .lose:
            return "You lost"
        case .scoreless:
            return "No-win"
        }
    }
}

func play(myElement: GameElement) {
    guard let computerElement = GameElement.allCases.randomElement() else {
        print("Something went wrong!")
        return
    }
    
    var resultState: GameState = .scoreless
    
    switch (myElement, computerElement) {
    case (.rock, .paper), (.paper, .scissors), (.scissors, .rock): resultState = .lose
    case (.rock, .scissors), (.paper, .rock), (.scissors, .paper): resultState = .win
    default: resultState = .scoreless
        
    }
    
    print("""
Your sign: \(myElement.gameElement)
Computer sign: \(computerElement.gameElement)
Result: \(resultState.gameState)
""")
    
    play(myElement: .rock)
}
*/

/*
//Solution #2
enum GameElement: Int, CaseIterable {
    case rock = 0
    case paper = 1
    case scissors = 2
    
    var gameElement: String {
        switch self {
        case .rock:
            return "✊"
        case .paper:
            return "✋"
        case .scissors:
            return "👉"
        }
    }
}

enum GameState {
    case win, lose, scoreless, draw
    
    var gameState: String {
        switch self {
        case .win:
            return "Congratulations! 🥳"
        case .lose:
            return "You lost, maybe next time. 🙂"
        case .scoreless:
            return "No-win situation 🥲"
        case .draw:
            return "Something went wrong 😭"
        }
    }
}

class Logger {
    static func logResult(_ myElement: GameElement,
                          _ computerElement: GameElement,
                          _ resultState: GameState) {
        print("""
        Your sign: \(myElement.gameElement)
        Computer sign: \(computerElement.gameElement)
        Result: \(resultState.gameState)
        """)
    }
}

func play(myElement: GameElement) {
    var resultState: GameState = .draw
    
    guard let computerElement = GameElement.allCases.randomElement() else {
        print(resultState.gameState)
        return
    }
    
    let resultMod = myElement.rawValue - computerElement.rawValue + 3
    switch resultMod % 3 {
    case 1: resultState = .win
    case 2: resultState = .lose
    default: resultState = .scoreless
    }
    
    Logger.logResult(myElement, computerElement, resultState)
}
*/

//Solution #3
/*
enum GameElement: Int, CaseIterable {
    case rock = 0
    case paper
    case scissors
    
    var gameElement: String {
        switch self {
        case .rock:
            return "✊"
        case .paper:
            return "✋"
        case .scissors:
            return "👉"
        }
    }
}

enum GameState {
    case win, lose, scoreless, draw
    
    var gameState: String {
        switch self {
        case .win:
            return "Congratulations! 🥳"
        case .lose:
            return "You lost, maybe next time. 🙂"
        case .scoreless:
            return "No-win situation 🥲"
        case .draw:
            return "Something went wrong 😭"
        }
    }
}

enum AlertLogs {
    case play, invalidInput, selections, error
    
    var alertLog: String {
        switch self {
        case .play:
            return "Play! 🤓"
        case .invalidInput:
            return "Invalid input 🤧 \n Please select ✊:0, ✋:1, 👉:2"
        case .selections:
            return "Please select ✊:0, ✋:1, 👉:2§"
        case .error:
            return "Something went wrong 😱"
        }
    }
}

class Logger {
    static func logResult(_ myElement: GameElement,
                          _ computerElement: GameElement,
                          _ resultState: GameState) {
        print("""
        Your sign: \(myElement.gameElement)
        Computer sign: \(computerElement.gameElement)
        Result: \(resultState.gameState)
        """)
    }
    
    static func logAlert(_ alertLog: AlertLogs) {
        print(alertLog.alertLog)
    }
}

func play() {
    Logger.logAlert(.play)
    Logger.logAlert(.selections)
    
    var resultState: GameState = .draw
    let readLineText = readLine().checkReadLineIsValid()
    
    guard let gameElementWithRaw = GameElement(rawValue: readLineText.readLineNum), readLineText.isValid, (0...2).contains(readLineText.readLineNum) else {
        Logger.logAlert(.invalidInput)
        return
    }
    
    guard let computerElement = GameElement.allCases.randomElement() else {
        Logger.logAlert(.error)
        return
    }
    
    let resultMod = readLineText.readLineNum - computerElement.rawValue + 3
    switch resultMod % 3 {
    case 1: resultState = .win
    case 2: resultState = .lose
    default: resultState = .scoreless
    }
    
    Logger.logResult(gameElementWithRaw, computerElement, resultState)
}

extension String? {
    func checkReadLineIsValid() -> (isValid: Bool, readLineNum: Int) {
        if let self,
           let intReadLine = Int(self) {
            return (true, intReadLine)
        } else {
            return(false, 0)
        }
    }
}

while true {
    play()
}

*/

//variadic parameters
func toplamVariadic(sayilar: Int...) -> Int {
    var toplam = 0
    for s in sayilar {
        toplam += s
    }
    return toplam
}

var v1 = toplamVariadic(sayilar: 1, 2, 3, 4, 5)
print(v1) // 15

//variadic function
print("haters", "gonna", "hate")

//factorial
func factorial(number: Int) -> Int {
    var sum = 1
    for number in 1...number {
        sum *= number
    }
    
    return sum
}

factorial(number: 4)

//MARK: - Composition
class Kisiler {
    var ad: String?
    var yas: Int?
    var adres: Adres?
    
    //Shadowing
    init(ad: String, yas: Int, adres: Adres) {
        self.ad = ad
        self.yas = yas
        self.adres = adres
    }
}

class Adres {
    var il: String?
    var ilce: String?
    
    init(il: String, ilce: String) {
        self.il = il
        self.ilce = ilce
    }
}

let adres = Adres(il: "Bursa", ilce: "Osmangazi")
let kisi = Kisiler(ad: "Ahmet", yas: 20, adres: adres)

//kisi.adres?.il

//MARK: - Polymorphism
class Personel {
    func getHired() {
        print("Personel hired.")
    }
}

class Manager: Personel {
    func hire(p: Personel) {
        if p is Teacher {
            p.getHired()
        }
    }
}

class Teacher: Personel {
    
}

let teacher: Personel = Teacher() //Teacher sinifindan turemis Personel tipinde sabit.
var manager = Manager()

manager.hire(p: teacher)

//deinit()
class MyClass {
    let name: String
    let surname: String
    
    init(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }
    
    deinit {
        print("Deinit cagrildi.")
    }
}

var myClass: MyClass? = MyClass(name: "Sezgin", surname: "Sezgin")
print(myClass!)
myClass = nil

//equatable

class Ogrenci: Equatable, Hashable {
    
    var no: Int
    var ad: String
    var sinif: String
    
    init(no: Int, ad: String, sinif: String) {
        self.no = no
        self.ad = ad
        self.sinif = sinif
    }
    
    static func == (lhs: Ogrenci, rhs: Ogrenci) -> Bool {
        return lhs.no == rhs.no && lhs.ad == rhs.ad && lhs.sinif == rhs.sinif
    }
    
    var hashValue: Int {
        return no.hashValue ^ ad.hashValue //^ -> XOR
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(no)
        hasher.combine(ad)
    }
}

var o1 = Ogrenci(no: 1, ad: "Eric", sinif: "4-A")
//var o2 = Ogrenci(no: 2, ad: "Kyle", sinif: "4-B")
var o2 = Ogrenci(no: 1, ad: "Eric", sinif: "4-A")
var o3 = Ogrenci(no: 3, ad: "Stan", sinif: "4-C")
var o4 = Ogrenci(no: 4, ad: "Kenny", sinif: "4-D")

if o1 == o2 {
    print("Same.")
} else {
    print("Not same.")
}


//comparable
class Car: Comparable {
    static func < (lhs: Car, rhs: Car) -> Bool {
        return lhs.horsePower < rhs.horsePower
    }
    
    static func > (lhs: Car, rhs: Car) -> Bool {
        return lhs.horsePower > rhs.horsePower
    }
    
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.horsePower == rhs.horsePower
    }
    
    let name: String
    let origin: String
    let horsePower: Int
    
    init(name: String, origin: String, horsePower: Int) {
        self.name = name
        self.origin = origin
        self.horsePower = horsePower
    }
}

var bmw = Car(name: "BMW", origin: "Germany", horsePower: 600)
var ferrari = Car(name: "Ferrari", origin: "Italy", horsePower: 880)

if ferrari > bmw {
    print("Ferrari is faster.")
}


//hashable
var list = Set<Ogrenci>()

list.insert(o1)
list.insert(o2)
list.insert(o3)
list.insert(o4)

for i in list {
    print("*************")
    dump(i)
}
