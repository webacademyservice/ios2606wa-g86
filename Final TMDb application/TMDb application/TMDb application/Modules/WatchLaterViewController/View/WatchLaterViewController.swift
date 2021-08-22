//
//  WatchLaterViewController.swift
//  TMDb application
//
//  Created by Alexander on 01.08.2021.
//

import UIKit

class WatchLaterViewController: UIViewController {
    
    var viewModel: WatchLaterViewModel = WatchLaterViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.ui.defaultCellIdentifier)
        self.title = Constants.viewControllerTitles.watchLater
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getMovies()
    }
    
    private func getMovies() {
        self.viewModel.getAllMovies {
            self.tableView.reloadData()
        }
    }
}

extension WatchLaterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ui.defaultCellIdentifier)
        cell?.textLabel?.text = self.viewModel.movies[indexPath.row].title
        return cell ?? UITableViewCell()
    }
}
