//
//  NetworkManager.swift
//  TMDb application
//
//  Created by Alexander on 14.08.2021.
//

import Foundation
import Alamofire


struct NetworkManager: NetworkManagerProtocol {
    
    func loadListOfData() {
        //
    }
    
    static let shared = NetworkManager()
    
    /// Метод запрашивает фильмы и обновляет таблицу после получения ответа.
    func requestTrendingMovies(completion: @escaping(([Movie]) -> ())) {
        
        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=96cfbe0ba15c4721bca8030e8e32becb"

        // Выполним запрос по URL который мы создали выше:
        AF.request(url).responseJSON { responce in

            // Переменная responce имеет тип JSON, приводим ее к типу PopularMovieResult
            let decoder = JSONDecoder()

            if let data = try? decoder.decode(PopularMovieResult.self, from: responce.data!) {

                // Если получилось привести, сохраняем в локальную переменную movies список фильмов, который мы получили из интернета:
                let movies = data.movies ?? []
                completion(movies)
            }
        }
    }
    
    /// Метод запрашивает фильмы и обновляет таблицу после получения ответа.
    func requestTrendingActors(completion: @escaping(([Actor]) -> ())) {
        
        let url = "https://api.themoviedb.org/3/person/popular?api_key=96cfbe0ba15c4721bca8030e8e32becb&language=en-US&page=1"

        // Выполним запрос по URL который мы создали выше:
        AF.request(url).responseJSON { responce in

            // Переменная responce имеет тип JSON, приводим ее к типу PopularMovieResult
            let decoder = JSONDecoder()

            if let data = try? decoder.decode(PopularActorsResult.self, from: responce.data!) {

                // Если получилось привести, сохраняем в локальную переменную movies список фильмов, который мы получили из интернета:
                let actors = data.actors ?? []
                completion(actors)
            }
        }
    }
}


// Test examples:

protocol NetworkManagerADelegate: AnyObject {
    func dataLoaded(data: String)
}

struct NetworkManagerA {
    
    weak var delegate: NetworkManagerADelegate?
    
    func performRequest() {
        
        let resonce = "Some data from NetworkManagerA"
        self.delegate?.dataLoaded(data: resonce)
    }
}

struct NetworkManagerB {
    
    static let shared = NetworkManagerB()

    func performRequest(url: String, comletion: @escaping((String) -> ())) {
        let responce = "Some data from NetworkManagerB"
        comletion(responce)
    }
}
