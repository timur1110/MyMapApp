//
//  LocationPreviewView.swift
//  MyMapApp
//
//  Created by 12345 on 11.04.2025.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject var vm: LocationsViewModel
    let location: Location
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 15.0) {
                imageSection
                textSection
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            VStack {
                learnMoreButton
                nextButton
            }
            .padding(.vertical)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 70)
        )
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20)
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            LocationPreviewView(location: LocationsViewModel().locations.first!)
                .padding()
                .environmentObject(LocationsViewModel())
        }
    }
}

extension LocationPreviewView {
    var imageSection: some View {
        Image(location.imageNames.first!)
            .resizable()
            .scaledToFill()
            .frame(width: 125, height: 125)
            .cornerRadius(10)
            .padding(6)
            .background(.white)
            .cornerRadius(10)
    }
    
    var textSection: some View {
        VStack(alignment: .leading, spacing: 6.0) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
    }
    
    var learnMoreButton: some View {
        Button {
            
        } label: {
            Text("Learn more")
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
