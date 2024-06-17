import SwiftUI

struct SmartNavView: View {
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .frame(width: 350, height: 415)
                .foregroundColor(.white)
            
            VStack {
                Image("")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Text("進場率")
                    Text("87")
                    Text("%")
                }
                .font(.title3)
                .bold()
                
                Image("")
                    .resizable()
                    .frame(width: 220, height: 157)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                
                Text("WJ停車場")
                
                Text("剩餘車位50個")
                    .font(.title2)
                    .bold()
                
                HStack {
                    
                    Image("")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    
                    Text("40/H")
                    
                    Rectangle()
                        .frame(width: 1, height: 22)
                    
                    Image("")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    
                    Text("0.3公里")
                }
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 285, height: 40)
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer().frame(height: 60)
            }
        }
        
    }
}

#Preview {
    SmartNavView()
}
