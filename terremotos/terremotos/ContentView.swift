//
//  ContentView.swift
//  terremotos
//
//  Created by  on 05/02/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       
        VStack{
            MapView()
                .frame(height: 500)
                   //para ver los datos del mapa
                   Text("UBICACION")
                       .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                   VStack{
                       Text("Lugar")
                       Text("Escala Richer")
                       Text("Fecha")
                       
                       
                   }
                   
               }




      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
