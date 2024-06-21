import SwiftUI
import MapKit

struct HomeView: View {
    
    @Binding var parkingLotData: [ParkingLotDataForApp]
    @State var parkingLotSelectedIndex: Int?
    
    @State private var showParkingLotDetail = false
    @State private var showSmartNav = false
    
    @State private var selectedItem: MKMapItem?
    
    var body: some View {
        
        ZStack {
            if !parkingLotData.isEmpty {
                ZStack {
                    MapView(parkingLotData: $parkingLotData, parkingLotSelectedIndex: $parkingLotSelectedIndex, showParkingLotDetail: $showParkingLotDetail, selectedItem: $selectedItem)
                        .onTapGesture {
                            showParkingLotDetail = false
                            showSmartNav = false
                        }
                        .onChange(of: parkingLotData[parkingLotSelectedIndex ?? 0].isFavorite) { oldValue, newValue in
                            print(parkingLotData[parkingLotSelectedIndex ?? 0].name)
                        }
                }
            }
            else {
                ProgressView()
            }
            
            if showParkingLotDetail {
                ParkingNavView(parkingLotData: $parkingLotData, parkingLotSelectedIndex: $parkingLotSelectedIndex, selectedItem: $selectedItem, toShowParkingDetail: $showParkingLotDetail)
                    .onAppear {
                        print("Detail apear")
                    }
            }
            
            if showSmartNav {
                SmartNavView()
            }
            
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
                    Image("Assistant")
                        .resizable()
                        .frame(width: 25, height: 25)
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
                    Image("Favorite")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                Spacer()
                Button {
                    GlobalState.shared.viewController = "SettingView"
                } label: {
                    Image("Setting")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                .padding(.trailing, 20)
            }
            .padding(.horizontal, 20)
            .background {
                Image("HomeToolBarBg")
                    .resizable()
                    .frame(width: 400, height: 140)
                    .shadow(radius:10)
                    .offset(x:-1.66, y:5)
            }
            .offset(x: 0, y:360)
        }
    }
}



#Preview {
    NavigationStack {
        ContentView()
            .environmentObject(GlobalState.shared)
    }
}
