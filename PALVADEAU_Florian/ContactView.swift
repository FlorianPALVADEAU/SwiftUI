//
//  ContentView.swift
//  PALVADEAU_Florian
//
//  Created by PALVADEAU Florian on 20/11/2023.
//

import SwiftUI

struct ContactView: View {
    @StateObject var allContacts: Contacts
    @State private var showCreateContact = false
    @State private var showSuccessPopup = false
    @State private var sortByFavorite: Bool = false

    var filteredContacts: [ContactSchema] {
        if sortByFavorite {
            return allContacts.contacts.filter { $0.isFavorite }
        } else {
            return allContacts.contacts
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("Trier par", selection: $sortByFavorite) {
                    Text("Tous").tag(false)
                    Text("Favoris").tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List {
                    ForEach(filteredContacts) { contact in
                        NavigationLink(destination: ContactDetailView(contact: contact)) {
                            ContactRow(contact: contact)
                        }
                    }
                    .onDelete { indexSet in
                        allContacts.contacts.remove(atOffsets: indexSet)
                    }
                    .onMove { indexSet, index in
                        allContacts.contacts.move(fromOffsets: indexSet, toOffset: index)
                    }
                }
            }
            .navigationBarTitle("Liste des Contacts")
            .navigationBarItems(trailing: Button(action: {
                showCreateContact.toggle()
            }) {
                Image(systemName: "plus.circle")
            })
            .sheet(isPresented: $showCreateContact) {
                CreateContactView(contacts: allContacts, showSuccessPopup: $showSuccessPopup)
            }
            .alert(isPresented: $showSuccessPopup) {
                Alert(title: Text("Succès"), message: Text("Utilisateur créé avec succès"), dismissButton: .default(Text("OK")))
            }
        }
    }
}


struct ContactRow: View {
    var contact: ContactSchema

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: contact.profilePictureURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 50)
            }

            VStack(alignment: .leading) {
                Text("\(contact.firstName) \(contact.lastName)")
                Text(String(contact.phoneNumber))
            }

            Spacer()

            if contact.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct ContactView_Previews: PreviewProvider {

    static var previews: some View {
        ContactView(allContacts: Contacts(contacts: ContactSchema.previewContact))
    }
}
