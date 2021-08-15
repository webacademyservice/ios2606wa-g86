//
//  MovieRealm.swift
//  TMDb application
//
//  Created by Alexander on 31.07.2021.
//

import Foundation
// Импортировали RealmSwift
import RealmSwift

class MovieRealm: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var overview = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var backdropPath = ""
    @objc dynamic var mediaType = ""
    @objc dynamic var posterPath = ""

}
