import SwiftUI
import MapKit

struct MapSearchView: View {
    
    @Binding var searchText :String
    @FocusState private var isTextFieldFocused: Bool
    @State private var isResultListOpen = true
    
    @Binding var searchResults: [MKMapItem]
    @Binding var result: MKMapItem
    @Binding var cameraPosition: MapCameraPosition
    
    var body: some View {
        ZStack {
            if isTextFieldFocused {
                Color.gray.opacity(0.9)
            }
            
            VStack {
                HStack {
                    if isTextFieldFocused {
                        Button {
                            isTextFieldFocused = false
                        } label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .foregroundColor(Color("SearchText"))
                                .frame(width: 15, height: 20)
                                .padding(.leading, 30)
                        }
                    }
                    else {
                        Image("Search")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .padding(.leading, 30)
                    }
                    
                    TextField("", text: $searchText, prompt:
                        Text("搜尋")
                            .foregroundStyle(Color("SearchText"))
                    )
                        .foregroundStyle(Color("SearchText"))
                        .focused($isTextFieldFocused)
                        .font(.system(size: 20))
                        .padding(.leading, 5)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Image("Micphone")
                        .resizable()
                        .frame(width: 18, height: 25)
                        .padding(.trailing, 30)
                }
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color.white.opacity(0.85))
                        .frame(width: 370, height: 50)
                }
                .padding(.top, 70)
                
                Spacer()
            }
            
            if isTextFieldFocused {
                List(searchResults, id: \.self) {item in
                    Button {
                        result = item
                        withAnimation(.easeInOut(duration: 10)) {
                            cameraPosition = .region(MKCoordinateRegion(center: result.placemark.coordinate, latitudinalMeters: 500, longitudinalMeters: 500))
                        }
                        isTextFieldFocused = false
                    } label: {
                        VStack(alignment: .leading) {
                            Text(item.name ?? "")
                                .font(.headline)
                            Text(item.placemark.title ?? "")
                                .font(.subheadline)
                                .foregroundStyle(Color("DetailTitle"))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .listStyle(.plain)
                .padding(.top, 115)
                .padding(.horizontal, 10)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalState.shared)
}
