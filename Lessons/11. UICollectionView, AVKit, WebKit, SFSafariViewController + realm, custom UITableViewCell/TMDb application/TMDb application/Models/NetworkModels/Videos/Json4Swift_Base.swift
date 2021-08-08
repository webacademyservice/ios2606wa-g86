import Foundation

struct Json4Swift_Base : Codable {
    
	let id: Int?
    let videos: [Video]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case videos = "results"
	}

}
