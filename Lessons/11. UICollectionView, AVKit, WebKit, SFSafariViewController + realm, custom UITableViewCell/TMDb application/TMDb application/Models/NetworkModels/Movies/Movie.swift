import Foundation

struct Movie: Codable {

	let adult: Bool?
	let backdropPath: String?
	let id: Int?
	let genreIds: [Int]?
	let originalLanguage: String?
	let originalTitle: String?
	let posterPath: String?
	let video: Bool?
	let voteAverage: Double?
	let overview: String?
	let releaseDate: String?
	let voteCount: Int?
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

}
