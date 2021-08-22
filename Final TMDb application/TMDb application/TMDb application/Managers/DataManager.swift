//
//  DataManager.swift
//  TMDb application
//
//  Created by Alexander on 21.08.2021.
//

import Foundation
import RealmSwift
import os

struct DataManager {
    
    let realm = try? Realm()

    static let shared = DataManager()

    private init() { }
    
    func saveMovie(_ movie: Movie, completion: @escaping(() -> ())) {
        
        let movieRealm = MovieRealm()
        
        movieRealm.title = movie.title ?? ""
        movieRealm.popularity = movie.popularity ?? 0.0
        movieRealm.overview = movie.overview ?? ""
        movieRealm.id = movie.id ?? 0
        movieRealm.backdropPath = movie.backdropPath ?? ""
        movieRealm.mediaType = movie.mediaType ?? ""
        movieRealm.posterPath = movie.posterPath ?? ""

        try? realm?.write {
            realm?.add(movieRealm)
        }
        completion()
    }
    
    func getAllMovies(completion: ([Movie])->()) {
        
        var moviesRealm = [MovieRealm]()
        guard let movieResults = realm?.objects(MovieRealm.self) else { return }
        for movie in movieResults {
            moviesRealm.append(movie)
        }
        
        completion(convertToMoviesList(moviesRealm: moviesRealm))
    }
    
    private func convertToMoviesList(moviesRealm: [MovieRealm]) -> [Movie] {

        var movies = [Movie]()
        for movieRealm in moviesRealm {
            let movie = Movie(from: movieRealm)
            movies.append(movie)
        }
        return movies
    }
}
