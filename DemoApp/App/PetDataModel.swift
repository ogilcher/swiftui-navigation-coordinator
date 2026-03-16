//
//  PetDataModel.swift
//  SwiftUI-AppCoordinator-Demo
//
//  Created by Oliver Gilcher on 3/13/26.
//

import Foundation

// MARK: - Pet Type Enum
/// Used for determining the type of pet that the user is saving
enum PetType: String, Codable, CaseIterable {
    case dog, cat, fish, bird
    
    var displayName: String {
        switch self {
        case .dog: return "Dog"
        case .cat: return "Cat"
        case .fish: return "Fish"
        case .bird: return "Bird"
        }
    }
}

// MARK: - Pet Data Model
/// Data model used by the app and stored in `AppCoordinator` under `pets`.
public struct Pet: Identifiable, Hashable, Sendable {
    public let id: UUID
    
    var name: String
    var type: PetType
    var age: Int
    var breed: String?
}

// MARK: - PetDraft

/// Temporary editable state used by `PetEdit` before committing changes to
/// the coordinator.
struct PetDraft {
    var name: String = ""
    var type: PetType = .dog
    var age: Int = 0
    var breed: String = ""

    init() {}

    init(pet: Pet) {
        name = pet.name
        type = pet.type
        age = pet.age
        breed = pet.breed ?? ""
    }
}
