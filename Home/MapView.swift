import SwiftUI
import MapKit

struct MapView: View {
    
    @Binding var isNavigating: Bool
    
    // parking lot data
    @Binding var parkingLotData: [ParkingLotDataForApp]
    @Binding var parkingLotSelectedIndex: Int?
    @Binding var showParkingLotDetail: Bool
    @State private var route: MKRoute?
    
    // map item
    @Binding var selectedItem: MKMapItem?
    @State private var cameraPosition: MapCameraPosition = .automatic
    @ObservedObject var locationManager = LocationManager.shared
    @State private var userCoordinate: CLLocationCoordinate2D?
    
    // search function
    @State private var searchText = ""
    @State private var searchResults = [MKMapItem]()
    @State private var result = MKMapItem()
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition, selection: $selectedItem) {
                
                if let userCoordinate {
                    Annotation("現在位置", coordinate: userCoordinate) {
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
                }
                
                ForEach(parkingLotData.indices, id: \.self) { index in
                    let parkingLot = parkingLotData[index]
                    if parkingLot.totalCar >= 100 {
                        Annotation("", coordinate: CLLocationCoordinate2D(latitude: parkingLot.latitude, longitude: parkingLot.longitude)) {
                            Button {
                                parkingLotSelectedIndex = index
                                showParkingLotDetail = true
                            } label: {
                                ZStack {
                                    Image("ParkingLot_more_than_100")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
                                    Text("\(parkingLot.totalCar)")
                                        .font(.system(size: 10))
                                        .bold()
                                        .offset(x:-0.5, y:-6)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                    else if parkingLot.totalCar >= 50 {
                        
                        Annotation("", coordinate: CLLocationCoordinate2D(latitude: parkingLot.latitude, longitude: parkingLot.longitude)) {
                            Button {
                                parkingLotSelectedIndex = index
                                showParkingLotDetail = true
                            } label: {
                                ZStack {
                                    Image("ParkingLot_less_than_50")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
                                    Text("\(parkingLot.totalCar)")
                                        .font(.system(size: 10))
                                        .bold()
                                        .offset(x:-0.5, y:-6)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        
                    }
                    else {
                        Annotation("", coordinate: CLLocationCoordinate2D(latitude: parkingLot.latitude, longitude: parkingLot.longitude)) {
                            Button {
                                parkingLotSelectedIndex = index
                                showParkingLotDetail = true
                            } label: {
                                ZStack {
                                    Image("ParkingLot_less_than_10")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
                                    Text("\(parkingLot.totalCar)")
                                        .font(.system(size: 10))
                                        .bold()
                                        .offset(x:-0.5, y:-6)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
                
                Annotation(result.name ?? "", coordinate: result.placemark.coordinate) {
                    Button {
                        selectedItem = result
                        isNavigating = true
                    } label: {
                        Image("ParkingLot_less_than_10")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                }
                
                if let route {
                    MapPolyline(route)
                        .stroke(.blue, lineWidth: 5)
                }
            }
            .overlay(alignment: .top) {
                MapSearchView(searchText: $searchText, searchResults: $searchResults, result: $result, cameraPosition: $cameraPosition)
                    .onChange(of: searchText) {
                        Task { await searchPlaces() }
                    }
            }
            
            Button {
                withAnimation(.easeInOut(duration: 3)) {
                    if let location = locationManager.userLocation?.coordinate {
                        cameraPosition = .region(MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500))
                    }
                }
            } label: {
                Image("TrackUserPosition")
                    .resizable()
                    .frame(width: 55, height: 55)
            }
            .offset(x:160, y:250)
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
    }
}

extension MapView {
    func searchPlaces() async {
        if let userCoordinate {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchText
            request.region = MKCoordinateRegion(center: userCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            
            let results = try? await MKLocalSearch(request: request).start()
            searchResults = results?.mapItems ?? []
        }
    }
}

//extension MapView {
//    func getDirections() {
//        if let location = locationManager.userLocation?.coordinate {
//            self.route = nil
//            
//            guard selectedItem != nil else { return }
//            
//            let request = MKDirections.Request()
//            request.source = MKMapItem(placemark: MKPlacemark(coordinate: location))
//            request.destination = self.selectedItem
//            request.transportType = .automobile
//            
//            Task {
//                let directions = MKDirections(request: request)
//                let response = try? await directions.calculate()
//                route = response?.routes.first
//            }
//        }
//    }
//}

#Preview {
    ContentView()
        .environmentObject(GlobalState.shared)
}
