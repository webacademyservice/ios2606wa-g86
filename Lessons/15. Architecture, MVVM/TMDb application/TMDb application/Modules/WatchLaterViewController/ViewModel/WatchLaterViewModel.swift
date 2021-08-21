//
//  WatchLaterViewModel.swift
//  TMDb application
//
//  Created by Alexander on 21.08.2021.
//

import Foundation
import os

class WatchLaterViewModel {

    var movies = [Movie]()
    
    func getAllMovies(completion: @escaping(() -> ())) {
        DataManager.shared.getAllMovies(completion: { movies in
            self.movies = movies
        })
    }
}
