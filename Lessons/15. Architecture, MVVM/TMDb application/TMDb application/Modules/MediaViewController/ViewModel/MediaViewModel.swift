//
//  MediaViewModel.swift
//  TMDb application
//
//  Created by Alexander on 15.08.2021.
//

import Foundation
import RealmSwift

class MediaViewModel {
    
    // Создаем объект реалм
    let realm = try? Realm()
    
    // В этой переменной мы будем хранить данные для UITableView
    var movies: [Movie] = []
    var actors: [Actor] = []

    func loadMovies(completion: @escaping(() -> ())) {
        // Во время появления контроллера выполняем загрузку фильмов и актеров:
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
