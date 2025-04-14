//
//  MapLocationPreviewView.swift
//  MyMapApp
//
//  Created by 12345 on 14.04.2025.
//

import SwiftUI

struct MapLocationPreviewView: View {
    var body: some View {
        VStack(spacing: -4.0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding(6)
                .background(Color("AccentColor"))
                .clipShape(Circle())
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 13, height: 13)
                .rotationEffect(.degrees(180))
                .foregroundColor(Color("AccentColor"))
                .padding(.bottom, 45)
        }
    }
}

struct MapLocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            MapLocationPreviewView()
        }
    }
}
