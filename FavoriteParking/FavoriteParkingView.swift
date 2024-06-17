import SwiftUI

struct FavoriteParkingView: View {
    
    let favorieParkingData: [FavoriteParking]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Spacer().frame(height: 30)
                    ForEach(favorieParkingData) { parking in
                        ParkingView(parkingData: parking)
                        Spacer().frame(height: 20)
                    }
                }
            }
        }
        .navigationTitle("常用停車場")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    
    NavigationStack {
        FavoriteParkingView(favorieParkingData: [FavoriteParking(img: "", name:"A停車場", pricePerHour: 10),
            FavoriteParking(img: "", name:"B停車場", pricePerHour: 20),
            FavoriteParking(img: "", name:"C停車場", pricePerHour: 30),
            FavoriteParking(img: "", name:"D停車場", pricePerHour: 40),
            FavoriteParking(img: "", name:"E停車場", pricePerHour: 50),
            FavoriteParking(img: "", name:"F停車場", pricePerHour: 60)])
    }
}
