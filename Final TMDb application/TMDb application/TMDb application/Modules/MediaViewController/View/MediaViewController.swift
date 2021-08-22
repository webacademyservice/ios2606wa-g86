//
//  ViewController.swift
//  TMDb application
//
//  Created by Oleksandr Slobodianiuk on 25.07.2021.
//

import UIKit
import os

class MediaViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MediaViewModel = MediaViewModel()

    // MARK: UIViewController life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel.loadMovies(completion: {
            self.tableView.reloadData()
        })
        self.viewModel.loadActors(completion: {
            self.collectionView.reloadData()
        })
        
        // Navigation Bar Setup
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    // MARK: - Private
    
    private func setupUI() {
        
        self.title = Constants.viewControllerTitles.media
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        // Register cells
        let actorCollectionViewCellIdentifier = String(describing: ActorCollectionViewCell.self)
        let mediaTableViewCellIdentifier = String(describing: MediaTableViewCell.self)
        
        self.collectionView.register(UINib(nibName: actorCollectionViewCellIdentifier, bundle: nil),
                                     forCellWithReuseIdentifier: actorCollectionViewCellIdentifier)
        self.tableView.register(UINib(nibName: mediaTableViewCellIdentifier, bundle: nil),
                                forCellReuseIdentifier: mediaTableViewCellIdentifier)
        
        // Remove line under UINavigationBar
        self.navigationController?.addCustomBottomLine(color: UIColor.clear, height: 0)
        
        // Add Content Inset to UITableView
        self.tableView.contentInset.top = 156
    }
}

extension MediaViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = String(describing: MediaTableViewCell.self)

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MediaTableViewCell else {
            os_log("Can not create \(cellIdentifier)")
            return UITableViewCell()
        }
        
        let media = self.viewModel.movies[indexPath.row]
        let imagePathString = Constants.network.defaultImagePath + media.posterPath!
        cell.configureWith(imageURL: URL(string: imagePathString),
                           title: media.title,
                           releaseDate: media.releaseDate,
                           overviewText: media.overview)
        return cell
    }
}

extension MediaViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controllerIdentifier = String(describing: MediaDetailViewController.self)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(identifier: controllerIdentifier)
            as? MediaDetailViewController {
            detailViewController.viewModel.movie = self.viewModel.movies[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MediaViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = String(describing: ActorCollectionViewCell.self)
        
        let currentActor = self.viewModel.actors[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                            for: indexPath) as? ActorCollectionViewCell else {
            os_log("Can not create \(cellIdentifier)")
            return UICollectionViewCell()
        }
        cell.configureWith(actorName: currentActor.name, profilePath: currentActor.profile_path)
        return cell
    }
}

extension MediaViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}
