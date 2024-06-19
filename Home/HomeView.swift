import SwiftUI

struct HomeView: View {
    
    @State private var parkingLotDataArray: [ParkingLotData] = []
    @State private var parkingLotDetail: ParkingLotData?
    
    var body: some View {
        
        Group {
            if !parkingLotDataArray.isEmpty {
                ZStack {
                    MapView(parkingLotDataArray: parkingLotDataArray, parkingLotDetail: $parkingLotDetail)
                        .onTapGesture {
                            parkingLotDetail = nil
                        }
                    ParkingNavView(parkingLotData: $parkingLotDetail)
                }
            }
            else {
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
    HomeView()
}
