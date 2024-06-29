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
            else if parkingLotDataArray.isEmpty {
                LoadingPageView()
            }
            else {
                NavigationStack {
                    
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
                }
            }
        }
        .onAppear {
            LocationManager.shared.requstLocation()
            fetchParkingLotData()
        }
        .onChange(of: parkingLotDataArray.first?.name) { oldValue, newValue in
            print("??")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalState.shared)
}

extension ContentView {
    func fetchParkingLotData() {
        guard let url = URL(string: "https://run.mocky.io/v3/860ba115-5c35-4323-8728-e45ed9c64ed2") else {
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] ?? []
                
                let decodedResponse = jsonArray.compactMap { element -> ParkingLotData? in
                    guard let elementData = try? JSONSerialization.data(withJSONObject: element) else {
                        return nil
                    }
                    return try? decoder.decode(ParkingLotData.self, from: elementData)
                }
                
                print("Successfully decoded \(decodedResponse.count) out of \(jsonArray.count) items")
                
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
            } catch {
                print("Error processing data: \(error)")
            }
        }.resume()
    }
}
