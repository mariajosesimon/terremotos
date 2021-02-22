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
import MapKit


//esta clase tiene que ser la observable que es lo primero que carga.

enum Dias: String, CaseIterable, Identifiable {
    case ayer
    case hoy
    case semana

    var id: String { self.rawValue }
}



struct Properties: Identifiable {
    var id: String
    var mag: Double
    var place: String
    var type: String
    var longitude: Double
    var latitude: Double
    var coordenadas: CLLocationCoordinate2D

}

class ViewModel: ObservableObject {
    //creacion de las variables que llamen a las propiedades del ContentView.

    @Published var terremotos = [Properties]()
    @Published var lugar = "Carbellino"
    @Published var id = "0"
    @Published var tipo = "terremoto"
    @Published var escala = 0.0
    @Published var long = -6.14764
    @Published var lat = 41.2302
    @Published var terremotosDias = Dias.hoy {
        didSet { //es la carga de datos al arrancar
            cargarTerremotos()
        }
    }
    
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.2302, longitude: -6.14764), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))


    @Published var zonaTerremoto = CLLocationCoordinate2D(latitude: 41.2302, longitude: -6.14764)
    
    

    //esta es la url de hoy.
    var url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_hour.geojson"


    //esta es la funcion para cargar los datos desde internet, y tendremos que llamar a Alamofire.
    func cargarTerremotos() {

        //¿Como recibimos que pickin a escogido hoy / ayer / semana?
        
        
        
        terremotos.removeAll()

        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {

            case .success(let value):


                let json = JSON(value)
                // print("JSON: \(json)")


                switch self.terremotosDias {
                case .ayer:
                   
                    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_day.geojson"
                    print("estoy en ayer")

                case .hoy:
                    
                    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_hour.geojson"

                    print("estoy en hoy")

                case .semana:
                   
                    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_week.geojson"
                    print("estoy en semana")

                } //fin switch


                //array con datos de features
                let terre = json["features"].arrayValue



                var unTerremoto: Properties = Properties (
                    id:"0",mag: 0.0, place: "Carbellino", type: "Terremoto", longitude: -6.14764, latitude: 41.2302, coordenadas: zonaTerremoto)


                //Meto en el array los datos.
                for item in terre {
                    self.id = item["id"].stringValue
                    self.escala = item["properties"]["mag"].doubleValue
                    self.lugar = item["properties"]["place"].stringValue
                    self.tipo = item["properties"]["type"].stringValue
                    self.long = item["geometry"]["coordinates"][0].doubleValue
                    self.lat = item["geometry"]["coordinates"][1].doubleValue
                    self.zonaTerremoto.latitude = item["geometry"]["coordinates"][1].doubleValue
                    self.zonaTerremoto.longitude = item["geometry"]["coordinates"][0].doubleValue
                    
                    
                    unTerremoto.coordenadas = zonaTerremoto
                    unTerremoto.mag = self.escala
                    unTerremoto.place = self.lugar
                    unTerremoto.type = self.tipo
                    unTerremoto.longitude = self.long
                    unTerremoto.latitude = self.lat

                    terremotos.append(unTerremoto)
                    
                
                }
                
                
                
                //estas  lineas son para ubicar en el mapa el terremoto y poner la chincheta
                //estoy utilizando el ultimo registro que lee a ver si pone bien la chincheta.
                self.zonaTerremoto.latitude = unTerremoto.latitude
                self.zonaTerremoto.longitude = unTerremoto.longitude
                
                
                //self.region.center = zonaTerremoto


                self.region = MKCoordinateRegion(
                    center: zonaTerremoto, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
               

                



            case .failure(let error):
                print(error)
            }
        }




    } //fin func CargarTerremotos

}
