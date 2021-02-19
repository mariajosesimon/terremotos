//
//  terremotosApp.swift
//  terremotos
//
//  Created by  on 05/02/2021.
//

import SwiftUI

@main
struct terremotosApp: App {
    
    var vm = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(vm)
        }
    }
}
