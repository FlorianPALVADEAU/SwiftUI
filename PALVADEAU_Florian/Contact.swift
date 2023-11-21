//
//  Contact.swift
//  PALVADEAU_Florian
//
//  Created by PALVADEAU Florian on 20/11/2023.
//

import Foundation

class Contacts: ObservableObject {
    @Published var contacts: [ContactSchema]
    
    init(contacts: [ContactSchema]) {
        self.contacts = contacts
    }
}

class ContactSchema: Identifiable, ObservableObject {
    var id: UUID = UUID()
    @Published var profilePictureURL: String
    @Published var firstName: String
    @Published var lastName: String
    @Published var phoneNumber: Int
    @Published var isFavorite: Bool
    
    init(profilePictureURL: String,firstName: String,lastName: String,phoneNumber: Int, isFavorite: Bool) {
        self.profilePictureURL = profilePictureURL
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.isFavorite = isFavorite
    }

}

extension ContactSchema {
    static let previewContact: [ContactSchema] = [
        ContactSchema(profilePictureURL: "https://images.unsplash.com/photo-1679679008383-6f778fe07828?q=80&w=2268&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", firstName: "Florian", lastName: "PALVADEAU", phoneNumber: 0652266054, isFavorite: true),
        ContactSchema(profilePictureURL: "https://images.unsplash.com/photo-1531384441138-2736e62e0919?q=80&w=4000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", firstName: "Adel", lastName: "KHITER", phoneNumber: 0652654654, isFavorite: false),
        ContactSchema(profilePictureURL: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=3276&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", firstName: "Elyes", lastName: "VOISIN", phoneNumber: 0765151251, isFavorite: false),
        ContactSchema(profilePictureURL: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=2662&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", firstName: "Louis", lastName: "PERRENOT", phoneNumber: 0664523168, isFavorite: false),
        ContactSchema(profilePictureURL: "https://99designs-blog.imgix.net/blog/wp-content/uploads/2016/03/web-images.jpg?auto=format&q=60&w=1600&h=824&fit=crop&crop=faces", firstName: "Mattéo", lastName: "COURQUIN", phoneNumber: 0664523168, isFavorite: false),
        ContactSchema(profilePictureURL: "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D", firstName: "Eva", lastName: "GARCIA", phoneNumber: 0754628457, isFavorite: true),
        ContactSchema(profilePictureURL: "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg", firstName: "Théophile", lastName: "OCCELOTTI", phoneNumber: 0668988454, isFavorite: false),
        ContactSchema(profilePictureURL: "https://img-19.commentcamarche.net/wzKKufHO7dLH-WPFdXJHEmOmi7E=/1500x/smart/2d8c2b30aee345008ee860087f8bcdc9/ccmcms-commentcamarche/36120212.jpg", firstName: "Test", lastName: "TEST", phoneNumber: 0745915346, isFavorite: false),
    ]
}
