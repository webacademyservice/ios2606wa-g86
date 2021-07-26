
// MARK: - Array (массив)


// Array (массив) - упорядоченный список данных любого типа. Можно объявить через слово
// Array с указанием типа, или просто с указать тип в квадратных скобках:

var ukrainianCities: Array<String> = ["Kyiv", "Kharkiv",
                                      "Lviv", "Odessa",
                                      "Dnipro", "Chernihiv"]

var americanCities: [String] = ["San Francisco", "New York",
                                "Los Angeles", "Austin", "Chicago"]

// Также можем не указывать тип, но сразу указать, какие данные лежат внутри. Компилятор
// сам догадается, какой это тип.
var europeanCities = ["London", "Paris", "Berlin", "Rome", "Barcelona", "Lisbon"]

// К каждому элементу можно обратиться через индекс. Нумерация элементов начинается с нуля:
let capitalOfUkraine = ukrainianCities[0]


// Самые популярные методы для работы с массивом.

// Добавить элемент:
americanCities.append("Boston")

// Удалить элемент по индексу:
americanCities.remove(at: 2)

// [].count - получить количество элементов
print(ukrainianCities.count)

// [].first, [].last - получить первый и последний элемент массива
print(ukrainianCities.first)
print(ukrainianCities.last)

// Статья про массивы:
// https://metanit.com/swift/tutorial/2.9.php


// MARK: - Dictionary (словарь)


// Dictionary (словарь) - неупорядоченный список данных любого типа. В отличии от Array,
// обратиться к элементам можно по ключу. В качестве ключа может быть любой тип данных
// из изученных:

let phone: [String: Int] = [:]

// Статья про словари:
// https://metanit.com/swift/tutorial/2.12.php



