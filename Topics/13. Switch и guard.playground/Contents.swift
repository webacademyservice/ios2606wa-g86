// MARK: - Switch

// Расширенный вариант конструкции if else. Простой пример оператора switch:

var age = 30

switch age {
    case 0...18:
        print("Kid")
    case 19...30:
        print("Meadle age")
    case 30...50:
        print("Adult")
    default:
        print("Old")
}

// Подробнее о switch:
// https://metanit.com/swift/tutorial/2.7.php

// Документация по инструкциям:
// https://swiftbook.ru/content/language-reference/statements/

// MARK: - Guard

// Guard - это более удобная форма записи каскада из if операторов. Простой пример
// функции без guard:

let condition1 = true
let condition2 = true
let condition3 = true
let condition4 = true
let condition5 = true
let condition6 = true

func printIfAllAreTrue() {
    if condition1 {
        if condition2 {
            if condition3 {
                if condition4 {
                    if condition5 {
                        if condition6 {
                            print("")
                        }
                    }
                }
            }
        }
    }
}

// Та же самая функция с guard:


func printIfAllAreTrueWithGuard() {
    guard condition1 else { return }
    guard condition2 else { return }
    guard condition3 else { return }
    guard condition4 else { return }
    guard condition5 else { return }
    guard condition6 else { return }
    print("")
}

// Подробнее о guard и defer:
// https://oxozle.com/2016/01/10/nachalo-swift-guard-i-defer/

// Документация по инструкциям:
// https://swiftbook.ru/content/language-reference/statements/

