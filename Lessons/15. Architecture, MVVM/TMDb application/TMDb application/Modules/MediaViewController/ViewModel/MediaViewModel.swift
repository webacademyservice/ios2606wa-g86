//
//  MediaViewModel.swift
//  TMDb application
//
//  Created by Alexander on 15.08.2021.
//

import Foundation
import RealmSwift

class MediaViewModel {
    
    let realm = try? Realm()
    
    var movies: [Movie] = []
    var actors: [Actor] = []

    func loadMovies(completion: @escaping(() -> ())) {
        NetworkManager.shared.requestTrendingMovies(completion: { movies in
            self.movies = movies
            completion()
        })
    }
    
    func loadActors(completion: @escaping(() -> ())) {
        NetworkManager.shared.requestTrendingActors(completion: { actors in
            self.actors = actors
            completion()
        })
    }
}
