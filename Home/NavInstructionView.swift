import SwiftUI

struct NavInstructionView: View {
    
    let instruction: String
    let expectedTravelTime: Double
    //let desinationName: String
    @State private var currentTime = Date()
    @Binding var isNavigating:Bool
    
    var body: some View {
            
        VStack {
            HStack(alignment: .bottom) {
                
                switch instruction[0...1] {
                    
                case "左轉":
                    Image(systemName: "arrow.turn.up.left")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .bold()
                        .padding(.leading, 30)
                    
                case "右轉":
                    Image(systemName: "arrow.turn.up.right")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .bold()
                        .padding(.leading, 30)
                    
                default:
                    Image(systemName: "arrow.up")
                        .resizable()
                        .frame(width: 30, height: 50)
                        .bold()
                        .padding(.leading, 30)
                }
                
                HStack(alignment: .bottom) {
                    Text(instruction[0...1])
                        .font(.callout)
                        .bold()
                    
                    Text(instruction[2...instruction.count-1])
                        .font(.title2)
                }
                .padding(.leading, 20)
                
                Spacer()
            }
            .background {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 30,
                    bottomLeading: 0,
                    bottomTrailing: 30,
                    topTrailing: 30),
                    style: .continuous)
                .foregroundColor(Color("NavInstruction"))
                .frame(width: 370, height: 90)
            }
            
            Spacer().frame(height: 33)
            
            HStack {
                Text("接下來")
                    .font(.callout)
                
                Image(systemName: "arrow.turn.up.right")
                    .resizable()
                    .frame(width: 15, height: 13)
                
                Spacer().frame(width: 270)
            }
            .background {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 0,
                    bottomLeading: 15,
                    bottomTrailing: 15,
                    topTrailing: 0),
                    style: .continuous)
                .foregroundColor(Color("NavNextInstruction"))
                .frame(width: 100, height: 45)
                .offset(x:-135)
            }
            
            Spacer().frame(height: 600)
        }
        
        VStack {
            Spacer().frame(height: 650)
            HStack {
                
                Spacer().frame(width: 65)
                
                VStack {
                    Text("\(String(format: "%.0f", expectedTravelTime/60))分鐘")
                        .font(.title)
                        .bold()
                        .padding(.vertical, 5)
                    Text("抵達時間為 \(currentTime.addingTimeInterval(expectedTravelTime), style: .time)")
                    //Text("目的地：\(desinationName)")
                }
                
                Spacer().frame(width: 35)
                
                Button {
                    isNavigating = false
                } label: {
                    Text("結束")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color("NavInstruction"))
            }
            .ignoresSafeArea()
        }
    }
}


extension String {
    subscript(range: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(startIndex, offsetBy: min(count, range.upperBound + 1))
        return String(self[start..<end])
    }
}
