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
                            parkingLotDetail = nil
                            showSmartNav = false
                        }
                    if showParkingLotDetail {
                        if let parkingLotDetail {
                            ParkingNavView(parkingLotData: $parkingLotDetail)
                        }
                    }
                    if showSmartNav {
                        SmartNavView()
                    }
                }
            }
            else {
                ProgressView()
            }
            
            Button {
                showSmartNav.toggle()
            } label: {
                Image("SmartSearch")
                    .resizable()
                    .frame(width: 80, height: 80)
            }
            .offset(y:355)
        }
        .onAppear {
            fetchParkingLotData()
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar, content: {
                
                    HStack {
                        Button {
                            
                        } label: {
                            Image("Home_selected")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image("Assistant")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        Spacer().frame(width: 120)
                        Button {
                            
                        } label: {
                            Image("Favorite")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image("Setting")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                    .padding(.horizontal, 20)
                    .background {
                        Image("HomeToolBarBg")
                            .foregroundColor(.white)
                            .shadow(radius:10)
                    }
                    .offset(x: 0, y:10)
                
            })
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
    }
}
