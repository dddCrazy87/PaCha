import SwiftUI
import MapKit

struct MapView: View {
    
    @State var parkingLotDataArray: [ParkingLotData]
    @State private var mapSelection: MKMapItem?
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    
    var body: some View {
        Map(position: $cameraPosition, selection: $mapSelection) {
            
            Annotation("現在位置", coordinate: .userLocation) {
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
                if let coordinateX = Double(parkingLot.x), let coordinateY = Double(parkingLot.y) {
                    if parkingLot.totalcar >= 100 {
                        
                        Annotation("", coordinate: CLLocationCoordinate2D(latitude: coordinateY, longitude: coordinateX)) {
                            Button {
                                print("hi")
                            } label: {
                                ZStack {
                                    Image("ParkingLot_more_than_100")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 75, height: 75)
                                    
                                    Text("\(parkingLot.totalcar)")
                                        .font(.system(size: 17))
                                        .bold()
                                        .offset(x:-0.5, y:-7.5)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                    else if parkingLot.totalcar >= 50 {
                        
                        Annotation("", coordinate: CLLocationCoordinate2D(latitude: coordinateY, longitude: coordinateX)) {
                            Button {
                                print("hi")
                            } label: {
                                ZStack {
                                    Image("ParkingLot_less_than_50")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 75, height: 75)
                                    
                                    Text("\(parkingLot.totalcar)")
                                        .font(.system(size: 17))
                                        .bold()
                                        .offset(x:-0.5, y:-7.5)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                            
                    }
                    else {
                        Annotation("", coordinate: CLLocationCoordinate2D(latitude: coordinateY, longitude: coordinateX)) {
                            Button {
                                print("hi")
                            } label: {
                                ZStack {
                                    Image("ParkingLot_less_than_10")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 75, height: 75)
                                    
                                    Text("\(parkingLot.totalcar)")
                                        .font(.system(size: 17))
                                        .bold()
                                        .offset(x:-0.5, y:-7.5)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
            }
            
            ForEach(results, id: \.self) {item in
                let placemark = item.placemark
                Marker(placemark.name ?? "", coordinate: placemark.coordinate)
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
        .onSubmit(of: .text) {
            Task { await searchPlaces() }
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

extension MapView {
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .userRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        self.results = results?.mapItems ?? []
    }
}

#Preview {
    HomeView()
}
