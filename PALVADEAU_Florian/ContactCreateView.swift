// ContactCreateView.swift

import SwiftUI
import MapKit

struct CreateContactView: View {
    @ObservedObject var contacts: Contacts

    @Binding var showSuccessPopup: Bool
    @State private var profilePicture = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var isFavorite = false
    @State private var localisation = ""
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    let halfWindowWidth = (UIScreen.main.bounds.width * 0.5)
    @Environment(\.presentationMode) var presentationMode

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

                    Map(coordinateRegion: $region, showsUserLocation: true)
                        .frame(height: 200)
                }

                Section {
                    Button(action: {
                        let newContact = ContactSchema(profilePictureURL: profilePicture, firstName: firstName, lastName: lastName, phoneNumber: Int(phoneNumber) ?? 0, isFavorite: isFavorite, localisation: localisation)
                        contacts.contacts.append(newContact)
                        print("Contact créé : \(newContact)")
                        showSuccessPopup = true
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Créer le contact")
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
