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



struct Properties: Decodable {
    var mag: Double
    var place: String
    var type: String
    var longitude: Double
    var latitude: Double

}

class ViewModel: ObservableObject {
    //creacion de las variables que llamen a las propiedades del ContentView.

    @Published var terremotos = [Properties]()
    @Published var lugar = "Carbellino"
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





    //esta es la url de hoy.
    var url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"


    //esta es la funcion para cargar los datos desde internet, y tendremos que llamar a Alamofire.
    func cargarTerremotos() {

        //¿Como recibimos que pickin a escogido hoy / ayer / semana?



        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {

            case .success(let value):



                let json = JSON(value)
                // print("JSON: \(json)")

                var index: Int

                switch self.terremotosDias {
                case .ayer:
                    index = 0
                    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
                    print("estoy en ayer")

                case .hoy:
                    index = 1
                    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"

                    print("estoy en hoy")

                case .semana:
                    index = 2
                    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson"
                    print("estoy en semana")

                } //fin switch


                //array con datos de features
                let terre = json["features"].arrayValue



                var unTerremoto: Properties = Properties (
                    mag: 0.0, place: "Carbellino", type: "Terremoto", longitude: -6.14764, latitude: 41.2302)


                //Meto en el array los datos.
                for item in terre {
                    self.escala = item["properties"]["mag"].doubleValue
                    self.lugar = item["properties"]["place"].stringValue
                    self.tipo = item["properties"]["type"].stringValue
                    self.long = item["geometry"]["coordinates"][1].doubleValue
                    self.lat = item["geometry"]["coordinates"][0].doubleValue

                    unTerremoto.mag = self.escala
                    unTerremoto.place = self.lugar
                    unTerremoto.type = self.tipo
                    unTerremoto.longitude = self.long
                    unTerremoto.latitude = self.lat

                    terremotos.append(unTerremoto)
                    print(unTerremoto)

                }







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
