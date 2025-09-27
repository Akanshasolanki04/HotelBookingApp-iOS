//
//  AmenitiesListView.swift
//
//
//

import SwiftUI

struct AmenitiesListView: View {
    let categories: [String : [String]]

    var body: some View {
        NavigationView {
            List {
                ForEach(Array(categories.keys), id: \.self) { key in
                    if let values = categories[key] {
                        Section(header: Text(key).font(.headline)) {
                            ForEach(values, id: \.self) { amenity in
                                HStack(spacing: 16) {
                                    Image(systemName: iconName(for: amenity))
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.blue)

                                    Text(amenity)
                                        .font(.body)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
            }
            .navigationTitle("All Amenities")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func iconName(for amenity: String) -> String {
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
        return "checkmark.circle"
    }
}

