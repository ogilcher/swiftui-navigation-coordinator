//
//  ContentView.swift
//  SwiftUI-AppCoordinator-Demo
//
//  Created by Oliver Gilcher on 3/13/26.
//

import SwiftUI

struct ContentView: View {
    @State private var coordinator = AppCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            NavigationRouter.build(
                for: coordinator.root,
                coordinator: coordinator
            )
                .navigationDestination(for: AppScreen.self) { screen in
                    NavigationRouter.build(
                        for: screen,
                        coordinator: coordinator
                    )
                }
        }
        .environment(coordinator)
        .task {
            await coordinator.bootstrapSession()
        }
    }
}

#Preview {
    ContentView()
}
