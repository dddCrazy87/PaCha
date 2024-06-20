import SwiftUI

struct ContentView: View {
    
    @ObservedObject var locationManager = LocationManager.shared
    @EnvironmentObject var globalState: GlobalState
    
    var body: some View {
        
        NavigationStack {
            switch globalState.viewController {
            case "HomeView":
                HomeView()
                    .environmentObject(GlobalState.shared)
            case "AssistantView":
                AssistantView(historyParking: [
                    HistoryParking(name: "A停車場", date: "2024/06/01", time: "00:00 AM", price: 10),
                    HistoryParking(name: "B停車場", date: "2024/06/02", time: "00:00 AM", price: 20),
                    HistoryParking(name: "C停車場", date: "2024/06/03", time: "00:00 AM", price: 30),
                    HistoryParking(name: "D停車場", date: "2024/06/04", time: "00:00 AM", price: 40),
                    HistoryParking(name: "E停車場", date: "2024/06/05", time: "00:00 AM", price: 50),
                    HistoryParking(name: "F停車場", date: "2024/06/06", time: "00:00 AM", price: 60),
                    HistoryParking(name: "G停車場", date: "2024/06/07", time: "00:00 AM", price: 70)
                ])
                .environmentObject(GlobalState.shared)
            case "FavoriteParkingView":
                FavoriteParkingView(favorieParkingData: [
                    FavoriteParking(img: "", name:"A停車場", pricePerHour: 10, distance: 1.2, isRecommend: false),
                    FavoriteParking(img: "", name:"B停車場", pricePerHour: 20, distance: 1.0, isRecommend: true),
                    FavoriteParking(img: "", name:"C停車場", pricePerHour: 30, distance: 0.8, isRecommend: false),
                    FavoriteParking(img: "", name:"D停車場", pricePerHour: 40, distance: 0.6, isRecommend: false),
                    FavoriteParking(img: "", name:"E停車場", pricePerHour: 50, distance: 0.4, isRecommend: true),
                    FavoriteParking(img: "", name:"F停車場", pricePerHour: 60, distance: 0.2, isRecommend: true)
                ])
                .environmentObject(GlobalState.shared)
            case "SettingView":
                SettingView()
                    .environmentObject(GlobalState.shared)
            default:
                Text(GlobalState.shared.viewController)
            }
            
        }
    }
    
}

#Preview {
    ContentView()
        .environmentObject(GlobalState.shared)
}
