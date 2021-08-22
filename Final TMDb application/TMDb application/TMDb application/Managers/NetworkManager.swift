//
//  NetworkManager.swift
//  TMDb application
//
//  Created by Alexander on 14.08.2021.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    static let shared = NetworkManager()

    private init() { }
    
    func requestTrendingMovies(completion: @escaping(([Movie]) -> ())) {
        
        let url = Constants.network.defaultPath + "trending/movie/week?api_key=" + Constants.network.apiKey

        AF.request(url).responseJSON { responce in

            let decoder = JSONDecoder()

            if let data = try? decoder.decode(PopularMovieResult.self, from: responce.data!) {

                let movies = data.movies ?? []
                completion(movies)
            }
        }
    }
    
    func requestTrendingActors(completion: @escaping(([Actor]) -> ())) {
        
        let url = Constants.network.defaultPath + "person/popular?api_key=" + Constants.network.apiKey

        AF.request(url).responseJSON { responce in

            let decoder = JSONDecoder()

            if let data = try? decoder.decode(PopularActorsResult.self, from: responce.data!) {
                let actors = data.actors ?? []
                completion(actors)
            }
        }
    }
    
    func loadMovieVideoKey(_ movieId: String, completion: @escaping((String) -> ())) {
        
        let url = Constants.network.defaultPath + "movie/\(movieId)/videos?api_key=" + Constants.network.apiKey
        
        AF.request(url).responseJSON { response in

            let decoder = JSONDecoder()

            if let data = try? decoder.decode(MovieVideosResult.self, from: response.data!) {
                let videoKey =  data.videos?.first?.key ?? ""
                completion(videoKey)
            }
        }
    }
}
