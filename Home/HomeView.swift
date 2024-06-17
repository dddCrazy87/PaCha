import SwiftUI
import MapKit

struct HomeView: View {
    
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    var body: some View {
        Map(position: $cameraPosition) {
            Marker("Me", coordinate: .userLocation)
            
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
                     latitudinalMeters: 10000,
                     longitudinalMeters: 10000)
    }
}

#Preview {
    HomeView()
}
