//
//  SettingsDashboard.swift
//  SwiftUI-AppCoordinator-Demo
//
//  Created by Oliver Gilcher on 3/13/26.
//

import SwiftUI

struct SettingsDashboard: View {
    @Environment(AppCoordinator.self) private var coordinator
    
    var body: some View {
        VStack (spacing: 20) {
            Text("Example Settings Dashboard")
                .font(.title.bold())
            
            Button("Personalization") {
                coordinator.push(.settings(.personalization))
            }
            .font(.title2)
            .buttonStyle(.bordered)
            
            Button("Security") {
                coordinator.push(.settings(.security))
            }
            .font(.title2)
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    SettingsDashboard()
        .environment(AppCoordinator())
}
