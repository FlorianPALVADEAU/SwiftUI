import SwiftUI
import MapKit

struct EditContactView: View {
    @Binding var contacts: [ContactSchema]
    @State private var profilePicture: String
    @State private var firstName: String
    @State private var lastName: String
    @State private var phoneNumber: String
    @State private var isFavorite: Bool
    @State private var localisation: String
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
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
        self._localisation = State(initialValue: contact.localisation)

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
                
                Section(header: Text("Localisation")) {
                    TextField("Localisation", text: $localisation, onEditingChanged: { isEditing in
                        if !isEditing {
                            geocodeCity()
                        }
                    })
                    .onAppear {
                        geocodeCity()
                    }

                    Map(coordinateRegion: $region, showsUserLocation: true)
                        .frame(height: 200)
                }

                Section {
                    Button(action: {
                        _ = ContactSchema(
                            profilePictureURL: profilePicture,
                            firstName: firstName,
                            lastName: lastName,
                            phoneNumber: Int(phoneNumber) ?? 0,
                            isFavorite: isFavorite,
                            localisation: localisation

                        )
                        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
                            contacts[index].profilePictureURL = profilePicture
                            contacts[index].firstName = firstName
                            contacts[index].lastName = lastName
                            contacts[index].phoneNumber = Int(phoneNumber) ?? 0
                            contacts[index].isFavorite = isFavorite
                            contacts[index].localisation = localisation

                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Modifier le contact")
                    }
                }
            }
        }
    }
    
    private func geocodeCity() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(localisation) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                return
            }
            region.center = location.coordinate
        }
    }
}
