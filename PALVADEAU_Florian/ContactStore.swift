//
//  ContactStore.swift
//  PALVADEAU_Florian
//
//  Created by PALVADEAU Florian on 23/11/2023.
//

import SwiftUI

@MainActor
class ContactStore: ObservableObject {
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("contacts.data")

    }
    
    static func load() async throws->[ContactSchema] {
        let task = Task<[ContactSchema], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let ContactSchemas = try JSONDecoder().decode([ContactSchema].self, from: data)
            return ContactSchemas
        }
        let contacts = try await task.value
        return contacts
    }
    
    static func save(contacts: [ContactSchema]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(contacts)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
