import SwiftUI

struct ModifyContactView: View {
    @Binding var contacts: [ContactSchema]
    @Binding var showSuccessPopup: Bool
    @State private var profilePicture = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var isFavorite = false
    let halfWindowWidth = (UIScreen.main.bounds.width * 0.5)
    var contact: ContactSchema // The contact to be modified
    @Environment(\.presentationMode) var presentationMode

    init(contacts: Binding<[ContactSchema]>, showSuccessPopup: Binding<Bool>, contact: ContactSchema) {
        self._contacts = contacts
        self._showSuccessPopup = showSuccessPopup
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
                        let modifiedContact = ContactSchema(profilePictureURL: profilePicture, firstName: firstName, lastName: lastName, phoneNumber: Int(phoneNumber) ?? 0, isFavorite: isFavorite)
                        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
                            contacts[index] = modifiedContact
                            print("Contact modifié : \(modifiedContact)")
                            showSuccessPopup = true
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Modifier le contact")
                    }
                }
            }
        }
        .onAppear {
            // Additional setup if needed when the view appears
        }
    }
}
