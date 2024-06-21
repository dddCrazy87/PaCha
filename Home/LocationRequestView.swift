//
//  LocationRequestView.swift
//  PaCha
//
//  Created by 許昀韋 on 2024/6/18.
//

import SwiftUI

struct LocationRequestView: View {
    var body: some View {
        VStack {
            Text("請先開啟定位！")
            
            Button {
                LocationManager.shared.requstLocation()
            } label: {
                Text("同意")
            }
        }
        
    }
}

#Preview {
    LocationRequestView()
}
