import SwiftUI

struct AssistantView: View {
    
    let historyParking:[HistoryParking]
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                        .font(.callout)
                        .bold()
                    
                    Rectangle()
                        .frame(width: 316, height: 3)
                    
                    HStack {
                        Text("PARI目前與您行駛 ")
                        
                        Text("6000")
                            .bold()
                            .foregroundStyle(Color("AssistantDetail"))
                        
                        Text(" 公里")
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.leading, 53)
                    
                    Divider()
                        .frame(width: 294)
                    
                    HStack {
                        Text("目前已停 ")
                        
                        Text("2.3")
                            .bold()
                            .foregroundStyle(Color("AssistantDetail"))
                        
                        Text(" 小時")
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.leading, 53)
                    
                    Divider()
                        .frame(width: 294)
                    
                    HStack {
                        Text("距離上次加油已累積 ")
                        
                        Text("150")
                            .bold()
                            .foregroundStyle(Color("AssistantDetail"))
                        
                        Text(" 公里")
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.leading, 53)
                    
                    Divider()
                        .frame(width: 294)
                    
                    HStack {
                        Text("距離上次更換輪胎已累積 ")
                        
                        Text("50")
                            .bold()
                            .foregroundStyle(Color("AssistantDetail"))
                        
                        Text(" 公里")
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
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
                                    .foregroundColor(Color("AssistantBtn"))
                                
                                HStack {
                                    Image("ParkingSpaceID")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    
                                    Text("停車編號紀錄")
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
                                    .foregroundColor(Color("AssistantBtn"))
                                
                                HStack {
                                    Image("History")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    
                                    Text("歷史停車紀錄")
                                }
                            }
                        }
                    }
                    .bold()
                    
                    Spacer().frame(height: 120)
                }
                .font(.callout)
                
                // tool bar
                
                HStack {
                    Button {
                        GlobalState.shared.viewController = "HomeView"
                    } label: {
                        if colorScheme == .dark {
                            Image("Home_dark")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        else {
                            Image("Home")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                    Spacer()
                    Button {
                        GlobalState.shared.viewController = "AssistantView"
                    } label: {
                        Image("Assistant_selected")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
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
                }
                .padding(.horizontal, 60)
                .background {
                    Rectangle()
                        .frame(width: 400, height: 100)
                        .foregroundColor(Color("MainBg"))
                        .shadow(color: Color("TabBarShadow"), radius:10)
                        .offset(y:5)
                }
                .offset(x: 0, y:342)
                
            }
        }
        .navigationTitle("智慧管家PARI")
        .navigationBarTitleDisplayMode(.inline)
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
        .environmentObject(GlobalState.shared)
    }
}
