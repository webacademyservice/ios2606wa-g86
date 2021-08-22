//
//  Constants.swift
//  TMDb application
//
//  Created by Alexander on 14.08.2021.
//

import Foundation

struct Constants {
    
    struct network {

        static let apiKey = "96cfbe0ba15c4721bca8030e8e32becb"

        static let popularMoviePath = "https://api.themoviedb.org/3/"

        static let defaultImagePath = "https://image.tmdb.org/t/p/original/"
        static let defaultPath = "https://api.themoviedb.org/3/"
    }
    
    struct viewControllerTitles {
        static let media = "Media"
        static let watchLater = "Watch later"
    }
    
    struct ui {
        static let defaultCellIdentifier = "Cell"
        static let movieSavedMessage = "Movie saved!"
        static let okMessage = "Cool 👌"
    }
    
}
