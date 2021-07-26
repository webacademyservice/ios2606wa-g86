//
//  CitiesListViewController.swift
//  CoreData Lesson 8
//
//  Created by Alexander Slobodjanjuk on 16.07.2021.
//

import UIKit
// Импортируем CoreData:
import CoreData

class CitiesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    // Указываем, что в проперти cities храниться какой-то объект кор даты:
    var cities: [NSManagedObject] = []

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

    func save(_ cityName: String) {

        // Создаем AppDelegate экземпляр включающий в себя методы кор даты:
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        // Создаем экземпляр контекста:
        let managedContext = appDelegate.persistentContainer.viewContext

        // Достаем entity "City":
        let entity = NSEntityDescription.entity(forEntityName: "City", in: managedContext)!
        // Создаем city:
        let city = NSManagedObject(entity: entity, insertInto: managedContext)
        // Добавлем название города в качестве проперти "name"
        // При этом обращение происходит с помощью KVC, можно загуглить: KVC / KVO
        city.setValue(cityName, forKeyPath: "name")

        do {
            try managedContext.save()
            self.cities.append(city)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    // Добавляем функцию, которая достает данные из UserDefaults:

    func getCities() -> [NSManagedObject] {

        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return []
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "City")

        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
}

extension CitiesListViewController: UITableViewDataSource {

    // Метод, в котором мы указываем количество ячеек (rows) в таблице:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }

    // Метод, в котором мы создаем каждую ячейку:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let city = cities[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = city.value(forKeyPath: "name") as? String
        return cell ?? UITableViewCell()
    }
}
