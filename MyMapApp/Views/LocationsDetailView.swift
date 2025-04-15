//
//  LocationsDetailView.swift
//  MyMapApp
//
//  Created by 12345 on 15.04.2025.
//

import SwiftUI
import MapKit

struct LocationsDetailView: View {
    @EnvironmentObject var vm: LocationsViewModel
    let location: Location
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, y: 10)
                VStack(alignment: .leading) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapSection
                }
            }
            .overlay(alignment: .topLeading) {
                dissmisButton
            }
        }
        .background(.ultraThickMaterial)
        .ignoresSafeArea()
    }
}

struct LocationsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsDetailView(location: LocationsViewModel().locations.first!)
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 710 : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 500)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            if let url = URL(string: location.link) {
                Link(destination: url) {
                    Text("Learn more on Wikipedia")
                        .tint(.blue)
                        .font(.headline)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var mapSection: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                MapLocationPreviewView()
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(10)
            .padding()
    }
    
    private var dissmisButton: some View {
        Button {
            vm.detailLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(.primary)
                .padding()
                .background(.ultraThickMaterial)
                .cornerRadius(10)
        }
        .shadow(radius: 6)
        .padding()
    }
}
