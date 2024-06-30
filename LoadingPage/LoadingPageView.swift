import SwiftUI

struct LoadingPageView: View {
    var body: some View {
        VStack{
            GifImageView("loading")
                .frame(width: 250, height: 250)
            
//            Text("PaCha")
//                .font(.title)
//                .bold()
//                .foregroundStyle(Color.orange)
//                .offset(y:-70)
        }
    }
}

#Preview {
    LoadingPageView()
}
