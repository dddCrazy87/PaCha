import Foundation

struct FavoriteParking:Identifiable {
    let id = UUID()
    var img = ""
    var name = ""
    var pricePerHour = 0
}

struct HistoryParking:Identifiable {
    let id = UUID()
    var name = ""
    var date = ""
    var time = ""
    var price = 0
    var isParking = false
}
