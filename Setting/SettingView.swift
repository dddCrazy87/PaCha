import SwiftUI

struct SettingView: View {
    
    @State private var isAutoUpdateOn = false
    
    var body: some View {
        
        VStack {
            
            Button {
                
            } label: {
                VStack {
                    HStack {
                        Text("登入")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text("密碼‧帳號安全‧個人資料·備份")
                            .foregroundColor(.gray)
                            .font(.caption)
                            .bold()
                        Spacer()
                    }
                }
            }
            .padding()
            
            Button {
                
            } label: {
                
                HStack {
                    Text("夜間模式")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                }
            }
            .padding()
            
            Button {
                
            } label: {
                
                VStack {
                    HStack {
                        Text("偏好設定")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text("字體‧通知‧地圖路況")
                            .foregroundColor(.gray)
                            .font(.caption)
                            .bold()
                        Spacer()
                    }
                }
            }
            .padding()
            
            Button {
                
            } label: {
                
                HStack {
                    Text("關於我們")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                }
            }
            .padding()
            
            Button {
                
            } label: {
                
                HStack {
                    Text("聯絡我們")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                }
            }
            .padding()
            
            Button {
                
            } label: {
                
                HStack {
                    Text("分享PaCha給好友")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                }
            }
            .padding()
            
            HStack {
                Toggle("自動更新", isOn: $isAutoUpdateOn)
                    .font(.title2)
                    .bold()
                
            }
            .padding()
            
            Spacer()
            
        }
        .foregroundColor(.black)
        .navigationTitle("設定")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingView()
    }
}
