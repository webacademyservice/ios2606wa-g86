//
//  ViewModel.swift
//  TMDb application
//
//  Created by Alexander on 21.08.2021.
//

import Foundation
import os

class MediaDetailViewModel {

    var movie: Movie?
    
    func loadMovieVideoKey(_ movieId: String, completion: @escaping((String) -> ())) {
        
        NetworkManager.shared.loadMovieVideoKey(movieId, completion: { videoKey in
            completion(videoKey)
        })
    }
    
    func saveMovieInRealm(_ movie: Movie?, completion: @escaping(() -> ())) {
        
        guard let movie = movie else {
            os_log("There is no movie to save")
            return
        }
        
        DataManager.shared.saveMovie(movie, completion: completion)
    }
}

