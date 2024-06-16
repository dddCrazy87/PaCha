import SwiftUI

struct HistoryParkingView: View {
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .frame(width: 315, height: 110)
                .foregroundColor(.white)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    Image("")
                        .frame(width: 23, height: 23)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        .padding(.leading, 60)
                    
                    Spacer()
                    
                    Text("防彈百貨地下停車場")
                        .font(.headline)
                        .padding(.trailing, 55)
                }
                
                Rectangle()
                    .frame(width: 280, height: 1)
                
                HStack(alignment: .bottom) {
                    Text("2013/06/13")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading, 60)
                    Spacer()
                    Text("19:09 PM")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    Text("$40")
                        .font(.callout)
                        .padding(.trailing, 60)
                }
                .padding(.top, 5)
            }
        }
    }
}

#Preview {
    HistoryParkingView()
}
