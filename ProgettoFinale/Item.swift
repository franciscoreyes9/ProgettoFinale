import Foundation
        

struct Item: Identifiable, Codable {
    let id = UUID()
    var todo: String
}
