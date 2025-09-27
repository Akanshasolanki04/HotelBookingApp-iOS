//
//  Map.swift

//
//
//

import SwiftUI
import MapKit

struct Location: Identifiable, Equatable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D

    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.coordinate.latitude == rhs.coordinate.latitude &&
        lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}

struct Map1: View {
    var latitude: Double
    var longitude: Double
    
    @State private var region: MKCoordinateRegion
    @State private var hotelLocation: Location

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
        
        _hotelLocation = State(initialValue: Location(coordinate: coordinate))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack(alignment: .topTrailing) {
                Map(coordinateRegion: $region, annotationItems: [hotelLocation]) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack(spacing: 0) {
                            Image(systemName: "building.2.crop.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                                .background(
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 50, height: 50)
                                        .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 3)
                                )
                            
                            Text("Hotel")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(
                                    Capsule()
                                        .fill(Color.white)
                                        .shadow(radius: 2)
                                )
                                .offset(y: -5)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 48, height: 200) 
                .clipShape(RoundedRectangle(cornerRadius: 30))

                VStack(spacing: 12) {
                    Button(action: {
                        withAnimation {
                            region.span.latitudeDelta /= 2
                            region.span.longitudeDelta /= 2
                        }
                    }) {
                        Image(systemName: "plus.magnifyingglass")
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    
                    Button(action: {
                        withAnimation {
                            region.span.latitudeDelta *= 2
                            region.span.longitudeDelta *= 2
                        }
                    }) {
                        Image(systemName: "minus.magnifyingglass")
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                }
                .padding(16)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 30)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
