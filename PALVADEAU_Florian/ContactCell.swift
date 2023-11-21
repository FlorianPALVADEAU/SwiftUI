////
////  ContactCell.swift
////  PALVADEAU_Florian
////
////  Created by PALVADEAU Florian on 21/11/2023.
////
//
//import SwiftUI
//
//struct ContactRow: View {
//    
//    @ObservedObject var contact: ContactSchema
//
//    var body: some View {
//        HStack {
//            AsyncImage(url: URL(string: contact.profilePictureURL)) { image in
//                image
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 50, height: 50)
//                    .clipShape(Circle())
//            } placeholder: {
//                Circle()
//                    .foregroundColor(.gray)
//                    .frame(width: 50, height: 50)
//            }
//
//            VStack(alignment: .leading) {
//                Text("\(contact.firstName) \(contact.lastName)")
//                Text(String(contact.phoneNumber))
//            }
//
//            Spacer()
//
//            if contact.isFavorite {
//                Image(systemName: "star.fill")
//                    .foregroundColor(.yellow)
//            }
//        }
//    }
//}
//
//struct ContactRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactRow(contact: ContactSchema.previewContact[0])
//    }
//}
//
