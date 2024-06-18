import SwiftUI

struct HistoryParkingView: View {
    
    let historyParkingData:HistoryParking
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .frame(width: 315, height: 110)
                .foregroundColor(.white)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    
                    if historyParkingData.isParking {
                        Image("isParking_filled")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .padding(.leading, 60)
                    }
                    else {
                        Image("isParking")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .padding(.leading, 60)
                    }
                    
                    Spacer()
                    
                    Text(historyParkingData.name)
                        .font(.headline)
                        .padding(.trailing, 55)
                }
                
                Rectangle()
                    .frame(width: 280, height: 1)
                
                HStack(alignment: .bottom) {
                    Text(historyParkingData.date)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading, 60)
                    Spacer()
                    Text(historyParkingData.time)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    Text("$"+String(historyParkingData.price))
                        .font(.callout)
                        .padding(.trailing, 60)
                }
                .padding(.top, 5)
            }
        }
    }
}

#Preview {
    HistoryParkingView(historyParkingData: HistoryParking(name: "A停車場", date: "2024/06/01", time: "19:00 PM", price: 50))
}
