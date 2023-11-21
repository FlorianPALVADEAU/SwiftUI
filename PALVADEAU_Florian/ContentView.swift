//
//  ContentView.swift
//  PALVADEAU_Florian
//
//  Created by PALVADEAU Florian on 20/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var buttonColor: Color = .green
    @State var name: String = "aaa"
    

    
    var body: some View {
        let url = URL(string:"https://images.unsplash.com/photo-1698859858637-9aa64302f629?q=80&w=4332&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
        
        VStack {
            AsyncImage(url: url) {
                image in image
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
            }

            Button(action: {
                if buttonColor == .red {
                    buttonColor = .green
                } else {
                    buttonColor = .red
                }
                print("test")
            }, label: {
                Text(name)
                    .foregroundColor(Color.blue)
                    .padding()
                    .background(buttonColor)
            })
        }
        .padding()
        .background(Color.indigo)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
