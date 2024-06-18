import SwiftUI
import MapKit

struct MapView: View {
    
    @State var parkingLotDataArray: [ParkingLotData]
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var searchText = ""
    
    var body: some View {
        Map(position: $cameraPosition) {
            
            Annotation("My location", coordinate: .userLocation) {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.blue.opacity(0.25))
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.blue)
                }
            }
            
            ForEach(parkingLotDataArray) { parkingLot in
                if let coordinateData = parkingLot.entranceCoord.entrancecoordInfo.first?.coordinate {
                    Marker(parkingLot.name, coordinate: coordinateData)
                }
            }
        }
        .overlay(alignment: .top) {
            TextField("搜尋地點...", text: $searchText)
                .font(.subheadline)
                .padding(12)
                .background(.white)
                .padding()
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
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
