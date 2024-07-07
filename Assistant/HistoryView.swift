import SwiftUI

struct HistoryView: View {
    
    let historyParking:[HistoryParking]
    
    var body: some View {
        Group {
            if historyParking.isEmpty {
                Text("還沒有停車紀錄！")
            }
            else{
                ScrollView {
                    VStack {
                        Spacer().frame(height: 20)
                        ForEach(historyParking) { parking in
                            HistoryParkingView(historyParkingData: parking).padding(.vertical, 5)
                        }
                    }
                }
            }
        }
        .navigationTitle("歷史紀錄")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HistoryView(historyParking: [
            HistoryParking(name: "A停車場", date: "2024/06/01", time: "00:00 AM", price: 10, isParking: true),
            HistoryParking(name: "B停車場", date: "2024/06/02", time: "00:00 AM", price: 20),
            HistoryParking(name: "C停車場", date: "2024/06/03", time: "00:00 AM", price: 30),
            HistoryParking(name: "D停車場", date: "2024/06/04", time: "00:00 AM", price: 40),
            HistoryParking(name: "E停車場", date: "2024/06/05", time: "00:00 AM", price: 50),
            HistoryParking(name: "F停車場", date: "2024/06/06", time: "00:00 AM", price: 60),
            HistoryParking(name: "G停車場", date: "2024/06/07", time: "00:00 AM", price: 70)
        ])
    }
}
