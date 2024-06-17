import SwiftUI

struct ParkingNavView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 350, height: 315)
                .foregroundColor(.white)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    Text("88房(XX大道 8路-9路)停車場")
                        .font(.title3)
                        .bold()
                        .padding(.trailing, 5)
                    
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 27, height: 22)
                }
                HStack {
                    Image("")
                        .resizable()
                        .frame(width: 15, height: 17)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    
                    Text("40/hr")
                        .bold()
                    
                    Rectangle()
                        .frame(width: 1, height: 24)
                        .foregroundColor(.orange)
                    
                    Image("")
                        .resizable()
                        .frame(width: 15, height: 17)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    
                    Text("30")
                        .bold()
                    
                    Rectangle()
                        .frame(width: 1, height: 24)
                        .foregroundColor(.orange)
                    
                    Image("")
                        .resizable()
                        .frame(width: 15, height: 17)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    
                    Text("0.3公里")
                        .bold()
                }
                
                Rectangle()
                    .frame(width: 312, height: 2)
                    .foregroundColor(.orange)
                    .padding(.vertical, 10)
                
                HStack {
                    
                    Image("")
                        .resizable()
                        .frame(width: 125, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    
                    VStack {
                        
                        HStack(alignment: .top) {
                            
                            Text("地址：")
                                .padding(0)
                            
                            Spacer().frame(width: 0)
                            
                            Text("A市OO區XX大道二段18號")
                                .frame(width: 130)
                        }
                        
                        HStack(alignment: .top) {
                            
                            Text("計費：")
                                .padding(0)
                            
                            Spacer().frame(width: 0)
                            
                            Text("40元/時,全程以半小時計費.月租:全日12.000元/月")
                                .frame(width: 130)
                        }
                    }
                    .font(.caption)
                    .padding(.leading, 4)
                }
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 285, height: 42)
                            .foregroundColor(.orange)
                    }
                }
                .padding(5)
            }
        }
    }
}

#Preview {
    ParkingNavView()
}
