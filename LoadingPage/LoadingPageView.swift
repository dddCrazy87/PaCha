import SwiftUI

struct LoadingPageView: View {
    var body: some View {
        VStack{
            GifImageView("loading")
                .frame(width: 400, height: 400)
            
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
