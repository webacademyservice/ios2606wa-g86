// MARK: - Enum

// Энам, это перечисление, хранящее какие-либо "кейсы":

enum Moving: String {
    case run
    case walk
    case swim
}

// Создать екземпляр энама можно указав ему конкретный кейс

let test = Moving.run
print(test)


// Подробнее про Enum:
// https://metanit.com/swift/tutorial/3.8.php

// Документация:
// https://swiftbook.ru/content/languageguide/enumerations/

