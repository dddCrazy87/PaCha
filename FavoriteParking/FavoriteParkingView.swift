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
        NavigationStack {
            ZStack {
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
                
            
                // tool bar
                
                HStack {
                    Button {
                        GlobalState.shared.viewController = "HomeView"
                    } label: {
                        Image("Home")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    Spacer()
                    Button {
                        GlobalState.shared.viewController = "AssistantView"
                    } label: {
                        Image("Assistant")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    Spacer()
                    Button {
                        GlobalState.shared.viewController = "FavoriteParkingView"
                    } label: {
                        Image("Favorite_selected")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    Spacer()
                    Button {
                        GlobalState.shared.viewController = "SettingView"
                    } label: {
                        Image("Setting")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.horizontal, 60)
                .background {
                    Rectangle()
                        .frame(width: 400, height: 100)
                        .foregroundColor(.white)
                        .shadow(radius:10)
                        .offset(y:5)
                }
                .offset(x: 0, y:342)
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
            FavoriteParking(img: "", name:"A停車場", pricePerHour: 10, distance: 1.2, isRecommend: false),
            FavoriteParking(img: "", name:"B停車場", pricePerHour: 20, distance: 1.0, isRecommend: true),
            FavoriteParking(img: "", name:"C停車場", pricePerHour: 30, distance: 0.8, isRecommend: false),
            FavoriteParking(img: "", name:"D停車場", pricePerHour: 40, distance: 0.6, isRecommend: false),
            FavoriteParking(img: "", name:"E停車場", pricePerHour: 50, distance: 0.4, isRecommend: true),
            FavoriteParking(img: "", name:"F停車場", pricePerHour: 60, distance: 0.2, isRecommend: true)
        ])
        .environmentObject(GlobalState.shared)
    }
}
