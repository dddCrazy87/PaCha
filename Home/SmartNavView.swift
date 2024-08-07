import SwiftUI
import MapKit

struct SmartNavView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedItem: MKMapItem?
    @Binding var showSmartNav: Bool
    @Binding var isNavigating: Bool
    
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .frame(width: 350, height: 420)
                .foregroundColor(Color("MainBg"))
            
            VStack {
                Image("SmartSearch")
                    .resizable()
                    .frame(width: 80, height: 80)
                
                HStack(alignment: .bottom){
                    Text("進場率")
                    Text("82")
                        .foregroundColor(Color("AssistantDetail"))
                        .bold()
                        .font(.title)
                        .offset(y:2)
                    Text("%")
                }
                .font(.title3)
                .bold()
                
                Image("SmartNavPhoto")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 220, height: 157)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 10)
                
                
                Text("新南停車場-國立臺灣大學")
                
                // 25.0191998119859, 121.53391474859414
                
                HStack(alignment: .bottom) {
                    Text("剩餘車位")
                        .font(.title3)
                        .bold()
                    Text("41")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color("AssistantDetail"))
                        .offset(y:2)
                    Text("個")
                        .font(.title3)
                        .bold()
                }
                
                HStack {
                    
                    if colorScheme == .dark {
                        Image("Price_dark")
                            .resizable()
                            .frame(width: 17, height: 18)
                    }
                    else {
                        Image("Price")
                            .resizable()
                            .frame(width: 17, height: 18)
                    }
                    
                    Text("40/H")
                    
                    Rectangle()
                        .frame(width: 1, height: 22)
                    
                    if colorScheme == .dark {
                        Image("Distance_dark")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    else {
                        Image("Distance")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    
                    Text("0.3公里")
                }
                
                Button {
                    selectedItem = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 25.0191998119859, longitude: 121.53391474859414)))
                    showSmartNav = false
                    isNavigating = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 285, height: 40)
                            .foregroundColor(Color("SmartNavBtn"))
                        
                        Image("Navigation")
                            .resizable()
                            .frame(width: 22, height: 22)
                    }
                }
                
                Spacer().frame(height: 60)
            }
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalState.shared)
}
