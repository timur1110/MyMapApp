//
//  MyMapAppApp.swift
//  MyMapApp
//
//  Created by 12345 on 08.04.2025.
//

import SwiftUI

@main
struct MyMapAppApp: App {
    @StateObject private var vm: LocationsViewModel = LocationsViewModel()
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
