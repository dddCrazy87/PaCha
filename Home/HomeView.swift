import SwiftUI

struct HomeView: View {
    
    @State private var parkingLotDataArray: [ParkingLotData] = []
    @State private var parkingLotDetail: ParkingLotData?
    @State private var showParkingLotDetail = false
    @State private var showSmartNav = false
    
    var body: some View {
        
        ZStack {
            if !parkingLotDataArray.isEmpty {
                ZStack {
                    MapView(parkingLotDataArray: parkingLotDataArray, parkingLotDetail: $parkingLotDetail, showParkingLotDetail: $showParkingLotDetail)
                        .onTapGesture {
                            showParkingLotDetail = false
                            showSmartNav = false
                        }
                }
            }
            else {
                ProgressView()
            }
            
            if showParkingLotDetail {
                ParkingNavView(parkingLotData: $parkingLotDetail)
                    .onAppear {
                        print("Detail apear")
                    }
            }
            
            if showSmartNav {
                SmartNavView()
            }
            
            HStack {
                Button {
                    GlobalState.shared.viewController = "HomeView"
                } label: {
                    Image("Home_selected")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                .padding(.leading, 20)
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
                    showSmartNav.toggle()
                } label: {
                    Image("SmartSearch")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                .offset(y: -35)
                Spacer()
                Button {
                    GlobalState.shared.viewController = "FavoriteParkingView"
                } label: {
                    Image("Favorite")
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
                .padding(.trailing, 20)
            }
            .padding(.horizontal, 20)
            .background {
                Image("HomeToolBarBg")
                    .resizable()
                    .frame(width: 400, height: 140)
                    .shadow(radius:10)
                    .offset(x:-1.66, y:5)
            }
            .offset(x: 0, y:360)
            

        }
        .onAppear {
            fetchParkingLotData()
        }
    }
    
    func fetchParkingLotData() {
        guard let url = URL(string: "https://run.mocky.io/v3/c65aa119-3ed4-4163-89f6-75dc7a23bb10") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([ParkingLotData].self, from: data) {
                    DispatchQueue.main.async {
                        self.parkingLotDataArray = decodedResponse
                    }
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}



#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(GlobalState.shared)
    }
}
