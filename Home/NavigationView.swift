import SwiftUI
import MapKit
import CoreLocation

struct NavigationView: View {
    
    @StateObject var compassHeading = CompassHeading()
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    @ObservedObject var locationManager = LocationManager.shared
    @State private var userCoordinate: CLLocationCoordinate2D?
    
    @Binding var selectedItem: MKMapItem?
    @State private var route: MKRoute?
    @State private var routeSteps:[(CLLocationCoordinate2D, String)] = []
    @State private var curStepIndex = 1
    @State private var expectedTravelTime:Double = 1
    
    @Binding var isNavigating:Bool
    
    var body: some View {
        
        ZStack {
            
            Map(position: $cameraPosition, selection: $selectedItem) {
                if let userCoordinate {
                    Annotation("", coordinate: userCoordinate) {
                        Image("CurPos")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .rotationEffect(Angle(degrees: compassHeading.degrees))
                            .animation(.easeInOut, value: compassHeading.degrees)
                    }
                }
                
                if let selectedItem {
                    Marker("", coordinate: selectedItem.placemark.coordinate)
                }
                
                if let route {
                    MapPolyline(route)
                        .stroke(.orange, lineWidth: 5)
                }
            }
            .onAppear {
                if let location = locationManager.userLocation?.coordinate {
                    cameraPosition = .region(MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500))
                }
            }
            .onReceive(locationManager.$userLocation) { location in
                if let location {
                    guard let currentCoordinate = userCoordinate else {
                        userCoordinate = location.coordinate
                        return
                    }
                    let distance = calculateDistance(from: currentCoordinate, to:  location.coordinate)
                    if distance > 5 {
                        userCoordinate = location.coordinate
                    }
                }
            }
            
            if !routeSteps.isEmpty {
                if curStepIndex > 0 && curStepIndex < routeSteps.count {
                    NavInstructionView(instruction: routeSteps[curStepIndex].1, expectedTravelTime: expectedTravelTime, isNavigating: $isNavigating)
                        .onChange(of: userCoordinate) {
                            if let userCoordinate {
                                if calculateDistance(from: userCoordinate, to: routeSteps[curStepIndex].0) < 30 {
                                    if curStepIndex < routeSteps.count {
                                        curStepIndex += 1
                                    }
                                }
                            }
                        }
                }
            }
            
        }
        .onAppear {
            getDirections()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalState.shared)
}

extension NavigationView {
    func getDirections() {
        if let location = locationManager.userLocation?.coordinate {
            self.route = nil
            
            guard selectedItem != nil else { return }
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: location))
            request.destination = self.selectedItem
            request.transportType = .automobile
            
            Task {
                let directions = MKDirections(request: request)
                let response = try? await directions.calculate()
                route = response?.routes.first
                
                if let route {
                    routeSteps = route.steps.map{($0.polyline.coordinate, $0.instructions)}
                    expectedTravelTime = route.expectedTravelTime
                }
            }
        }
    }
}

class CompassHeading: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @Published var degrees: Double = .zero
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.setup()
    }
    
    private func setup() {
        self.locationManager?.requestWhenInUseAuthorization()
        
        if CLLocationManager.headingAvailable() {
            self.locationManager?.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.degrees = newHeading.magneticHeading
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
