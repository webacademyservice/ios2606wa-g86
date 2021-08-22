import Foundation

struct Actor : Codable {
	let adult : Bool?
	let gender : Int?
	let id : Int?
	let known_for : [Known_for]?
	let known_for_department : String?
	let name : String?
	let popularity : Double?
	let profile_path : String?

	enum CodingKeys: String, CodingKey {

		case adult = "adult"
		case gender = "gender"
		case id = "id"
		case known_for = "known_for"
		case known_for_department = "known_for_department"
		case name = "name"
		case popularity = "popularity"
		case profile_path = "profile_path"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
		gender = try values.decodeIfPresent(Int.self, forKey: .gender)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		known_for = try values.decodeIfPresent([Known_for].self, forKey: .known_for)
		known_for_department = try values.decodeIfPresent(String.self, forKey: .known_for_department)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		profile_path = try values.decodeIfPresent(String.self, forKey: .profile_path)
	}

}
