import SwiftUI
import MapKit

struct HomeView: View {
    
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var parkingLotDataArray: [ParkingLotData] = []
    
    var body: some View {
        
        Group {
            if !parkingLotDataArray.isEmpty {
                Map(position: $cameraPosition) {
                    
                    Marker("Me", coordinate: .userLocation)
                    
                    ForEach(parkingLotDataArray) { parkingLot in
                        if let coordinateData = parkingLot.entranceCoord.entrancecoordInfo.first?.coordinate {
                            Marker(parkingLot.name, coordinate: coordinateData)
                        }
                    }
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

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 25.021532926656562, longitude: 121.53427320263013)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation,
                     latitudinalMeters: 1000,
                     longitudinalMeters: 1000)
    }
}

#Preview {
    HomeView()
}
