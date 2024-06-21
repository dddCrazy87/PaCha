import SwiftUI
import MapKit
import CoreLocation

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

struct NavigationView: View {
    
    @StateObject var compassHeading = CompassHeading()
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    @ObservedObject var locationManager = LocationManager.shared
    @State private var userCoordinate: CLLocationCoordinate2D?
    
    @Binding var selectedItem: MKMapItem?
    @State private var route: MKRoute?
    @State private var instructions:[String] = []
    
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
            
            VStack {
                HStack(alignment: .bottom) {
                    Image(systemName: "arrow.up")
                        .resizable()
                        .frame(width: 30, height: 50)
                        .bold()
                    HStack {
                        Text("直行")
                            .font(.callout)
                            .bold()
                        
                        Text("OX路11巷")
                            .font(.title2)
                    }
                    
                    Spacer().frame(width: 150)
                }
                .background {
                    UnevenRoundedRectangle(cornerRadii: .init(
                        topLeading: 30,
                        bottomLeading: 0,
                        bottomTrailing: 30,
                        topTrailing: 30),
                        style: .continuous)
                    .foregroundColor(.yellow)
                    .frame(width: 370, height: 90)
                }
                
                Spacer().frame(height: 33)
                
                HStack {
                    Text("接下來")
                        .font(.callout)
                    
                    Image(systemName: "arrow.turn.up.right")
                        .resizable()
                        .frame(width: 15, height: 13)
                    
                    Spacer().frame(width: 270)
                }
                .background {
                    UnevenRoundedRectangle(cornerRadii: .init(
                        topLeading: 0,
                        bottomLeading: 15,
                        bottomTrailing: 15,
                        topTrailing: 0),
                        style: .continuous)
                    .foregroundColor(.gray)
                    .frame(width: 100, height: 45)
                    .offset(x:-135)
                }
                
                Spacer().frame(height: 600)
            }
            
            VStack {
                Spacer().frame(height: 650)
                HStack {
                    VStack {
                        Text("10分鐘")
                            .font(.title)
                            .bold()
                            .padding(.vertical, 5)
                        Text("抵達時間為 00：00")
                        Text("目的地：OOO停車場")
                    }
                    
                    Spacer().frame(width: 50)
                    
                    Button {
                        
                    } label: {
                        Text("結束")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.yellow)
                }
                .ignoresSafeArea()
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
//                print(route?.steps.map{ $0.description } ?? "a" )
//                print(route?.steps.map{ $0.distance } ?? "a" )
//                print(route?.steps.map{ $0.instructions } ?? "a" )
//                print(route?.steps.map{ $0.notice } ?? "a" )
//                print(route?.steps.map{ $0.polyline } ?? "a" )
//                print(route?.steps.map{ $0.transportType } ?? "a" )
                if let route {
                    instructions = route.steps.map{ $0.instructions }.filter{!$0.isEmpty}
                }
            }
        }
    }
}
