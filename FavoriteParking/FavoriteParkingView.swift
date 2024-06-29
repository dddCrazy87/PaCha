import SwiftUI

struct FavoriteParkingView: View {
    
    @Binding var parkingLotData: [ParkingLotDataForApp]
    @State private var sortByPrice = false
    @State private var toRemoveFavoriteList:[Int] = []
    
    var favorieParkingData: [ParkingLotDataForApp] {
        parkingLotData.filter { $0.isFavorite || $0.isRecommend }
    }
    
    var sortedParkingData: [(data: ParkingLotDataForApp, originalIndex: Int)] {
        let favoriteItems = parkingLotData.enumerated().filter { $0.element.isFavorite }
        if sortByPrice {
            let sortedItems = favoriteItems.sorted { $0.element.pricePerHour < $1.element.pricePerHour }
            return sortedItems.map { ($0.element, $0.offset) }
        }
        else {
            let sortedItems = favoriteItems.sorted { $0.element.distance < $1.element.distance }
            return sortedItems.map { ($0.element, $0.offset) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack {
                    ScrollView {
                        VStack {
                            Spacer().frame(height: 30)
                            ForEach(sortedParkingData.indices, id: \.self) { index in
                                let parking = sortedParkingData[index]
                                ParkingView(parkingData: parking.data, id: parking.originalIndex, toRemoveFavoriteList: $toRemoveFavoriteList)
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
                        .foregroundColor(Color("MainBg"))
                        .shadow(color: Color("TabBarShadow"), radius:10)
                        .offset(y:5)
                }
                .offset(x: 0, y:342)
            }
        }
        .onDisappear {
            for id in toRemoveFavoriteList {
                parkingLotData[id].isFavorite = false
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
    
    ContentView()
        .environmentObject(GlobalState.shared)
}
