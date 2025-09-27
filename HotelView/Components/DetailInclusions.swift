//
//  DetailInclusions.swift
//
//  
import SwiftUI

struct DetailInclusions: View {
    @StateObject private var dataLoader = DataLoader()
    @State private var showAll = false
    @State private var inclusions: [String] = []

    var displayedInclusions: [String] {
        showAll ? inclusions : Array(inclusions.prefix(8))
    }

    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 16) {
                Text("Inclusions")
                    .font(.system(size: 30))
                    .padding(.top)
                
                Text("Popular with Guests")
                    .foregroundColor(Color(UIColor.darkGray))
                    .font(.subheadline)
                    .padding(.top, -15)
                    .padding(.bottom, 12)
                
                VStack(alignment: .leading, spacing: 14) {
                    ForEach(displayedInclusions, id: \.self) { inclusion in
                        HStack(spacing: 14) {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.gray)
                            Text(inclusion)
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                Button(action: {
                    withAnimation {
                        showAll.toggle()
                    }
                }) {
                    Text(showAll ? "View Less" : "View Details")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                .padding(.top)
            }
            .padding()
            .frame(width: 410, alignment: .leading)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            .onAppear {
                dataLoader.loadhoteldetails()
            }
            .onReceive(dataLoader.$HotelDetails) { hotelResponse in
                if let hotel = hotelResponse?.hotelDetail,
                   let firstRoom = hotel.roomTypes?.first {
                    self.inclusions = firstRoom.inclusions ?? []
                }
            }
        }
    }
}

#Preview {
    DetailInclusions()
}
