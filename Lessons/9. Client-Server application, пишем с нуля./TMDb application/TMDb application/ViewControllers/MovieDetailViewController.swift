//
//  MovieDetailViewController.swift
//  TMDb application
//
//  Created by Alexander Slobodjanjuk on 26.07.2021.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

    /// Аутлеты (IBOutlet) - все, что мы перетянули из main.storyboard
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!

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
    }

}
