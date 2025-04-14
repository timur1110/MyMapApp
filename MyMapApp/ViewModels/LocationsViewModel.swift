//
//  LocationsViewModel.swift
//  MyMapApp
//
//  Created by 12345 on 08.04.2025.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location]
    
    @Published var currentLocation: Location {
        didSet {
            updateRegion(location: currentLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    // show list of locations
    @Published var showLocatinosList: Bool = false
    
    let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.currentLocation = locations.first!
        
        updateRegion(location: currentLocation)
    }
    
    private func updateRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: span
            )
        }
    }
    
    func updateCurrentLocation(location: Location) {
        withAnimation(.easeInOut) {
            self.currentLocation = location
            showLocatinosList = false
        }
    }
    
    
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocatinosList.toggle()
        }
    }
    
    func nextButtonPressed() {
        // Get current index
        guard let currentIndex = locations.firstIndex(where: {$0 == currentLocation}) else {
            print("Could not find current index in locations array. Should never happen.")
            return
        }
        
        // Check if next index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is not valid
            // Restart from 0
            guard let firstLocation = locations.first else { return }
            updateCurrentLocation(location: firstLocation)
            return
        }
        
        // Next Index is valid
        let nextLocation = locations[nextIndex]
        updateCurrentLocation(location: nextLocation)
        
    }
}
