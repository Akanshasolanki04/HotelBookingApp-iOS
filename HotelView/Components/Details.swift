//
//  Details.swift
//  
//
//
//

import SwiftUI

struct Details: View {
    let hotelDetails: HotelDetail

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(hotelDetails.hotelName ?? "Hotel Name")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            HStack(spacing: 5) {
                let rating = Int(hotelDetails.rating ?? "0") ?? 0
                ForEach(0..<rating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            .padding(.bottom)
            VStack(alignment: .leading, spacing: 0) {
                Text(hotelDetails.address?.area ?? "")
                Text(hotelDetails.address?.city ?? "")
                Text(hotelDetails.address?.addressLine1 ?? "")
                    .foregroundColor(.gray)
            }
        }
        .padding(.all, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}


//struct Details_Preview: PreviewProvider {
//    static var previews: some View {
//        let sampleAddress = Address(
//            area: "Indiranagar",
//            city: "Bangalore",
//            addressLine1: "123, Example Street"
//        )
//        
//        let sampleHotel = HotelDetails(
//            name: "The Park Bangalore",
//            yatraSmartAmenities: "WiFi, Pool",
//            latitude: "12.9716",
//            longitude: "77.5946",
//            description: "A luxurious stay in the heart of the city.",
//            landmarks: [],
//            ecoPlus: true,
//            amenitiesPopup: [],
//            checkInDate: "2025-04-24",
//            isYatraSmart: true,
//            checkOutDate: "2025-04-25",
//            roomTypes: [],
//            hotelimages: [],
//            address: sampleAddress,
//            hotelAmenities: ["Free WiFi", "Swimming Pool", "Spa"],
//            checkInTime: "12:00 PM",
//            checkOutTime: "11:00 AM",
//            hotelId: "HTL1234"
//        )
//
//        return Details(hotelDetails: sampleHotel)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
