import SwiftUI

struct EditContactView: View {
    @Binding var contacts: [ContactSchema]
    @State private var profilePicture: String
    @State private var firstName: String
    @State private var lastName: String
    @State private var phoneNumber: String
    @State private var isFavorite: Bool
    let halfWindowWidth = (UIScreen.main.bounds.width * 0.5)
    var contact: ContactSchema
    @Environment(\.presentationMode) var presentationMode

    init(contacts: Binding<[ContactSchema]>, contact: ContactSchema) {
        self._contacts = contacts
        self.contact = contact
        self._profilePicture = State(initialValue: contact.profilePictureURL)
        self._firstName = State(initialValue: contact.firstName)
        self._lastName = State(initialValue: contact.lastName)
        self._phoneNumber = State(initialValue: String(contact.phoneNumber))
        self._isFavorite = State(initialValue: contact.isFavorite)
    }

    var body: some View {
        NavigationView {
            Form {
                AsyncImage(url: URL(string: profilePicture)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: halfWindowWidth, height: halfWindowWidth)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .foregroundColor(.gray)
                        .frame(width: halfWindowWidth, height: halfWindowWidth)
                }
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
                        _ = ContactSchema(
                            profilePictureURL: profilePicture,
                            firstName: firstName,
                            lastName: lastName,
                            phoneNumber: Int(phoneNumber) ?? 0,
                            isFavorite: isFavorite
                        )
                        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
                            contacts[index].profilePictureURL = profilePicture
                            contacts[index].firstName = firstName
                            contacts[index].lastName = lastName
                            contacts[index].phoneNumber = Int(phoneNumber) ?? 0
                            contacts[index].isFavorite = isFavorite

                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Modifier le contact")
                    }
                }
            }
        }
    }
}
