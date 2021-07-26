// MARK: - Расширения (extension)

// Расширения позволяют "расширить" функционал класса, не наследуя его. Простое расширение
// класса int, позволяющее вызывать новый метод - умножить на ...

extension Int {

    func multiply(on number: Int) -> Int {
        return self * number
    }
}

// Далее мы можем использовать функцию из расширения:

let number = 12
let secondNumber = number.multiply(on: 15)

print(secondNumber)

// Так же расширения позволяют "расширить" протоколы, задав реализацию по умолчанию.
// Расширения не могут хранить в себе значения (stored properties).

// Подробнее про протоколы:
// https://apptractor.ru/info/articles/znakomstvo-s-protokol-orientirovannyim-programmirovaniem-v-swift-2.html

// Документация по расширениям:
// https://swiftbook.ru/content/languageguide/extensions/
