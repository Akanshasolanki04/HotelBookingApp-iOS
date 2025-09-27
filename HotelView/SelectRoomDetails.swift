//
//  SelectRoomDetails.swift
//  YatraHotelView
//
//  Created by Vijay B. Singh on 30/04/25.
//

import SwiftUI

struct SelectRoomDetails: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var dataLoader = DataLoader()
    
    var room: RoomType
    
    init(room: RoomType) {
        self.room = room
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .imageScale(.large)
                }
                
                Spacer()
                
                VStack(spacing: 2) {
                    Text("Details")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                    Text(room.name ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom)
                
                Spacer()
                
                Image(systemName: "chevron.left")
                    .opacity(0)
            }
            .padding(.horizontal)
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 20)
            .padding(.bottom, 12)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 2, y: 2)
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Inclusions")
                            .font(.headline)
                            .padding(.leading, 16)
                        
                        if !(room.inclusions?.isEmpty ?? false) {
                            ForEach(room.inclusions?.prefix(10) ?? [], id: \.self) { inclusion in
                                HStack(spacing: 8) {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                    Text(inclusion)
                                        .font(.subheadline)
                                }
                                .padding(.leading, 16)
                            }
                        } else {
                            Text("No inclusions available")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding(.leading, 16)
                        }
                    }
                    
                    Divider()
                    
                  
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Room Amenities")
                            .font(.headline)
                            .padding(.leading, 16)
                        
                        if (room.roomAmenities?.isEmpty ?? false) {
                            ForEach(room.roomAmenities?.prefix(12) ?? [], id: \.self) { amenity in
                                HStack(spacing: 8) {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                    Text(amenity)
                                        .font(.subheadline)
                                }
                                .padding(.leading, 16)
                            }
                        }
                                     else {
                            Text("No amenities available")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding(.leading, 16)
                        }
                    }
                    
                    Divider()
                    
                 
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Policies")
                            .font(.headline)
                            .padding(.leading, 16)
//                        
//                        Text("Check-in: \(room.checkin ?? "2:00 PM")")
//                            .font(.subheadline)
//                            .padding(.leading, 16)
//                        Text("Check-out: \(room.checkout ?? "11:00 AM")")
//                            .font(.subheadline)
//                            .padding(.leading, 16)
                    }
                }
                .padding(.top, 20)
            }
            .background(Color(.systemGroupedBackground))
        }
        .background(Color(.systemGroupedBackground))
        .padding(.top, 10)
        .onAppear {
            dataLoader.loadhoteldetails()
        }
    }
}




//#Preview {
//    SelectRoomDetails(room: RoomType(freeCancel: true, isAgency: false, eCashInfo: ECashInfo(ecashDiscount: 100, earnECash: 50, message: "Test message"), onRequest: false, ratePlanId: "123", loadedCurrencyCode: "INR", loadedTotalAmount: 10000, roomTypeId: "1", breakPolicy: false, sellingPrice: 5000, strikeOffPrice: "6000", roomSize: "35 sq.m", supplier: "Yatra", freeCancelDeadLine: "24 hrs", offers: ["Discount"], intechCode: "XYZ", roomDesc: "Deluxe room with all amenities", roomAmenities: [RoomAmenity(code: "1", price: "100", name: "Wi-Fi", category: "Basic")], guaranteeType: "None", roomsLeft: 5, name: "Deluxe Room", totalRoomPrice: 5000, roomImages: [RoomImage(code: "1", caption: "Room 1", thumburl: "https://example.com/image.jpg", url: "https://example.com/image.jpg")], currencyCode: "INR", cancellationPolicy: ["Free cancellation within 24 hours"], inclusions: ["Breakfast", "Wi-Fi"], bedType: "King Bed"))
//}
