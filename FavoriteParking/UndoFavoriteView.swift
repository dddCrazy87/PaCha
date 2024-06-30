import SwiftUI

struct UndoFavoriteView: View {
    
    @Binding var lastedRemovedIndex:Int
    @Binding var parkingLotData: [ParkingLotDataForApp]
    @Binding var showUndoView:Bool
    
    var body: some View {
        HStack {
            Text("已從常用停車場移除")
            Spacer().frame(width: 75)
            Button {
                parkingLotData[lastedRemovedIndex].isFavorite = true
                showUndoView = false
            } label: {
                Text("重新加入")
                    .foregroundStyle(Color.blue)
            }
        }
        .frame(width: 330, height: 50)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("MainBg"))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalState.shared)
}
