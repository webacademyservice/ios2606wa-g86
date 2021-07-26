//
//  ViewController.swift
//  TMDb application
//
//  Created by Oleksandr Slobodianiuk on 25.07.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.requestTrendingMovies()
    }
    
    func requestTrendingMovies() {
        
        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=96cfbe0ba15c4721bca8030e8e32becb"

        AF.request(url).responseJSON { responce in

            let decoder = JSONDecoder()

            if let data = try? decoder.decode(PopularMoviewResult.self, from: responce.data!) {

                self.movies = data.results ?? []
                self.tableView.reloadData()
            }
        }
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            return UITableViewCell()
        }

        cell.textLabel?.text = self.movies[indexPath.row].title
        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let identifier = String(describing: MovieDetailViewController.self)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(identifier: identifier) as? MovieDetailViewController {
            
            detailViewController.movie = self.movies[indexPath.row]
            
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
