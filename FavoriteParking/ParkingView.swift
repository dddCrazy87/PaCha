import SwiftUI

struct ParkingView: View {
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
                    HStack {
                        Text("A地下停車場")
                            .font(.caption)
                        Spacer()
                    }
                    
                    HStack {
                        Text("$60/hr")
                            .font(.caption2)
                        
                        Divider().frame(height: 12)
                        
                        Text("0.3公里")
                            .font(.caption2)
                        
                        Spacer()
                    }
                    .foregroundColor(.gray)
                }
                .padding(.leading, 10)
                
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 20, height: 17)
                    .padding(.trailing, 60)
                
            }
        }
    }
}

#Preview {
    ParkingView()
}