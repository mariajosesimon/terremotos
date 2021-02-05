//
//  ViewModel.swift
//  terremotos
//
//  Created by  on 05/02/2021.
//
//Aqui tenemos que traer los datos de la web de los terremotos. Es la parte logica del programa.

import SwiftUI
import Alamofire
import GeoJSON

//esta clase tiene que ser la observable que es lo primero que carga.

enum Dias: String, CaseIterable, Identifiable {
    case hoy
    case ayer
    case semana

    var id: String { self.rawValue }
}


class ViewModel: ObservableObject {

    @Published var terremotos = Dias.hoy
    func didSet() {
        cargarTerremotos()
    }


    struct ViewModel_Previews: PreviewProvider {
        static var previews: some View {
            ViewModel()
        }
    }

    let terrHoy = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"
    
    let terrAyer = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
    
    let terrSemana = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson"


    func cargarTerremotos() {

        
    } //fin func CargarTerremotos
}
