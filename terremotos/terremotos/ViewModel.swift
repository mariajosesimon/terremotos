//
//  ViewModel.swift
//  terremotos
//
//  Created by  on 05/02/2021.
//
//Aqui tenemos que traer los datos de la web de los terremotos. Es la parte logica del programa.

import SwiftUI
import Alamofire
import JSON
import SwiftyJSON
import Foundation

//esta clase tiene que ser la observable que es lo primero que carga.

enum Dias: String, CaseIterable, Identifiable {
    case ayer
    case hoy
    case semana

    var id: String { self.rawValue }
}


struct Features: Decodable{
    let propiedades: Properties
  
}


struct Properties: Decodable{
    let mag: Double
    let place: String
    let type: String
}

class ViewModel: ObservableObject {
    //creacion de las variables que llamen a las propiedades del ContentView.
    
    @Published var terremotosHoy = [Features]()
    @Published var lugar = "Carbellino"
    @Published var tipo = "terremoto"
    @Published var escala = "0"
    @Published var terremotosDias = Dias.hoy
    func didSet() { //es la carga de datos al arrancar
        cargarTerremotos()
    }

    //estas son las 3 url a las que puede llamar url= urlhoy

    //let terrAyer = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
    //let terrSemana = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson"
    var url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"

  
    //esta es la funcion para cargar los datos desde internet, y tendremos que llamar a Alamofire.
    func cargarTerremotos() {
        //¿Como recibimos que pickin a escogido hoy / ayer / semana?

        var index: Int

        switch self.terremotosDias {
        case .hoy:
            index = 0
            url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"

        case .ayer:
            index = 1
            url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
        case .semana:
            index = 2
            url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson"

        } //fin switch



        
           
            AF.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    
                    
                    
                    
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
            //hasta aqui es la peticion de alamofire a la url que queremos.
            //print(response.result)

           

            //en response hemos recibido el json, que tenemos que procesar.

            

            //ahora tendremos que procesar los datos.

            //tenemos que obtener el arbol DOM del json
            //ojo, revisar si hay 3 json distintos.

           



         //fin AF.Request



    } //fin func CargarTerremotos

}
