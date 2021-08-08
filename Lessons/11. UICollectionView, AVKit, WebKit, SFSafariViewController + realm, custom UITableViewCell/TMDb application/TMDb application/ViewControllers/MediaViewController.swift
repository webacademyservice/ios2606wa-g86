//
//  ViewController.swift
//  TMDb application
//
//  Created by Oleksandr Slobodianiuk on 25.07.2021.
//

import UIKit
import Alamofire
import RealmSwift

class MediaViewController: UIViewController {

    // Создаем объект реалм
    let realm = try? Realm()
    
    // Перетянули UITableView из Main.storyboard в код, чтобы можно было работать с ней
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // В этой переменной мы будем хранить данные для UITableView
    var movies: [Movie] = []
    var actors: [Actor] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Регистрируем ячейку для UITableView, по идентификатору Cell. Если вы создаете свою (кастомную) ячейку, вы должны указать ее класс вместо UITableViewCell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.collectionView.register(UINib(nibName: "ActorCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "ActorCollectionViewCell")
        self.title = "Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Во время появления контроллера выполняем загрузку фильмов и актеров:
        self.requestTrendingMovies()
        self.requestTrendingActors()
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
    
    /// Метод запрашивает фильмы и обновляет таблицу после получения ответа.
    func requestTrendingActors() {
        
        let url = "https://api.themoviedb.org/3/person/popular?api_key=96cfbe0ba15c4721bca8030e8e32becb&language=en-US&page=1"

        // Выполним запрос по URL который мы создали выше:
        AF.request(url).responseJSON { responce in

            // Переменная responce имеет тип JSON, приводим ее к типу PopularMovieResult
            let decoder = JSONDecoder()

            if let data = try? decoder.decode(PopularActorsResult.self, from: responce.data!) {

                // Если получилось привести, сохраняем в локальную переменную movies список фильмов, который мы получили из интернета:
                self.actors = data.actors ?? []

                // Локальный список обновлен, теперь перезагрузим данные для таблицы:
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension MediaViewController: UITableViewDataSource {

    /// Метод должен возвращать количество ячеек в таблице
    /// - Parameters:
    ///   - tableView: Наша таблица (UITableView)
    ///   - section: Числовое значение, намер секции для которого мы возвращаем количество ячеек. Этот параметр нужен чтобы мы могли добавить условие, если секция 0, вернуть N ячеек, если секция 1, вернуть X ячеек и т д. Мы пока работаем только с 1 секцией, так что нам этот параметр не важен.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }

    /// Создаем ячейку для нашей таблицы и возвращаем ее
    /// - Parameters:
    ///   - tableView: Наша таблица (UITableView)
    ///   - indexPath: Индекс  ячейки которую мы создаем. Имеет параметр .section и .row, мы используем .row
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

extension MediaViewController: UITableViewDelegate {

    /// Метод срабатывает по нажатию на ячейку tableView
    /// - Parameters:
    ///   - tableView: Наша таблица (UITableView)
    ///   - indexPath: Индекс выбранной ячейки. Имеет параметр .section и .row, мы используем .row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let identifier = String(describing: MediaDetailViewController.self)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(identifier: identifier) as? MediaDetailViewController {
            
            detailViewController.movie = self.movies[indexPath.row]
            
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}



extension MediaViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCollectionViewCell", for: indexPath) as? ActorCollectionViewCell {
            cell.configureWith(actorName: self.actors[indexPath.row].name, imageURL: "")
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension MediaViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}
