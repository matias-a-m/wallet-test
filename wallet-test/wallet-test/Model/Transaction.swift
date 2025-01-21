import Foundation

struct Transaction: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    var amount: Double
    var date: Date
}

