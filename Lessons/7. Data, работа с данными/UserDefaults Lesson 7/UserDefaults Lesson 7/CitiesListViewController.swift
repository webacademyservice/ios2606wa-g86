//
//  CitiesListViewController.swift
//  UserDefaults Lesson 8
//
//  Created by Alexander Slobodjanjuk on 16.07.2021.
//

import UIKit

class CitiesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var cities: [String] = []

    let userDefaultsManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Задаем название контроллеру:
        self.title = "Посещенные города:"

        // Регистрируем ячейку:
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        // Достаем данные для отображения и добавляем их в проперти нашего контроллера:
        self.cities = self.getCities()
    }

    // По нажатию на плюсик выполняется функция:

    @IBAction func plusButtonPressed(_ sender: Any) {

        // Создаем аллект контроллер:
        let alert = UIAlertController(title: "City",
                                      message: "Add a new city",
                                      preferredStyle: .alert)

        // Создаем кнопку Save c замыканием - оно выполнится по нажатию на эту кнопку:
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in

            // Проверяем, есть ли в аллерт контроллере текстфилд и есть ли в нем текст:
            guard let textField = alert.textFields?.first,
                  let cityToSave = textField.text else {
                return
            }
            // Вызываем функцию сохранения названия города:
            self.save(cityToSave)

            // Обновляем данные в проперти cities, и перезагружаем данные в таблице:

            self.cities = self.getCities()
            self.tableView.reloadData()

            // Таблица по умолчанию подтягивает данные из проперти "города".
            // Мы просто говорим ей "обнови свое состояние", подтянув свежие данные.
        }

        // Создаем еще одну кнопку - Cancel с помощью которой его можно будет закрыть:
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        // Добавляем текстфилд:
        alert.addTextField()

        // Добавляем созданные выше кнопки в аллерт контроллер:
        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        // Показываем аллерт контроллер:
        present(alert, animated: true)
    }

    // Добавляем функцию сохранения города в UserDefaults:

    func save(_ city: String) {

        // Для наглядности создадим 2 массива:

        // Создадим массив c данными, которые уже сохранены по ключу Cities:
        let savedArray = self.userDefaultsManager.getStringsArray(for: "Cities")

        // Создадим массив, который мы будем сохранять. Он равен массиву, который мы достали:
        var updatedArray = savedArray
        // И добавляем в него новое значение:
        updatedArray.append(city)

        // Удалим старый массив по ключу Cities:
        self.userDefaultsManager.deleteValue(for: "Cities")

        // Сохраним новый массив:
        self.userDefaultsManager.save(updatedArray, for: "Cities")
    }

    // Добавляем функцию, которая достает данные из UserDefaults:

    func getCities() -> [String] {
        return self.userDefaultsManager.getStringsArray(for: "Cities")
    }
}

extension CitiesListViewController: UITableViewDataSource {

    // Метод, в котором мы указываем количество ячеек (rows) в таблице:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }

    // Метод, в котором мы создаем каждую ячейку:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = self.cities[indexPath.row]
        return cell ?? UITableViewCell()
    }
}
