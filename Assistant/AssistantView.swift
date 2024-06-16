import SwiftUI

struct AssistantView: View {
    var body: some View {
        NavigationStack {
            VStack() {
                
                Spacer().frame(height: 20)
                
                Circle()
                    .frame(width: 275, height: 275)
                    .foregroundColor(.purple)
                
                Text("智慧管家PARI")
                    .font(.title3)
                    .bold()
                
                Rectangle()
                    .frame(width: 316, height: 3)
                
                HStack {
                    Text("PARI目前與您行駛 ")
                        .bold()
                    
                    Text("6000")
                    
                    Text(" 公里")
                        .bold()
                    
                    Spacer()
                }
                .padding(.vertical, 15)
                .padding(.leading, 53)
                
                Divider()
                    .frame(width: 294)
                
                HStack {
                    Text("目前已停 ")
                        .bold()
                    
                    Text("2.3")
                    
                    Text(" 小時")
                        .bold()
                    
                    Spacer()
                }
                .padding(.vertical, 15)
                .padding(.leading, 53)
                
                Divider()
                    .frame(width: 294)
                
                HStack {
                    Text("距離上次加油已累積 ")
                        .bold()
                    
                    Text("150")
                    
                    Text(" 公里")
                        .bold()
                    
                    Spacer()
                }
                .padding(.vertical, 15)
                .padding(.leading, 53)
                
                Divider()
                    .frame(width: 294)
                
                HStack {
                    Text("距離上次更換輪胎已累積 ")
                        .bold()
                    
                    Text("50")
                    
                    Text(" 公里")
                        .bold()
                    
                    Spacer()
                }
                .padding(.vertical, 15)
                .padding(.leading, 53)
                
                Divider()
                    .frame(width: 294)
                
                Spacer()
                
                HStack {
                    NavigationLink {
                        ParkingIDView()
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 135, height: 40)
                    }
                    .padding()
                    
                    NavigationLink {
                        ParkingIDView()
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 135, height: 40)
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        AssistantView()
    }
}
