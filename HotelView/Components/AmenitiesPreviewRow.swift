//
//  Overview.swift
//
//  
//

import SwiftUI

struct AmenitiesPreviewRow: View {
    let categories: [String: [String]]
    @State private var showFullAmenities = false

    private let previewCount = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Amenities")
                    .font(.system(size: 25, weight: .semibold))
                    .padding(.top, 20)
                    .padding(.leading, 38)
            }

            HStack(alignment: .top, spacing: 20) {
                let allAmenities = categories.flatMap { $0.value }
                let previewAmenities = Array(allAmenities.prefix(previewCount))

                ForEach(previewAmenities, id: \.self) { amenity in
                    VStack(spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.8))
                                .frame(width: 28, height: 28)
                                .overlay(
                                    Circle().stroke(Color.gray, lineWidth: 2)
                                )

                            Image(systemName: "checkmark")
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        }

                        Text(amenity)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .frame(width: 80)
                    }
                    .padding(.trailing, 10)
                    .frame(width: 80)
                }
                Button(action: {
                    showFullAmenities = true
                }) {
                    VStack(spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 40, height: 30)

                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                                .font(.system(size: 14, weight: .bold))
                        }

                        Text("More")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .frame(width: 80)
                    }
                    .padding(.top, -3)
                    .frame(width: 80)
                }
            }
            .padding()
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 20)
        .background(Color.white)
        .sheet(isPresented: $showFullAmenities) {
            AmenitiesListView(categories: categories)
        }
    }
}


    private func iconName(for amenity: String) -> String {
        let lowercasedAmenity = amenity.lowercased()
        if lowercasedAmenity.contains("wifi") { return "wifi" }
        if lowercasedAmenity.contains("parking") { return "parkingsign.circle.fill" }
        if lowercasedAmenity.contains("swimming") { return "figure.pool.swim" }
        if lowercasedAmenity.contains("breakfast") { return "cup.and.saucer.fill" }
        if lowercasedAmenity.contains("airport") { return "airplane.circle.fill" }
        if lowercasedAmenity.contains("pet") { return "pawprint.fill" }
        if lowercasedAmenity.contains("eco") { return "leaf.fill" }
        if lowercasedAmenity.contains("bed") { return "bed.double.fill" }
        if lowercasedAmenity.contains("language") { return "globe" }
        if lowercasedAmenity.contains("service") { return "gear" }
        if lowercasedAmenity.contains("room") { return "door.left.hand.open" }
        return "questionmark.circle"
    }

