//
//  PetDetails.swift
//  SwiftUI-AppCoordinator-Demo
//
//  Created by Oliver Gilcher on 3/13/26.
//

import SwiftUI

// MARK: - PetDetails

/// Displays detailed information about a specific pet.
///
/// `PetDetails` demonstrates how feature screens can retrieve domain data
/// from the shared `AppCoordinator` using an identifier passed through the
/// navigation system.
///
/// In this example, the screen receives a `petId` from the navigation route,
/// queries the coordinator for the corresponding `Pet`, and renders the
/// pet's information if it exists.
///
/// This pattern keeps navigation parameters lightweight while allowing
/// screens to resolve the data they need from a centralized source of truth.
struct PetDetails: View {

    // MARK: - Environment

    /// Shared application coordinator used to access global state.
    @Environment(AppCoordinator.self) private var coordinator

    // MARK: - Inputs

    /// The identifier of the pet whose details should be displayed.
    let petId: UUID

    // MARK: - Derived State

    /// The resolved pet from the coordinator's data store.
    private var pet: Pet? { coordinator.pet(for: petId) }

    // MARK: - View

    var body: some View {
        VStack(spacing: 20) {

            Text("Pet Details")
                .font(.title)
                .fontWeight(.semibold)

            Divider()

            if let pet {
                petDetailsContent(pet)
            } else {
                ContentUnavailableView(
                    "Pet Not Found",
                    systemImage: "pawprint.slash",
                    description: Text("The requested pet could not be located.")
                )
            }
        }
        .padding()
        .navigationTitle("Pet Details")
    }
}

// MARK: - Content Builders

private extension PetDetails {

    /// Displays the formatted details for a resolved pet.
    @ViewBuilder
    func petDetailsContent(_ pet: Pet) -> some View {
        VStack(alignment: .leading, spacing: 8) {

            Text("Name: \(pet.name)")
            Text("Type: \(pet.type.rawValue.capitalized)")
            Text("Age: \(pet.age)")

            if let breed = pet.breed {
                Text("Breed: \(breed)")
            }
            
            Button("Edit Pet") {
                coordinator.push(.pet(.edit(pet.id)))
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        PetDetails(petId: UUID())
            .environment(AppCoordinator())
    }
}
