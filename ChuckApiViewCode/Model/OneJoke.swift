
import Foundation

struct OneJoke: Codable {
    var id: String
    let categories: [String]
    let iconUrl: String
    var value: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case categories
        case iconUrl = "icon_url"
        case value
    }
}

