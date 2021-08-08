//
//  WatchLaterViewController.swift
//  TMDb application
//
//  Created by Alexander on 01.08.2021.
//

import UIKit
import RealmSwift

class WatchLaterViewController: UIViewController {

    
    // Создаем объект реалм
    let realm = try? Realm()
    
    var movies: [MovieRealm] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //  Когда view отобразилась, вытаскиваем из realm фильмы и перезагружаем tableView:
        self.movies = self.getMovies()
        self.tableView.reloadData()
    }
    
    private func getMovies() -> [MovieRealm] {

        var movies = [MovieRealm]()
        guard let citiesResults = realm?.objects(MovieRealm.self) else { return [] }
        for movie in citiesResults {
            movies.append(movie)
        }
        return movies
    }
}

extension WatchLaterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = self.movies[indexPath.row].title
        return cell ?? UITableViewCell()
    }
}
