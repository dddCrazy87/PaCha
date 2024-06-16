import SwiftUI

struct HistoryView: View {
    var body: some View {
        ScrollView {
            VStack {
                Spacer().frame(height: 20)
                ForEach(0..<10) { index in
                    HistoryParkingView().padding(.vertical, 5)
                }
            }
        }
        .navigationTitle("歷史紀錄")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HistoryView()
    }
}
