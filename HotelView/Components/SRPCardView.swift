//
//  SRPCardView.swift

//

import SwiftUI

struct SRPCardView: View {
    let hotel: Hotel
    let dataloader3 : DataLoader
    var body: some View {
        VStack(spacing: 0) {
            hotelImage
                .frame(height: 150)
                
            
            VStack(alignment: .leading, spacing: 12) {
                ratingSection
                hotelInfoAndPrice
                
                if let amenities = hotel.amenities, !amenities.isEmpty {
                    amenitiesSection
                }
                
                if let saved = hotel.savedOnBooking {
                    savingsBanner(saved)
                }
            }
            .padding()
            .background(Color.white)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray3), lineWidth: 0.5)
        )
        //.padding(.horizontal,20)
    }
}

extension SRPCardView {
    
    private var hotelImage: some View {
        if let urlString = hotel.imageUrl, let url = URL(string: urlString) {
            return AnyView(
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            )
        } else {
            return AnyView(
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 150)
            )
        }
    }
    
    private var ratingSection: some View {
        HStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: 40, height: 30)
                
                Text(hotel.rating ?? "0")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
            }
            
            Text("(\(hotel.noOfReviews ?? 0) reviews)")
                .font(.system(size: 15))
                .foregroundColor(.black)
        }
    }
    
    private var hotelInfoAndPrice: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(hotel.hotelName ?? "Hotel Name")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                HStack(spacing: 2) {
                    let starCount = Int(Double(hotel.rating ?? "0") ?? 0.0)
                    ForEach(0..<min(starCount, 5), id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.yellow)
                    }
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                if let strike = hotel.strikePrice {
                    Text("₹\(strike)")
                        .strikethrough()
                        .foregroundColor(.gray)
                }
                
                Text("₹\(hotel.price ?? 0)")
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                
                Text("Price for 2 nights")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                let roomsLeft = Int(hotel.roomleft ?? "0") ?? 0
                if roomsLeft > 0 {
                    Text("\(roomsLeft) Rooms left!")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    private var amenitiesSection: some View {
        let amenities = Array(hotel.amenities ?? [])
        let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 15),
            GridItem(.flexible(), spacing: 15)
        ]
        
        return LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
            ForEach(amenities, id: \.self) { amenity in
                Label(amenity, systemImage: "checkmark.circle")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
    
    private func savingsBanner(_ amount: Int) -> some View {
        Text("🎉 Saved ₹\(amount)!")
            .font(.subheadline)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.green.opacity(0.1))
            .cornerRadius(10)
    }
}


//#Preview {
//    SRPCardView(hotel: SearchResult(
//        freeCancel: true,
//        isAgency: false,
//        bookable: true,
//        isAvailable: true,
//        hid: "1",
//        eCashInfo: ECashInfoModel(maxEcashBurn: 200, earnECash: 50, message: "₹50 saved on this booking!"),
//        startingPriceMessage: "Starting from ₹2000",
//        displayName: "Hotel Example",
//        ratePlanId: "rp1",
//        discount: 20,
//        ecoPlus: false,
//        hotelsWith: [],
//        reviewRating: "1546",
//        roomTypeId: "rt1",
//        breakPolicy: true,
//        isYatraSmart: false,
//        googleReviews: "Very Good",
//        strikeOffPrice: 2500,
//        displayPrice: 1999,
//        supplier: [],
//        rank: 1,
//        theme: [],
//        isAgencyFlow: false,
//        isFeatured: false,
//        landmark: GeoPoint(a: "Address", c: "City", lo: 77.0, la: 28.0, z: "Zip"),
//        starRating: 4,
//        comfortRating: 3,
//        isYtg: true,
//        yatraSelectRating: 4,
//        image: HotelImage(url: "https://images.pexels.com/photos/271624/pexels-photo-271624.jpeg"),
//        googleRating: "4.2",
//        hotelAmenities: ["Free WiFi", "Breakfast Included"],
//        hotelId: "H123",
//        name: "Mock Hotel",
//        womenFriendly: true,
//        guaranteeType: ["Full Refund"],
//        safetyAssured: true,
//        location: GeoPoint(a: "Address", c: "City", lo: 77.0, la: 28.0, z: "Zip"),
//        category: ["Luxury"],
//        currencyCode: "INR"
//    ), dataLoader3: DataLoader())
//   
//}

