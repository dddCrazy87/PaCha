import SwiftUI

struct AssistantView: View {
    
    let historyParking:[HistoryParking]
    
    var body: some View {
        NavigationStack {
            VStack() {
                
                Spacer().frame(height: 20)
                
                ZStack {
                    Circle()
                        .frame(width: 275, height: 275)
                        .foregroundColor(.purple)
                    Image("PARI")
                        .resizable()
                        .frame(width: 224, height: 224)
                }
                
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
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 150, height: 40)
                            
                            HStack {
                                Image("ParkingSpaceID")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                
                                Text("停車編號紀錄")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    Spacer().frame(width: 25)
                    
                    NavigationLink {
                        HistoryView(historyParking: historyParking)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 150, height: 40)
                            
                            HStack {
                                Image("History")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                
                                Text("歷史停車紀錄")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .bold()
                
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        AssistantView(historyParking: [
            HistoryParking(name: "A停車場", date: "2024/06/01", time: "00:00 AM", price: 10),
            HistoryParking(name: "B停車場", date: "2024/06/02", time: "00:00 AM", price: 20),
            HistoryParking(name: "C停車場", date: "2024/06/03", time: "00:00 AM", price: 30),
            HistoryParking(name: "D停車場", date: "2024/06/04", time: "00:00 AM", price: 40),
            HistoryParking(name: "E停車場", date: "2024/06/05", time: "00:00 AM", price: 50),
            HistoryParking(name: "F停車場", date: "2024/06/06", time: "00:00 AM", price: 60),
            HistoryParking(name: "G停車場", date: "2024/06/07", time: "00:00 AM", price: 70)
        ])
    }
}
