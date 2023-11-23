//
//  PALVADEAU_FlorianApp.swift
//  PALVADEAU_Florian
//
//  Created by PALVADEAU Florian on 20/11/2023.
//

import SwiftUI

@main
struct PALVADEAU_FlorianApp: App {
    @StateObject private var storeCollection: Contacts = Contacts(contacts: [])
    var body: some Scene {
        WindowGroup {
            ContactView(allContacts: storeCollection) {
                Task {
                    do {
                        try await ContactStore.save(contacts: storeCollection.contacts)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    storeCollection.contacts = try await ContactStore.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
