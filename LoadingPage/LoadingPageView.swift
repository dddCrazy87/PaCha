import SwiftUI

struct LoadingPageView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            if colorScheme == .dark {
                GifImageView(name: "loading_dark")
                    .frame(width: 150, height: 150)
            }
            else {
                GifImageView(name: "loading")
                    .frame(width: 150, height: 150)
            }
        }
    }
}

#Preview {
    LoadingPageView()
}
