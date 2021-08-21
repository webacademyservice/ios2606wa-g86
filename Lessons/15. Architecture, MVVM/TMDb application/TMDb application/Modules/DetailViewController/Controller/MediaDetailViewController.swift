//
//  MovieDetailViewController.swift
//  TMDb application
//
//  Created by Alexander Slobodjanjuk on 26.07.2021.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper

class MediaDetailViewController: UIViewController {
        
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var videoPlayerView: YTPlayerView!
    
    var viewModel: MediaDetailViewModel = MediaDetailViewModel()

    //MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailLabel.textColor = .white
        self.detailLabel.text = self.viewModel.movie?.overview

        if let posterPath = self.viewModel.movie?.backdropPath {
            let urlString = Constants.network.defaultImagePath + posterPath
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)
        }
        self.title = self.viewModel.movie?.title
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                            target: self,
                                            action: #selector(addToWatchLaterButtonPressed))
        self.navigationItem.rightBarButtonItem  = addButtonItem
        
        if let movieId = self.viewModel.movie?.id {
            let stringID = String(describing: movieId)
            self.requestVideos(with: stringID)
        }
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = .black
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    
    func requestVideos(with movieId: String) {

        self.viewModel.loadMovieVideoKey(movieId) { videoKey in
            self.videoPlayerView.load(withVideoId: videoKey)
        }
    }
    
    private func loadByKey(_ key: String) {
        self.videoPlayerView.load(withVideoId: key)
    }
    
    @objc func addToWatchLaterButtonPressed(){

        self.viewModel.saveMovieInRealm(self.viewModel.movie, completion: {
            let alert = UIAlertController(title: Constants.UI.movieSavedMessage, message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: Constants.UI.okMessage, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })

    }
}
