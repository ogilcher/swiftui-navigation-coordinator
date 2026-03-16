//
//  HomeScreen.swift
//  SwiftUI-AppCoordinator-Demo
//
//  Created by Oliver Gilcher on 3/13/26.
//

import SwiftUI

// MARK: - HomeScreen

/// The primary landing screen for the demo application.
///
/// `HomeScreen` serves as the root entry point into the app's main feature areas,
/// allowing the user to navigate into pet management, care tracking, and settings.
///
/// This screen demonstrates how feature navigation can remain lightweight within
/// the view layer by delegating routing decisions to the shared `AppCoordinator`.
struct HomeScreen: View {
    @Environment(AppCoordinator.self) private var coordinator

    var body: some View {
        VStack {
            Text("Pets Demo App")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Spacer()
                .frame(height: 100)

            VStack(spacing: 20) {
                Button("See Your Pets") {
                    coordinator.push(.pet(.dashboard))
                }
                .font(.title2)
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .navigationTitle("Home")
        .toolbar {
            settingsToolbarItem
        }
    }
}

// MARK: - Toolbar

private extension HomeScreen {

    /// Provides quick access to the settings flow.
    @ToolbarContentBuilder
    var settingsToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                coordinator.push(.settings(.dashboard))
            } label: {
                Image(systemName: "line.3.horizontal")
            }
            .accessibilityLabel("Open Settings")
        }
    }
}

#Preview {
    NavigationStack {
        HomeScreen()
            .environment(AppCoordinator())
    }
}
