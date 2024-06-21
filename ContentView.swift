import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @EnvironmentObject var globalState: GlobalState
    
    @State private var parkingLotDataArray: [ParkingLotData] = []
    @State private var parkingLotDataArrayForApp: [ParkingLotDataForApp] = []
    
    @ObservedObject var locationManager = LocationManager.shared
    
    var body: some View {
        
        Group {
            if locationManager.userLocation == nil {
                LocationRequestView()
            }
            else if let location = locationManager.userLocation {
                
                NavigationStack {
                    
                    if !parkingLotDataArray.isEmpty {
                        
                        switch globalState.viewController {
                            
                        case "HomeView":
                            HomeView(parkingLotData: $parkingLotDataArrayForApp)
                        case "AssistantView":
                            AssistantView(historyParking: [])
                        case "FavoriteParkingView":
                            FavoriteParkingView(parkingLotData: $parkingLotDataArrayForApp)
                        case "SettingView":
                            SettingView()
                        default:
                            Text(GlobalState.shared.viewController)
                        }
                        
                    } else {
                        ProgressView()
                    }
                }
                .onAppear {
                    fetchParkingLotData()
                }
            }
        }
        .onAppear {
            LocationManager.shared.requstLocation()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalState.shared)
}

extension ContentView {
    func fetchParkingLotData() {
        guard let url = URL(string: "https://run.mocky.io/v3/c65aa119-3ed4-4163-89f6-75dc7a23bb10") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([ParkingLotData].self, from: data) {
                    DispatchQueue.main.async {
                        parkingLotDataArray = decodedResponse
                        
                        parkingLotDataArrayForApp = decodedResponse.map { parkingLot in
                            ParkingLotDataForApp(
                                name: parkingLot.name,
                                address: parkingLot.address,
                                payex: parkingLot.payex,
                                latitude: Double(parkingLot.y) ?? 0.0,
                                longitude: Double(parkingLot.x) ?? 0.0,
                                totalCar: parkingLot.totalcar,
                                parkingLotData: parkingLot
                            )
                        }
                    }
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
