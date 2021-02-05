//
//  MapView.swift
//  terremotos
//
//  Created by  on 05/02/2021.
//
import SwiftUI
import MapKit
struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.2302 , longitude: -6.14764), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2 ))
    
    //el parametro span es el rectangulo o cuadrado que mostrará el mapa
    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
