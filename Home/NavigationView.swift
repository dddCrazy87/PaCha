import SwiftUI
import MapKit

struct NavigationView: View {
    
    @State private var isSheetOn = true
    //@State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    var body: some View {
        ZStack {
            
//            Map(position: $cameraPosition) {
//                Annotation("", coordinate: .userLocation) {
//                    Image("CurPos")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                }
//            }
            
            VStack {
                HStack(alignment: .bottom) {
                    Image(systemName: "arrow.up")
                        .resizable()
                        .frame(width: 30, height: 50)
                        .bold()
                    HStack {
                        Text("直行")
                            .font(.callout)
                            .bold()
                        
                        Text("OX路11巷")
                            .font(.title2)
                    }
                    
                    Spacer().frame(width: 150)
                }
                .background {
                    UnevenRoundedRectangle(cornerRadii: .init(
                        topLeading: 30,
                        bottomLeading: 0,
                        bottomTrailing: 30,
                        topTrailing: 30),
                        style: .continuous)
                    .foregroundColor(.yellow)
                    .frame(width: 370, height: 90)
                }
                
                Spacer().frame(height: 33)
                
                HStack {
                    Text("接下來")
                        .font(.callout)
                    
                    Image(systemName: "arrow.turn.up.right")
                        .resizable()
                        .frame(width: 15, height: 13)
                    
                    Spacer().frame(width: 270)
                }
                .background {
                    UnevenRoundedRectangle(cornerRadii: .init(
                        topLeading: 0,
                        bottomLeading: 15,
                        bottomTrailing: 15,
                        topTrailing: 0),
                        style: .continuous)
                    .foregroundColor(.gray)
                    .frame(width: 100, height: 45)
                    .offset(x:-135)
                }
                
                Spacer().frame(height: 600)
            }
            
            VStack {
                Spacer().frame(height: 650)
                HStack {
                    VStack {
                        Text("10分鐘")
                            .font(.title)
                            .bold()
                            .padding(.vertical, 5)
                        Text("抵達時間為 00：00")
                        Text("目的地：OOO停車場")
                    }
                    
                    Spacer().frame(width: 50)
                    
                    Button {
                        
                    } label: {
                        Text("結束")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.yellow)
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    NavigationView()
}
