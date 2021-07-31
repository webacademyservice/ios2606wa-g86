//
//  ViewController.swift
//  TMDb application
//
//  Created by Oleksandr Slobodianiuk on 25.07.2021.
//

import UIKit
import Alamofire
import RealmSwift

class ViewController: UIViewController {

    // Создаем объект реалм
    let realm = try? Realm()
    
    // Перетянули UITableView из Main.storyboard в код, чтобы можно было работать с ней
    @IBOutlet weak var tableView: UITableView!

    // В этой переменной мы будем хранить данные для UITableView
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Регистрируем ячейку для UITableView, по идентификатору Cell. Если вы создаете свою (кастомную) ячейку, вы должны указать ее класс вместо UITableViewCell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Во время появления контроллера выполняем загрузку фильмов:
        self.requestTrendingMovies()
    }

    /// Метод запрашивает фильмы и обновляет таблицу после получения ответа.
    func requestTrendingMovies() {
        
        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=96cfbe0ba15c4721bca8030e8e32becb"

        // Выполним запрос по URL который мы создали выше:
        AF.request(url).responseJSON { responce in

            // Переменная responce имеет тип JSON, приводим ее к типу PopularMovieResult
            let decoder = JSONDecoder()

            if let data = try? decoder.decode(PopularMovieResult.self, from: responce.data!) {

                // Если получилось привести, сохраняем в локальную переменную movies список фильмов, который мы получили из интернета:
                self.movies = data.movies ?? []

                // Локальный список обновлен, теперь перезагрузим данные для таблицы:
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func displayButtonPressed(_ sender: Any) {
        
        let movies = self.getMovies()
        
        for (index, item) in movies.enumerated() {
            let indexString = String(describing: index + 1)
            print(indexString + " " + item.title)
            print()
        }
    }
    
    func getMovies() -> [MovieRealm] {

        var movies = [MovieRealm]()
        guard let citiesResults = realm?.objects(MovieRealm.self) else { return [] }
        for movie in citiesResults {
            movies.append(movie)
        }
        return movies
    }
    
}

extension ViewController: UITableViewDataSource {

    /// Метод должен возвращать количество ячеек в таблице
    /// - Parameters:
    ///   - tableView: Наша таблица (UITableView)
    ///   - section: Числовое значение, намер секции для которого мы возвращаем количество ячеек. Этот параметр нужен чтобы мы могли добавить условие, если секция 0, вернуть N ячеек, если секция 1, вернуть X ячеек и т д. Мы пока работаем только с 1 секцией, так что нам этот параметр не важен.
    /// - Returns: <#description#>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }

    /// Создаем ячейку для нашей таблицы и возвращаем ее
    /// - Parameters:
    ///   - tableView: Наша таблица (UITableView)
    ///   - indexPath: Индекс  ячейки которую мы создаем. Имеет параметр .section и .row, мы используем .row
    /// - Returns: <#description#>
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Достаем зарегистрированную ячейку по идентификатору Cell, если такой нет, возвращаем экземпляр UITableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            return UITableViewCell()
        }

        // Указываем текст который будет отображаться в ячейке - он храниться в проперти title у объекта Movie. Но сначала, чтобы обратиться к объекту Movie, достаем его из массива, обращаясь к нему по индексу [indexPath.row]
        cell.textLabel?.text = self.movies[indexPath.row].title
        return cell
    }
}

extension ViewController: UITableViewDelegate {

    /// Метод срабатывает по нажатию на ячейку tableView
    /// - Parameters:
    ///   - tableView: Наша таблица (UITableView)
    ///   - indexPath: Индекс выбранной ячейки. Имеет параметр .section и .row, мы используем .row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let identifier = String(describing: MovieDetailViewController.self)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(identifier: identifier) as? MovieDetailViewController {
            
            detailViewController.movie = self.movies[indexPath.row]
            
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
