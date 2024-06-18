import SwiftUI

struct ParkingView: View {
    
    let parkingData:FavoriteParking
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 314, height: 133)
                .foregroundColor(.white)
                .shadow(radius: 15)
            
            HStack(alignment:.top) {
                
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 125, height: 85)
                    .foregroundColor(.yellow)
                    .padding(.leading, 70)
                
                Spacer()
                
                VStack {
                    HStack(alignment:.top) {
                        Text(parkingData.name)
                            .font(.caption)
                        
                        Spacer()
                        
                        if parkingData.isRecommend {
                            Image("Recommeded")
                                .resizable()
                                .frame(width: 15, height: 15)
                            
                            Image("Heart")
                                .resizable()
                                .frame(width: 17, height: 15)
                        }
                        else {
                            Image("Heart_filled")
                                .resizable()
                                .frame(width: 17, height: 15)
                        }
                    }
                    .padding(.top, 8)
                    .padding(.trailing, 55)
                    
                    HStack {
                        Text("$"+String(parkingData.pricePerHour)+"/hr")
                            .font(.caption2)
                        
                        Divider().frame(height: 12)
                        
                        Text("\(String(format: "%.1f", parkingData.distance))公里")
                            .font(.caption2)
                        
                        Spacer()
                    }
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                }
                .padding(.leading, 5)
                
            }
        }
    }
}

#Preview {
    ParkingView(parkingData: FavoriteParking(img: "", name: "A地下停車場", pricePerHour: 60))
}
