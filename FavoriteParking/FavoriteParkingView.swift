import SwiftUI

struct FavoriteParkingView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Spacer().frame(height: 30)
                    ForEach(0..<10) { index in
                        ParkingView()
                        Spacer().frame(height: 20)
                    }
                }
            }
        }
        .navigationTitle("常用停車場")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        FavoriteParkingView()
    }
}
