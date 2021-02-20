//
//  MapView.swift
//  terremotos
//
//  Created by  on 05/02/2021.
//
import SwiftUI
import MapKit
struct MapView: View {
    
    @EnvironmentObject var vm: ViewModel

    //el parametro span es el rectangulo o cuadrado que mostrará el mapa
    var body: some View {
        Map(coordinateRegion: $vm.region)
        
       
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
