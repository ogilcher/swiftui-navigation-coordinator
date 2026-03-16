//
//  PetEdit.swift
//  SwiftUI-AppCoordinator-Demo
//
//  Created by Oliver Gilcher on 3/13/26.
//

import SwiftUI

// MARK: - PetEdit

/// Allows the user to edit an existing pet and submit changes back to the
/// application's source of truth.
struct PetEdit: View {
    @Environment(AppCoordinator.self) private var coordinator

    let petId: UUID

    @State private var draft = PetDraft()
    @State private var didLoadDraft = false

    private var pet: Pet? { coordinator.pet(for: petId) }

    var body: some View {
        VStack(spacing: 20) {
            Text("Edit Pet")
                .font(.title)
                .fontWeight(.semibold)

            if pet != nil {
                formContent

                Button("Save Changes") {
                    submit()
                }
                .buttonStyle(.borderedProminent)
            } else {
                ContentUnavailableView(
                    "No Pet Found",
                    systemImage: "pawprint.slash",
                    description: Text("The requested pet could not be loaded.")
                )
            }
        }
        .padding()
        .navigationTitle("Edit Pet")
        .task {
            loadDraftIfNeeded()
        }
    }
}

// MARK: - Form Content

private extension PetEdit {
    @ViewBuilder
    var formContent: some View {
        TextField("Name", text: $draft.name)
            .textFieldStyle(.roundedBorder)

        Picker("Type", selection: $draft.type) {
            ForEach(PetType.allCases, id: \.self) { type in
                Text(type.displayName).tag(type)
            }
        }
        .pickerStyle(.segmented)

        Stepper("Age: \(draft.age)", value: $draft.age, in: 0...50)

        TextField("Breed", text: $draft.breed)
            .textFieldStyle(.roundedBorder)
    }
}

// MARK: - Actions

private extension PetEdit {
    func loadDraftIfNeeded() {
        guard !didLoadDraft, let pet else { return }
        draft = PetDraft(pet: pet)
        didLoadDraft = true
    }

    func submit() {
        guard let existingPet = pet else { return }
        
        let breed = draft.breed == "" ? nil : draft.breed

        let updatedPet = Pet(
            id: existingPet.id,
            name: draft.name.trimmingCharacters(in: .whitespacesAndNewlines),
            type: draft.type,
            age: draft.age,
            breed: breed
        )

        coordinator.updatePet(updatedPet)
        coordinator.pop()
    }
}

#Preview {
    PetEdit(petId: .init())
        .environment(AppCoordinator())
}
