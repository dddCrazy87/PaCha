import SwiftUI

struct ParkingNavView: View {
    
    @Binding var parkingLotData: ParkingLotData?
    
    var body: some View {
        if let parkingLotData {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 350, height: 315)
                    .foregroundColor(.white)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                VStack {
                    HStack {
                        Text(parkingLotData.name)
                            .font(.title3)
                            .bold()
                            .padding(.leading, 50)
                        
                        Spacer()
                        
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 27, height: 22)
                            .padding(.trailing, 50)
                    }
                    HStack {
                        Image("Price")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text("40/hr")
                            .bold()
                        
                        Rectangle()
                            .frame(width: 1, height: 24)
                            .foregroundColor(.orange)
                        
                        Image("Space")
                            .resizable()
                            .frame(width: 25, height: 17)
                        
                        Text("30")
                            .bold()
                        
                        Rectangle()
                            .frame(width: 1, height: 24)
                            .foregroundColor(.orange)
                        
                        Image("Distance")
                            .resizable()
                            .frame(width: 12, height: 15)
                        
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
                                
                                Text(parkingLotData.address)
                                    .frame(width: 130)
                                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                            }
                            
                            Spacer().frame(height: 5)
                            
                            HStack(alignment: .top) {
                                
                                Text("計費：")
                                    .padding(0)
                                
                                Spacer().frame(width: 0)
                                
                                Text(parkingLotData.payex)
                                    .frame(width: 130)
                                    .lineLimit(3)
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
                            
                            Image("Navigation")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                    .padding(5)
                }
            }
        }
    }
}

struct ParkingNavViewTest:View {
    @State private var test:ParkingLotData?
    
    var body: some View {
        ParkingNavView(parkingLotData: $test)
    }
}

#Preview {
    ParkingNavViewTest()
}
