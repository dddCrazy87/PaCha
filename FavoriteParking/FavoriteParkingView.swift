import SwiftUI

struct FavoriteParkingView: View {
    
    let favorieParkingData: [FavoriteParking]
    
    @State private var sortByPrice = false
    
    var sortedParkingData: [FavoriteParking] {
        if sortByPrice {
            return favorieParkingData.sorted { $0.pricePerHour < $1.pricePerHour }
        } else {
            return favorieParkingData.sorted { $0.distance < $1.distance }
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Spacer().frame(height: 30)
                    ForEach(sortedParkingData) { parking in
                        ParkingView(parkingData: parking)
                        Spacer().frame(height: 20)
                    }
                }
            }
        }
        .navigationTitle("常用停車場")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                
                Button {
                    sortByPrice.toggle()
                } label: {
                    if sortByPrice {
                        Image("SortByPrice")
                            .resizable()
                            .frame(width: 30, height: 26)
                    }
                    else {
                        Image("SortByDistance")
                            .resizable()
                            .frame(width: 30, height: 26)
                    }
                }
            })
        }
    }
}

#Preview {
    
    NavigationStack {
        FavoriteParkingView(favorieParkingData: [
            FavoriteParking(img: "", name:"A停車場", pricePerHour: 10, distance: 1.2),
            FavoriteParking(img: "", name:"B停車場", pricePerHour: 20, distance: 1.0),
            FavoriteParking(img: "", name:"C停車場", pricePerHour: 30, distance: 0.8),
            FavoriteParking(img: "", name:"D停車場", pricePerHour: 40, distance: 0.6),
            FavoriteParking(img: "", name:"E停車場", pricePerHour: 50, distance: 0.4),
            FavoriteParking(img: "", name:"F停車場", pricePerHour: 60, distance: 0.2)])
    }
}
