import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var globalState: GlobalState
    
    @State private var parkingLotDataArray: [ParkingLotData] = []
    @State private var parkingLotDataArrayForApp: [ParkingLotDataForApp] = []
    
    var body: some View {
        
        NavigationStack {
            
            if !parkingLotDataArray.isEmpty {
            
                switch globalState.viewController {
                    
                case "HomeView":
                    HomeView(parkingLotData: $parkingLotDataArrayForApp)
                        .environmentObject(GlobalState.shared)
                    
                case "AssistantView":
                    AssistantView(historyParking: [
                        HistoryParking(name: "A停車場", date: "2024/06/01", time: "00:00 AM", price: 10),
                        HistoryParking(name: "B停車場", date: "2024/06/02", time: "00:00 AM", price: 20),
                        HistoryParking(name: "C停車場", date: "2024/06/03", time: "00:00 AM", price: 30),
                        HistoryParking(name: "D停車場", date: "2024/06/04", time: "00:00 AM", price: 40),
                        HistoryParking(name: "E停車場", date: "2024/06/05", time: "00:00 AM", price: 50),
                        HistoryParking(name: "F停車場", date: "2024/06/06", time: "00:00 AM", price: 60),
                        HistoryParking(name: "G停車場", date: "2024/06/07", time: "00:00 AM", price: 70)
                    ])
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

#Preview {
    ContentView()
        .environmentObject(GlobalState.shared)
}
