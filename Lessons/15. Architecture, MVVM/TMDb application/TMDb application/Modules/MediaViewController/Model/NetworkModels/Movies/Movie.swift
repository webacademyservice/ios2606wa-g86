import Foundation

struct Movie: Codable {

	var adult: Bool?
	let backdropPath: String?
	let id: Int?
    var genreIds: [Int]?
    var originalLanguage: String?
    var originalTitle: String?
	let posterPath: String?
    var video: Bool?
    var voteAverage: Double?
	let overview: String?
    var releaseDate: String?
    var voteCount: Int?
	let title: String?
	let popularity: Double?
	let mediaType: String?

	enum CodingKeys: String, CodingKey {

		case adult = "adult"
		case backdropPath = "backdrop_path"
		case id = "id"
		case genreIds = "genre_ids"
		case originalLanguage = "original_language"
		case originalTitle = "original_title"
		case posterPath = "poster_path"
		case video = "video"
		case voteAverage = "vote_average"
		case overview = "overview"
		case releaseDate = "release_date"
		case voteCount = "vote_count"
		case title = "title"
		case popularity = "popularity"
		case mediaType = "media_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
        genreIds = try values.decodeIfPresent([Int].self, forKey: .genreIds)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
		video = try values.decodeIfPresent(Bool.self, forKey: .video)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
	}
    
    public init(from movieRealm: MovieRealm) {

        self.title = movieRealm.title
        self.popularity = movieRealm.popularity
        self.overview = movieRealm.overview
        self.id = movieRealm.id
        self.backdropPath = movieRealm.backdropPath
        self.mediaType = movieRealm.mediaType
        self.posterPath = movieRealm.posterPath
        
    }
}
