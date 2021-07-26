//
//  Topics.swift
//  TableView - practice
//
//  Created by Alexander Slobodjanjuk on 11.07.2021.
//

import UIKit

struct Topics {


    static var topicsList: [Topic] = [Topic(name: "Xcode Installation, Setup. Playground. Язык swift, переменные, функции, замыкания", imageName: "1"),
                                      Topic(name: "Структуры данных, циклы. Алгоритмы. Управление памятью. Инструменты", imageName: "18"),
                                      Topic(name: "OOP, классы и структуры. UIViewController", imageName: "2"),
                                      Topic(name: "POP, protocols, extensions. Enum", imageName: "3"),
                                      Topic(name: "User Interface, AutoLayout, Animations", imageName: "4"),
                                      Topic(name: "UITableView, custom cells. Navigation. Жизненные цикл приложения", imageName: "5"),
                                      Topic(name: "Хранение данных", imageName: "6"),
                                      Topic(name: "Менеджеры зависимостей. Парсинг данных, обработка ошибок, сохранение данных", imageName: "7"),
                                      Topic(name: "Простое клиент-серверное приложение", imageName: "8"),
                                      Topic(name: "UICollectionView", imageName: "9"),
                                      Topic(name: "Web view, AVKit", imageName: "10"),
                                      Topic(name: "Map Kit. Операции с картой", imageName: "11"),
                                      Topic(name: "Многопоточность в iOS, проблемы многопоточности. Что такое GCD", imageName: "12"),
                                      Topic(name: "Архитектура", imageName: "13"),
                                      Topic(name: "Паттерны", imageName: "14"),
                                      Topic(name: "Swift UI", imageName: "15"),
                                      Topic(name: "SOLID. Правила написания красивого кода. Рефакторинг", imageName: "16"),
                                      Topic(name: "Сдача проектов", imageName: "17")]
}

struct Topic {
    var name: String
    var imageName: String
}
