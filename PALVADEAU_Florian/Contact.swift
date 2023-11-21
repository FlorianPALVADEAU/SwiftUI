//
//  Contact.swift
//  PALVADEAU_Florian
//
//  Created by PALVADEAU Florian on 20/11/2023.
//

import Foundation

struct ContactSchema: Identifiable {
    let id: UUID = UUID()
    let profilePictureURL: String
    let firstName: String
    let lastName: String
    let phoneNumber: Int
    let isFavorite: Bool
}

extension ContactSchema {
    static let previewContact: [ContactSchema] = [
        ContactSchema(profilePictureURL: "https://images.unsplash.com/photo-1679679008383-6f778fe07828?q=80&w=2268&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", firstName: "Florian", lastName: "PALVADEAU", phoneNumber: 0652266054, isFavorite: true),
        ContactSchema(profilePictureURL: "https://images.unsplash.com/photo-1531384441138-2736e62e0919?q=80&w=4000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", firstName: "Adel", lastName: "KHITER", phoneNumber: 0652654654, isFavorite: true),
        ContactSchema(profilePictureURL: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=3276&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", firstName: "Elyes", lastName: "VOISIN", phoneNumber: 0765151251, isFavorite: false),
        ContactSchema(profilePictureURL: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=2662&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", firstName: "Louis", lastName: "PERRENOT", phoneNumber: 0664523168, isFavorite: true)
    ]
}
