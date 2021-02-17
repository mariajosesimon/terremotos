//
//  ContentView.swift
//  terremotos
//
//  Created by  on 05/02/2021.
//

import SwiftUI

struct ContentView: View {

    //crear una instancia del viewModel observable para que se modifique

    @ObservedObject var vm = ViewModel()

    var body: some View {

        VStack {

            //cargamos el mapa
            MapView()
            // ponemos los datos, ver como los pongo en un recuadro.
            .frame(height: 500)
            //para ver los datos del mapa
            Text("UBICACION")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            VStack {
                Text(vm.lugar)
                Text(vm.escala)
              


            }

        } //fin primer vstack

       /* VStack {
            //en el picker, en el selector llamamos al switch creado en el ViewModel para ver que url debemos llamar desde Alamofire

            Picker("DiasSeleccionados", selection: $vm.terremotosDias) {
                ForEach(Dias.allCases, id: \.self) {
                    dias in Text(dias.rawValue.capitalized)
                }

            }


        }//fin 2 vstack*/


            .onAppear(perform: {
                vm.cargarTerremotos()
            })

    }//fin del body

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
