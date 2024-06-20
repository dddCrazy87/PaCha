import SwiftUI

struct SettingView: View {
    
    // Preference
    @State private var isPreferenceSettingOn = false
    @State private var isNotificationOn = false
    @State private var isMapStatusOn = false
    
    // DarkModeSetting
    @State private var isDarkModeSettingOn = false
    @State private var isAutoDarkModeOn = false
    @State private var isManualDarkModeOn = false
    @State private var isTimerDarkModeOn = false
    
    @State private var isAutoUpdateOn = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                VStack {
                    
                    Button {
                        
                    } label: {
                        HStack(alignment: .top) {
                            
                            Image("Login")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.horizontal, 5)
                            
                            VStack(alignment: .leading) {
                                Text("登入")
                                    .font(.title2)
                                    .bold()
                                Text("密碼‧帳號安全‧個人資料·備份")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                    .bold()
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    
                    Button {
                        isDarkModeSettingOn = true
                    } label: {
                        
                        HStack(alignment: .top) {
                            
                            Image("DarkMode")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.horizontal, 5)
                            
                            HStack {
                                Text("夜間模式")
                                    .font(.title2)
                                    .bold()
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    
                    Button {
                        isPreferenceSettingOn = true
                    } label: {
                        
                        HStack(alignment: .top) {
                            
                            Image("Preference")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.horizontal, 5)
                            
                            VStack(alignment: .leading) {
                                Text("偏好設定")
                                    .font(.title2)
                                    .bold()
                                
                                Text("字體‧通知‧地圖路況")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                    .bold()
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    
                    Button {
                        
                    } label: {
                        
                        HStack(alignment: .top) {
                            
                            Image("AboutUs")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.horizontal, 5)
                            
                            HStack {
                                Text("關於我們")
                                    .font(.title2)
                                    .bold()
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
                        
                    }
                    .padding()
                    
                    Button {
                        
                    } label: {
                        
                        HStack(alignment: .top) {
                            
                            Image("ContactUs")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.horizontal, 5)
                            
                            HStack {
                                Text("聯絡我們")
                                    .font(.title2)
                                    .bold()
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    
                    Button {
                        
                    } label: {
                        
                        HStack(alignment: .top) {
                            
                            Image("Share")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.horizontal, 5)
                            
                            HStack {
                                Text("分享PaCha給好友")
                                    .font(.title2)
                                    .bold()
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    
                    HStack(alignment: .top) {
                        
                        Image("AutoUpdate")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.horizontal, 5)
                        
                        Toggle("自動更新", isOn: $isAutoUpdateOn)
                            .font(.title2)
                            .bold()
                        
                    }
                    .padding()
                    
                    Spacer()
                    
                }
                
                // tool bar
                
                HStack {
                    Button {
                        GlobalState.shared.viewController = "HomeView"
                    } label: {
                        Image("Home")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
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
                        Image("Setting_selected")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.horizontal, 60)
                .background {
                    Rectangle()
                        .frame(width: 400, height: 100)
                        .foregroundColor(.white)
                        .shadow(radius:10)
                        .offset(y:5)
                }
                .offset(x: 0, y:342)
            }
        }
        
        
        .foregroundColor(.black)
        .navigationTitle("設定")
        .navigationBarTitleDisplayMode(.inline)
        
        // Dark Mode
        .sheet(isPresented: $isDarkModeSettingOn) {
            VStack(alignment: .leading) {
                Toggle("自動感測", isOn: $isAutoDarkModeOn)
                Toggle("時間設置", isOn: $isTimerDarkModeOn)
                Toggle("手動開啟", isOn: $isManualDarkModeOn)
            }
            .padding()
            .bold()
            .presentationDetents([.fraction(0.3)])
            .presentationDragIndicator(.visible)
        }
        
        // Preference Setting
        .sheet(isPresented: $isPreferenceSettingOn) {
            VStack(alignment: .leading) {
                Text("字體大小")
                Toggle("訊息通知", isOn: $isNotificationOn)
                Toggle("地圖路況顯示", isOn: $isMapStatusOn)
                Text("地圖路況顯示")
                    .bold()
            }
            .padding()
            .presentationDetents([.fraction(0.3)])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    NavigationStack {
        SettingView()
            .environmentObject(GlobalState.shared)
    }
}
