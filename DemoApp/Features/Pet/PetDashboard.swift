//
//  PetDashboard.swift
//  SwiftUI-AppCoordinator-Demo
//
//  Created by Oliver Gilcher on 3/13/26.
//

import SwiftUI

// MARK: - PetDashboard

/// Displays a list of pets and provides entry points into pet-related flows.
///
/// `PetDashboard` acts as the main landing screen for pet management within
/// the application. From here, users can view pet details, access medical
/// history, or edit pet information.
///
/// In a production implementation, pets would typically be loaded from a
/// shared data store or injected service. For this demo, sample data is used
/// to demonstrate navigation flows.
struct PetDashboard: View {

    @Environment(AppCoordinator.self) private var coordinator

    var body: some View {
        VStack(spacing: 20) {
            ForEach(coordinator.pets, id: \.id) { pet in
                PetCard(pet) { screen in
                    coordinator.push(screen)
                }

                Divider()
            }
        }
        .padding()
        .navigationTitle("Pets Dashboard")
    }
}

// MARK: - PetCard

/// A compact card displaying basic pet information and quick navigation actions.
private struct PetCard: View {

    let pet: Pet
    let navigate: (AppScreen) -> Void

    init(
        _ pet: Pet,
        navigate: @escaping (AppScreen) -> Void
    ) {
        self.pet = pet
        self.navigate = navigate
    }

    var body: some View {
        HStack(alignment: .center) {

            Text(pet.name)
                .font(.title2)
                .fontWeight(.semibold)

            Spacer()
            
            Button("Details") {
                navigate(.pet(.details(pet.id)))
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    NavigationStack {
        PetDashboard()
            .environment(AppCoordinator())
    }
}
