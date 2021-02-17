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
import Foundation

//esta clase tiene que ser la observable que es lo primero que carga.

enum Dias: String, CaseIterable, Identifiable {

    case ayer
    case hoy
    case semana

    var id: String { self.rawValue }
}

class ViewModel: ObservableObject {
    //creacion de las variables que llamen a las propiedades del ContentView. 
    @Published var lugar = "Carbellino"
    @Published var escala = "0"
    
    @Published var terremotosDias = Dias.hoy
    func didSet() { //es la carga de datos al arrancar
        cargarTerremotos()
    }

    //estas son las 3 url a las que puede llamar url= urlhoy
   
    //let terrAyer = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
    // let terrSemana = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson"
    let urlhoy = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"
    
    //var url: URL
    //esta es la funcion para cargar los datos desde internet, y tendremos que llamar a Alamofire.
    func cargarTerremotos() {
        //¿Como recibimos que pickin a escogido hoy / ayer / semana?
        
       /* var index: Int
        
        switch self.terremotosDias{
            case .hoy:
                index = 0
                url = ("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson").asURL()
                
            case .ayer:
                index = 1
                url = ("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson").asURL()
            case .semana:
                index = 2
                url = ("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson").asURL()

        } //fin switch*/
        
        
        AF.request(urlhoy).responseJSON{
                        
                response in
                print(response.result)
                //hasta aqui es la peticion de alamofire a la url que queremos.
                
                //ahora tendremos que procesar los datos.
                
                //tenemos que obtener el arbol DOM del json
                //ojo, revisar si hay 3 json distintos.
                
             //   let json = GeoJSON
                
                
            
            
        } //fin AF.Request

        
        
    } //fin func CargarTerremotos

}
