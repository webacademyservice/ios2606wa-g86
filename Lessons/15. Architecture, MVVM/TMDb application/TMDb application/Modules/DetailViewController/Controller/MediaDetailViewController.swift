//
//  MovieDetailViewController.swift
//  TMDb application
//
//  Created by Alexander Slobodjanjuk on 26.07.2021.
//

import UIKit
import SDWebImage
import RealmSwift
import youtube_ios_player_helper
import Alamofire

class MediaDetailViewController: UIViewController {
    
    // Создаем объект реалм
    let realm = try? Realm()
    
    /// Аутлеты (IBOutlet) - все, что мы перетянули из main.storyboard
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var videoPlayerView: YTPlayerView!
    
    /// Переменная, которая нам нужна, чтобы в этот контроллер можно было передать объект Movie
    var movie: Movie? = nil

    /// Часть URL для загрузки картинок. URL для загрузки любой картинки начинается с этой строки.
    let baseImageURL = "https://image.tmdb.org/t/p/original/"

    //MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Метод вызвался сразу при открытии контроллера. Мы указываем значения текста для detailLabel
        self.detailLabel.text = self.movie?.overview

        // И загружаем картинку в posterImageView. Если мы можем достать poster_path из объекта Movie
        if let posterPath = self.movie?.posterPath {

            // Тогда создадим полную ссылку на картинку
            let urlString = self.baseImageURL + posterPath

            // И с помощью библиотеки SDWebImage задаем posterImageView картинку, загруженную по url
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)
        }
        self.title = self.movie?.title
        
        
        let logoutBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addToWatchLaterButtonPressed))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        
        
        if let id = self.movie?.id {
            let stringID = String(describing: id)
            self.requestVideos(with: stringID)
        }
        
    }
    
    /// Метод запрашивает фильмы и обновляет таблицу после получения ответа.
    func requestVideos(with id: String) {
//        https://www.youtube.com/watch?v=VVnZd8A84z4
        let url = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=96cfbe0ba15c4721bca8030e8e32becb&language=en-US"
        
        // Выполним запрос по URL который мы создали выше:
        AF.request(url).responseJSON { response in

            // Переменная responce имеет тип JSON, приводим ее к типу PopularMovieResult
            let decoder = JSONDecoder()

            if let data = try? decoder.decode(Json4Swift_Base.self, from: response.data!) {
                print(data)
                let id = data.videos?.first?.key
                self.videoPlayerView.load(withVideoId: "VVnZd8A84z4")
            }
        }
    }
    
    private func loadByKey(_ key: String) {
        
        print(key)
        print("SUCCESS!")
        
                self.videoPlayerView.load(withVideoId: key)

    }
    
    @objc func addToWatchLaterButtonPressed(){
        let movieRealm = MovieRealm()
        
        movieRealm.title = self.movie?.title ?? ""
        movieRealm.popularity = self.movie?.popularity ?? 0.0
        movieRealm.overview = self.movie?.overview ?? ""
        movieRealm.id = self.movie?.id ?? 0
        movieRealm.backdropPath = self.movie?.backdropPath ?? ""
        movieRealm.mediaType = self.movie?.mediaType ?? ""
        movieRealm.posterPath = self.movie?.posterPath ?? ""

        try? realm?.write {
            realm?.add(movieRealm)
        }
    }
}
