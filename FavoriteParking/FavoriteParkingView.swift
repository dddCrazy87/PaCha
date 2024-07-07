import SwiftUI

struct FavoriteParkingView: View {
    
    @Binding var parkingLotData: [ParkingLotDataForApp]
    @State private var sortByPrice = false
    @State private var lastedRemovedIndex:Int = 0
    @State private var showUndoView = false
    @Environment(\.colorScheme) var colorScheme
    
    var sortedParkingData: [(data: ParkingLotDataForApp, originalIndex: Int)] {
        let favoriteItems = parkingLotData.enumerated().filter { $0.element.isFavorite || $0.element.isRecommend }
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
                                ParkingView(parkingData: parking.data, id: parking.originalIndex, lastedRemovedIndex: $lastedRemovedIndex, parkingLotData: $parkingLotData, showUndoView: $showUndoView)
                                Spacer().frame(height: 20)
                            }
                        }
                    }
                    Spacer().frame(height: 100)
                }
                
                if showUndoView {
                    VStack {
                        Spacer()
                        UndoFavoriteView(lastedRemovedIndex: $lastedRemovedIndex, parkingLotData: $parkingLotData, showUndoView: $showUndoView)
                        Spacer().frame(height: 90)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                            showUndoView = false
                        }
                    }
                }
                
            
                // tool bar
                
                HStack {
                    Button {
                        GlobalState.shared.viewController = "HomeView"
                    } label: {
                        if colorScheme == .dark {
                            Image("Home_dark")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        else {
                            Image("Home")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                    Spacer()
                    Button {
                        GlobalState.shared.viewController = "AssistantView"
                    } label: {
                        if colorScheme == .dark {
                            Image("Assistant_dark")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        else {
                            Image("Assistant")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
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
                        if colorScheme == .dark {
                            Image("Setting_dark")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        else {
                            Image("Setting")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
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
