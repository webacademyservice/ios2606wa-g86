import UIKit

// MARK: - Классы (class)

// Класс - Строительная единица программы. Классы могут содержать свойства и методы.
// Другими словами, внутри класса могут быть значения (например var ... и функции
// (ключевое слово func). К слову, ViewController - тоже class. Рассмотрим простой пример:

class Driver {

}

// Мы создали класс Driver (водитель). Давайте класс с более общим назначением и назовем
// его Worker (работник). Добавим туда несколько свойств: name - имя работника,
// jobTitle - название его позиции, и зарплату - salary:

class Worker {

    var name = ""               // Здесь мы объявляем свойства. В зависимости от ситуации,
    var jobTitle = ""           // далее мы можем называть их "проперти" или "переменные"
    var salary = 0

    // А так же пусть у него будет функция work(работа), выполняя ее,
    // работник будет выводить в консоль фразу "Работник работает!"

    func work() {               // Далее мы можем называть это "функция" или "метод"
        print("Работник работает!")
        //  Чтобы в консоли данные не мешались, добавим вывод пустой строки:
        print("")
    }
}

// То, что мы записали выше, по сути является схемой работника, но не конкретным
// работником. Теперь с помощью этой схемы мы создадим конкретного работника Борю.
// Переменные всегда должны называться с маленькой буквы, для Бори мы не делаем исключения

var boris = Worker()

// Работник уже является созданным объектом уже на этой строке. Но чтобы Борис имел
// какие-то характеристики, давайте зададим их через точку:

boris.name = "Борис"
boris.jobTitle = "iOS Developer"
boris.salary = 10

// Так же мы уже можем вызвать функцию work у Бориса:

boris.work()

// Теперь разберем еще несколько базовых понятий, на примере класса iPhone. Названия
// классов в отличии от свойств (они же переменные, они же проперти) всегда пишуться с
// большой буквы. Это тоже строгое правило, и для iPhone мы также не делаем исключения:

class IPhone {

    // Пусть у нашего iPhone будут характеристики: тайтл(имя), цвет и параметр "сломан ли"

    var title: String = ""
    var color: UIColor = UIColor.clear
    var isBroken: Bool = false

    // Мы впервые сталкиваемся с типом данных UIColor, но здесь все просто: как мы храним
    // строку, или число, мы можем хранить и цвет. А также любой класс, что мы разберем
    // дальше.

    // Теперь мы можем написать инициализатор - функцию, которая будет вызываться всегда
    // при создании конкретного iPhone. В данном примере она поможет нам сэкономить строки
    // и записать параметры девайса сразу при создании.

    init(title: String, color: UIColor, isBroken: Bool) {

        // Ключевое слово init имеет подсветку того же цвета, что и var. Это слово,
        // которое мы не можем менять. Но мы можем назвать входные параметры, как нам
        // захочется. Теперь, чтобы завершить инициализацию, зададим параметры iPhone:

        self.title = title
        self.color = color
        self.isBroken = isBroken
    }

    // Теперь создадим функцию displayInfo(), которая будет выводить в консоль данные,
    // которые мы укажем инициализируем объект айфона:

    func displayInfo() {
        // Команда print может не только выводить значения, но и встраивать
        // их в какой-то текст:
        print("I am \(self.title)")
        print("My color is \(self.color)")
        print("Am I broken: \(self.isBroken)")

        // И выводим пустую строку, чтобы сделать отступ в консоли:
        print("")
    }
}

// Итак, если не обращать внимания на комментарии, подытожим, что есть в нашем
// классе: объявление трех свойств, инит и функция. Попробуем создать экземпляры
// этого класса:

let iPhoneSE = IPhone(title: "SE", color: .red, isBroken: false)
let iPhoneX = IPhone(title: "X", color: .black, isBroken: false)
// ...

// Мы можем создать любое количество айфонов. Точно так же, как и любое количество
// экземпляров одного класса. Класс - теоретическая схема, экземпляр класса - созданный
// по этой схеме объект.

// Вызовем функцию displayInfo у каждого айфона:

iPhoneSE.displayInfo()
iPhoneX.displayInfo()

// Если мы запустим код, мы увидим следующее:

/*

 I am SE
 My color is UIExtendedSRGBColorSpace 1 0 0 1
 Am I broken: false

 I am X
 My color is UIExtendedGrayColorSpace 0 1
 Am I broken: false

*/

// Значение цвета вывелось в неожиданном формате. Не вдаваясь в детали, это произошло
// потому, что значение "UIColor", в программировании описывается 4мя цифрами: насыщенность
// красного, зеленого и голубого, а также значение в промежутке от 0 до 1, означающее
// уровень прозрачности.

// Мы можем создать абсолютно любой класс, который может содержать любые свойства, в том
// числе описанные в других классах. Для примера, создадим класс Shop (магазин):

class Shop {

    // Пусть у него будет имя, отрасль и айфоны, выраженные массивом из класса
    // IPhone:

    var name = ""
    var scope = ""
    var iPhones: [IPhone] = []

    // Создадим init, как в прошлый раз. Но поле scope мы бы не хотели вводить каждый
    // раз, так как обычно магазины электроники продают айфоны. В таком случае
    // мы можем задать значение по умолчанию для параметра scope "Электроника":

    init(name: String, scope: String = "Электроника", iPhones: [IPhone]) {
        self.name = name
        self.scope = scope
        self.iPhones = iPhones
    }
}

// Теперь создадим экземпляр класса Shop. Нам понадобиться список работников,
// поэтому начнем с него:

let iPhones = [IPhone(title: "X", color: .black, isBroken: false),
               IPhone(title: "SE", color: .green, isBroken: false),
               IPhone(title: "8", color: .red, isBroken: false),
               IPhone(title: "4s", color: .white, isBroken: false)]

let shop1 = Shop(name: "Citrus", scope: "Электроника", iPhones: iPhones)

// Теперь мы не будем указывать, что это магазин электроники, чтобы это значение подтянусь
// по умолчанию. Список айфонов можно создать прямо во время создания магазина:

let shop2 = Shop(name: "Stylus", iPhones: [IPhone(title: "5s", color: .black, isBroken: false),
                                           IPhone(title: "8", color: .red, isBroken: false),
                                           IPhone(title: "4s", color: .white, isBroken: false)])

// Выведем на экран количество элементов в массиве iPhones в экземпляре класса shop2:
print("Amount of iphones in shop2: \(shop2.iPhones.count)")

// В консоль вывелась цифра 3. Теперь мы можем оперировать переменной shop2. Попробуем
// добавить новый айфон в этот магазин:

shop2.iPhones.append(IPhone(title: "XS", color: .darkGray, isBroken: false))

// Выведем количество айфонов еще раз:

print("Amount of iphones in shop2: \(shop2.iPhones.count)")

// Классы которые используются в реальных приложениях зачастую очень большие. И нам все
// время придется обращаться: Класс -> его проперти(которая тоже класс) -> ... -> его проперти.

// Представим, что у нас есть класс Страна, у которой есть Город, у которого есть Улица,
// у которой есть Дом, у которого есть Квартира. И мы хотим вывести в консоль квартиру:
// let country = Country( ... инициализация ... )
// print(country.city.street.building.apartment)

// У нас получаются достаточно массивные конструкции в последнем и предпоследнем примере.
// И они выглядит пугающе, но их понимание является ключевым для построения приложений.

// Поэтому я рекомендую, если нет ощущения, что все предельно ясно, перечитать материал
// еще раз вдумчиво и по порядку, чтобы мы могли перейти к следующим темам. Они будут
// выглядеть достаточно простыми для тех, кто разобрался, как работают классы.


