import SwiftUI

struct TicketShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addArc(center: CGPoint(x: 0, y: rect.height / 3),
                    radius: rect.height / 40,
                    startAngle: Angle(degrees: 270),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        
        path.addArc(center: CGPoint(x: rect.width, y: rect.height / 3),
                    radius: rect.height / 40,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)
        
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        return path
    }
}

struct ParkingIDView: View {
    var body: some View {
        
        ZStack {
            TicketShape()
                .foregroundColor(.white)
                .frame(width: 300, height: 500)
                .cornerRadius(20)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack {
                
                Text("停車場編號1")
                    .foregroundColor(.white)
                    .bold()
                    .background() {
                        UnevenRoundedRectangle(cornerRadii: .init(
                            topLeading: 10,
                            bottomLeading: 0,
                            bottomTrailing: 0,
                            topTrailing: 10), style: .continuous)
                            .frame(width: 300, height: 50)
                            .foregroundColor(.orange)
                    }
                
                Spacer().frame(height: 450)
            }
            
            VStack {
                
                HStack {
                    Spacer()
                    Image("")
                        .resizable()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 70)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    
                    VStack(alignment: .leading) {
                        
                        Text("A地下停車場")
                            .font(.callout)
                            .bold()
                            .padding(.leading, 5)
                            .padding(.bottom, 1)
                        
                        Text("台北市士林區中正路17號")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(maxWidth: 125)
                            .lineLimit(nil)
                            .padding(.leading, 10)
                    }
                    Spacer()
                }
                Spacer().frame(height: 300)
            }
            
            VStack {
                HStack {
                    ForEach(0..<16) { index in
                        Rectangle()
                            .frame(width: 8, height: 1.5)
                            .foregroundColor(.gray)
                    }
                }
                Spacer().frame(height: 165)
            }
            
            VStack {
                
                Spacer().frame(height: 40)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("姓名")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(2)
                        Text("喬喬")
                            .font(.headline)
                            .bold()
                            .padding(2)
                        Text("停車場")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(2)
                        Text("A地下停車場")
                            .font(.headline)
                            .bold()
                            .padding(2)
                        Text("日期")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(2)
                        Text("2024/01/10")
                            .font(.headline)
                            .bold()
                            .padding(2)
                    }
                    .padding(.leading, 70)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("車牌號碼")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(2)
                        Text("SVT-0526")
                            .font(.headline)
                            .bold()
                            .padding(2)
                        Text("停車樓層")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(2)
                        Text("B2")
                            .font(.headline)
                            .bold()
                            .padding(2)
                        Text("時間")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(2)
                        Text("30 min")
                            .font(.headline)
                            .bold()
                            .padding(2)
                    }
                    .padding(.trailing, 70)
                }
            }
            
            VStack {
                Spacer().frame(height: 250)
                HStack {
                    ForEach(0..<17) { index in
                        Rectangle()
                            .frame(width: 8, height: 1.5)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            VStack {
                Spacer().frame(height: 375)
                HStack {
                    Text("所需付金額：")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading, 70)
                    Spacer()
                    Text("$120")
                        .font(.title2)
                        .padding(.trailing, 70)
                }
            }
            
        }
        .navigationTitle("停車編號紀錄")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ParkingIDView()
    }
}
