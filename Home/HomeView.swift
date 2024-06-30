import SwiftUI
import MapKit

struct HomeView: View {
    
    @Binding var parkingLotData: [ParkingLotDataForApp]
    @State private var parkingLotSelectedIndex: Int?
    @State private var showParkingLotDetail = false
    @State private var selectedItem: MKMapItem?
    @State private var isNavigating = false
    @State private var showSmartNav = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ZStack {
            if !parkingLotData.isEmpty {
                if isNavigating {
                    NavigationView(selectedItem: $selectedItem, isNavigating: $isNavigating)
                }
                else {
                    MapView(isNavigating: $isNavigating, parkingLotData: $parkingLotData, parkingLotSelectedIndex: $parkingLotSelectedIndex, showParkingLotDetail: $showParkingLotDetail, selectedItem: $selectedItem)
                        .onTapGesture {
                            showParkingLotDetail = false
                            showSmartNav = false
                        }
                }
            }
            else {
                ProgressView()
            }
            
            if showParkingLotDetail {
                ParkingNavView(parkingLotData: $parkingLotData, parkingLotSelectedIndex: $parkingLotSelectedIndex, selectedItem: $selectedItem, toShowParkingDetail: $showParkingLotDetail, isNavigating: $isNavigating)
            }
            
            if showSmartNav {
                SmartNavView()
            }
            
            if !isNavigating {
                HStack {
                    Button {
                        GlobalState.shared.viewController = "HomeView"
                    } label: {
                        Image("Home_selected")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .padding(.leading, 20)
                    Spacer()
                    Button {
                        GlobalState.shared.viewController = "AssistantView"
                    } label: {
                        if colorScheme == .dark {
                            Image("Assistant_dark")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        else {
                            Image("Assistant")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                    Spacer()
                    Button {
                        showSmartNav.toggle()
                    } label: {
                        Image("SmartSearch")
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                    .offset(y: -35)
                    Spacer()
                    Button {
                        GlobalState.shared.viewController = "FavoriteParkingView"
                    } label: {
                        if colorScheme == .dark {
                            Image("Favorite_dark")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        else {
                            Image("Favorite")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                    Spacer()
                    Button {
                        GlobalState.shared.viewController = "SettingView"
                    } label: {
                        if colorScheme == .dark {
                            Image("Setting_dark")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        else {
                            Image("Setting")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                    .padding(.trailing, 20)
                }
                .padding(.horizontal, 20)
                .background {
                    if colorScheme == .dark {
                        Image("HomeToolBarBg_dark")
                            .resizable()
                            .frame(width: 400, height: 140)
                            .shadow(radius:10)
                            .offset(x:-1.66, y:5)
                    }
                    else {
                        Image("HomeToolBarBg")
                            .resizable()
                            .frame(width: 400, height: 140)
                            .shadow(color: Color("TabBarShadow"), radius:10)
                            .offset(x:-1.66, y:5)
                    }
                }
                .offset(x: 0, y:360)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .environmentObject(GlobalState.shared)
    }
}


func calculateDistance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
    let R = 6371000.0
    let lat1 = from.latitude * .pi / 180
    let lat2 = to.latitude * .pi / 180
    let dLat = (to.latitude - from.latitude) * .pi / 180
    let dLon = (to.longitude - from.longitude) * .pi / 180

    let a = sin(dLat / 2) * sin(dLat / 2) +
            cos(lat1) * cos(lat2) *
            sin(dLon / 2) * sin(dLon / 2)
    let c = 2 * atan2(sqrt(a), sqrt(1 - a))

    return R * c
}

func findPayex(from text: String) -> Int {
    
    // X元/時
    // 小型車計時X元
    // 計時X元
    
    let patterns = [
            #"(\d+)元/時"#,
            #"小型車計時(\d+)元"#,
            #"計時(\d+)元"#
        ]
        
    for pattern in patterns {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            continue
        }
        
        if let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
           let range = Range(match.range(at: 1), in: text),
           let rate = Int(text[range]) {
            return rate
        }
    }
    return -1
}
