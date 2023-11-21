import SwiftUI

struct ContactDetailView: View {
    @ObservedObject var contact: ContactSchema

    @State private var showModifyContact = false

    let halfWindowWidth = (UIScreen.main.bounds.width * 0.5)

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: contact.profilePictureURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: halfWindowWidth, height: halfWindowWidth)
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

            Button(action: {
                showModifyContact.toggle()
            }) {
                Text("Modifier le contact")
            }
            .sheet(isPresented: $showModifyContact) {
                EditContactView(contacts: .constant([contact]), contact: contact)
            }
        }
        .navigationBarTitle("Détails du Contact")
    }
}
