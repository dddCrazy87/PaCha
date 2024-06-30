import SwiftUI

struct ParkingView: View {
    
    let parkingData:ParkingLotDataForApp
    let id: Int
    @Binding var lastedRemovedIndex:Int
    @Binding var parkingLotData: [ParkingLotDataForApp]
    @Binding var showUndoView:Bool
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 314, height: 133)
                .foregroundColor(Color("MainBg"))
                .shadow(radius: 15)
            
            HStack(alignment:.top) {
                
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 125, height: 90)
                    .foregroundColor(.yellow)
                    .padding(.leading, 70)
                
                Spacer()
                
                VStack {
                    HStack(alignment:.top) {
                        Text(parkingData.name)
                            .font(.subheadline)
                            .lineLimit(3)
                        
                        Spacer()
                        
                        if parkingData.isRecommend {
                            Image("Recommeded")
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                        
                        Button {
                            showUndoView = true
                            lastedRemovedIndex = id
                            parkingLotData[id].isFavorite.toggle()
                        } label: {
                            if parkingLotData[id].isFavorite {
                                Image("Heart_filled")
                                    .resizable()
                                    .frame(width: 17, height: 15)
                            }
                            else {
                                Image("Heart")
                                    .resizable()
                                    .frame(width: 17, height: 15)
                            }
                        }
                    }
                    .padding(.top, 8)
                    .padding(.trailing, 55)
                    
                    HStack {
                        Text("$\(parkingData.pricePerHour)/hr")
                            .font(.caption2)
                        
                        Divider().frame(height: 12)
                        
                        Text("\(String(format: "%.1f", parkingData.distance))公里")
                            .font(.caption2)
                        
                        Spacer()
                    }
                    .foregroundColor(Color("DetailTitle"))
                    .padding(.top, 5)
                }
                .padding(.leading, 5)
                
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalState.shared)
}
