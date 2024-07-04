import SwiftUI
import MapKit

struct ParkingNavView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var parkingLotData: [ParkingLotDataForApp]
    @Binding var parkingLotSelectedIndex: Int?
    @Binding var selectedItem: MKMapItem?
    @Binding var toShowParkingDetail: Bool
    @Binding var isNavigating: Bool
    
    var body: some View {
        
        if let parkingLotSelectedIndex {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 350, height: 315)
                    .foregroundColor(Color("MainBg"))
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                VStack {
                    HStack {
                        Text(parkingLotData[parkingLotSelectedIndex].name)
                            .font(.title3)
                            .bold()
                            .padding(.leading, 50)
                        
                        Spacer()
                        
                        Button {
                            parkingLotData[parkingLotSelectedIndex].isFavorite.toggle()
                        } label: {
                            if (parkingLotData[parkingLotSelectedIndex].isFavorite) {
                                Image("Heart_filled")
                                    .resizable()
                                    .frame(width: 27, height: 22)
                                    .padding(.trailing, 50)
                            }
                            else {
                                Image("Heart")
                                    .resizable()
                                    .frame(width: 27, height: 22)
                                    .padding(.trailing, 50)
                            }
                            
                        }
                    }
                    HStack {
                        if colorScheme == .dark {
                            Image("Price_dark")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        else {
                            Image("Price")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        
                        Text("\(parkingLotData[parkingLotSelectedIndex].pricePerHour)/hr")
                            .bold()
                        
                        Rectangle()
                            .frame(width: 1, height: 24)
                            .foregroundColor(Color("MainOrange"))
                        
                        if colorScheme == .dark {
                            Image("Space_dark")
                                .resizable()
                                .frame(width: 25, height: 17)
                        }
                        else {
                            Image("Space")
                                .resizable()
                                .frame(width: 25, height: 17)
                        }
                        
                        Text("\(parkingLotData[parkingLotSelectedIndex].totalCar)")
                            .bold()
                        
                        Rectangle()
                            .frame(width: 1, height: 24)
                            .foregroundColor(Color("MainOrange"))
                        
                        if colorScheme == .dark {
                            Image("Distance_dark")
                                .resizable()
                                .frame(width: 12, height: 15)
                        }
                        else {
                            Image("Distance")
                                .resizable()
                                .frame(width: 12, height: 15)
                        }
                        
                        Text("\(String(format: "%.1f", parkingLotData[parkingLotSelectedIndex].distance))公里")
                            .bold()
                    }
                    
                    Rectangle()
                        .frame(width: 312, height: 2)
                        .foregroundColor(Color("MainOrange"))
                        .padding(.vertical, 10)
                    
                    HStack {
                        
                        Image("ParkingLotPhoto")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 10)
                        
                        VStack {
                            
                            HStack(alignment: .top) {
                                
                                Text("地址：")
                                    .padding(0)
                                
                                Spacer().frame(width: 0)
                                
                                Text(parkingLotData[parkingLotSelectedIndex].address)
                                    .frame(width: 130)
                                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                            }
                            
                            Spacer().frame(height: 5)
                            
                            HStack(alignment: .top) {
                                
                                Text("計費：")
                                    .padding(0)
                                
                                Spacer().frame(width: 0)
                                
                                Text(parkingLotData[parkingLotSelectedIndex].payex)
                                    .frame(width: 130)
                                    .lineLimit(3)
                            }
                        }
                        .font(.caption)
                        .padding(.leading, 4)
                    }
                    
                    Button {
                        selectedItem = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: parkingLotData[parkingLotSelectedIndex].latitude, longitude: parkingLotData[parkingLotSelectedIndex].longitude)))
                        toShowParkingDetail = false
                        isNavigating = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 285, height: 42)
                                .foregroundColor(Color("MainOrange"))
                            
                            Image("Navigation")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                    .padding(5)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalState.shared)
}
