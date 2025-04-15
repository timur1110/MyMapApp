//
//  LocationsView.swift
//  MyMapApp
//
//  Created by 12345 on 08.04.2025.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject var vm: LocationsViewModel
    let maxWidthForIPad: CGFloat = 700
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            
            VStack {
                header
                    .frame(maxWidth: maxWidthForIPad)
                    .padding()
                Spacer()
                previewLayer
                    .sheet(item: $vm.detailLocation) { location in
                        LocationsDetailView(location: location)
                    }
            }
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button(action: vm.toggleLocationsList) {
                Text(vm.currentLocation.name + ", " + vm.currentLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.currentLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocatinosList ? 180 : 0))
                    }
            }
            
            if vm.showLocatinosList {
                LocationsListView()
//                    .frame(maxHeight: 400)
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                MapLocationPreviewView()
                    .scaleEffect(vm.currentLocation == location ? 1 : 0.6)
                    .animation(.easeInOut, value: vm.currentLocation)
                    .onTapGesture {
                        vm.updateCurrentLocation(location: location)
                    }
                    .shadow(radius: 10)
            }
        })
    }
    
    private var previewLayer: some View {
        ForEach(vm.locations) { location in
            if location == vm.currentLocation {
                LocationPreviewView(location: location)
                    .padding()
                    .frame(maxWidth: maxWidthForIPad)
                    .frame(maxWidth: .infinity)
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
    }
}
