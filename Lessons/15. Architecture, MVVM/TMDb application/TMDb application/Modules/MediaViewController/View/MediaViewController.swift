//
//  ViewController.swift
//  TMDb application
//
//  Created by Oleksandr Slobodianiuk on 25.07.2021.
//

import UIKit

class MediaViewController: UIViewController {//, NetworkManagerADelegate {
    
//    func dataLoaded(data: String) {
//        print(data)
//    }

    // Перетянули UITableView из Main.storyboard в код, чтобы можно было работать с ней
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MediaViewModel = MediaViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Test examples
        
        var networkManagerA = NetworkManagerA()
//        networkManagerA.delegate = self
        networkManagerA.performRequest()
    
        NetworkManagerB.shared.performRequest(url: "") { responce in
            print(responce)
        }
        
        //---------------
        
        let actorCollectionViewCellIdentifier = String(describing: ActorCollectionViewCell.self)
        
        // Регистрируем ячейку для UITableView, по идентификатору Cell. Если вы создаете свою (кастомную) ячейку, вы должны указать ее класс вместо UITableViewCell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.collectionView.register(UINib(nibName: actorCollectionViewCellIdentifier, bundle: nil),
                                     forCellWithReuseIdentifier: actorCollectionViewCellIdentifier)
        self.title = Constants.viewControllerTitles.media
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel.loadMovies(completion: {
            self.tableView.reloadData()
        })
        self.viewModel.loadActors(completion: {
            self.collectionView.reloadData()
        })

    }
}

extension MediaViewController: UITableViewDataSource {

    /// Метод должен возвращать количество ячеек в таблице
    /// - Parameters:
    ///   - tableView: Наша таблица (UITableView)
    ///   - section: Числовое значение, намер секции для которого мы возвращаем количество ячеек. Этот параметр нужен чтобы мы могли добавить условие, если секция 0, вернуть N ячеек, если секция 1, вернуть X ячеек и т д. Мы пока работаем только с 1 секцией, так что нам этот параметр не важен.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movies.count
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
        cell.textLabel?.text = self.viewModel.movies[indexPath.row].title
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
            
            detailViewController.movie = self.viewModel.movies[indexPath.row]
            
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension MediaViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentActor = self.viewModel.actors[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCollectionViewCell", for: indexPath) as? ActorCollectionViewCell {
            cell.configureWith(actorName: currentActor.name,
                               profilePath: currentActor.profile_path)
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