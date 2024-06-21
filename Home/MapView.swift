import SwiftUI
import MapKit

struct MapView: View {
    
    @Binding var parkingLotData: [ParkingLotDataForApp]
    @Binding var parkingLotSelectedIndex: Int?
    
    @Binding var showParkingLotDetail: Bool
    @State private var mapSelection: MKMapItem?
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    
    var body: some View {
        ZStack {
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
                
                ForEach(results, id: \.self) {item in
                    let placemark = item.placemark
                    Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                }
            }
            .overlay(alignment: .top) {
                HStack {
                    Image("Search")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .padding(.leading, 30)
                    
                    TextField("搜尋", text: $searchText)
                        .font(.system(size: 20))
                        .padding(.leading, 5)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Image("Micphone")
                        .resizable()
                        .frame(width: 18, height: 25)
                        .padding(.trailing, 30)
                }
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color.white.opacity(0.85))
                        .frame(width: 370, height: 50)
                }
                .offset(y:20)
                
            }
            .onSubmit(of: .text) {
                Task { await searchPlaces() }
            }
            
            Button {
                cameraPosition = .region(.userRegion)
            } label: {
                Image("TrackUserPosition")
                    .resizable()
                    .frame(width: 55, height: 55)
            }
            .offset(x:160, y:250)
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
                     latitudinalMeters: 500,
                     longitudinalMeters: 500)
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
    ContentView()
        .environmentObject(GlobalState.shared)
}
