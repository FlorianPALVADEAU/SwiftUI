import SwiftUI

struct ContactView: View {
    @State private var contacts: [ContactSchema] = ContactSchema.previewContact
    @State private var showCreateContact = false

    var body: some View {
        NavigationView {
            List {
                ForEach(contacts) { contact in
                    NavigationLink(destination: ContactDetailView(contact: contact)) {
                        ContactRow(contact: contact)
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
                CreateContactView(contacts: $contacts)
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
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
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

struct ContactDetailView: View {
    var contact: ContactSchema

    let halfWindowWidth = (UIScreen.main.bounds.width * 0.5)
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: contact.profilePictureURL)) { image in
                image
                    .resizable()
                    .frame(width: halfWindowWidth, height: halfWindowWidth)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .padding()
            } placeholder: {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: halfWindowWidth, height: halfWindowWidth)
            }
            Text("\(contact.firstName) \(contact.lastName)")
                .font(.title)

            Text("Phone: \(String(contact.phoneNumber))")
                .padding()

            if contact.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .padding()
            }
        }
        .navigationBarTitle("Détails du Contact")
    }
}

struct CreateContactView: View {
    @Binding var contacts: [ContactSchema]
    @State private var profilePicture = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var isFavorite = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informations du contact")) {
                    TextField("URL de la photo de profil", text: $profilePicture)
                    TextField("Prénom", text: $firstName)
                    TextField("Nom de famille", text: $lastName)
                    TextField("Numéro de téléphone", text: $phoneNumber)
                }

                Section(header: Text("Options")) {
                    Toggle("Favori", isOn: $isFavorite)
                }

                Section {
                    Button(action: {
                        let newContact = ContactSchema(profilePictureURL: profilePicture, firstName: firstName, lastName: lastName, phoneNumber: Int(phoneNumber) ?? 0, isFavorite: isFavorite)
                        contacts.append(newContact)
                        print("Contact créé : \(newContact)")
                    }) {
                        Text("Créer le contact")
                    }
                }
            }
            .navigationBarTitle("Nouveau Contact")
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
