//
//  RoomDetail2.swift
//
//

import SwiftUI

struct RoomDetail2: View {
    var room: RoomType

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ImageAndInclusionsCardView(room: room)
                PolicyCardView(policies: room.cancellationPolicy ?? [])
            }
            .padding(.top)
            .padding(.horizontal)    // Outer padding
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Room Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ImageAndInclusionsCardView: View {
    let room: RoomType
    @State private var showAllInclusions = false

    var displayedInclusions: [String] {
        showAllInclusions ? (room.inclusions ?? []) : Array(room.inclusions?.prefix(8) ?? [])
    }


    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Full-width image (from first string URL in roomImages)
            if let urlString = room.roomImages?.first,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                    @unknown default:
                        EmptyView()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                    }
                }
                .cornerRadius(12)
            }

            Text(room.name ?? "")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 16) {
                Label(room.bedType ?? "", systemImage: "bed.double.fill")
                Label(room.roomSize ?? "", systemImage: "square.grid.2x2.fill")
            }
            .font(.subheadline)
            .foregroundColor(.gray)

            Divider()

            Text("Inclusions")
                .font(.title2)
                .fontWeight(.semibold)

            if displayedInclusions.isEmpty {
                Text("No inclusions available.")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(displayedInclusions, id: \.self) { inc in
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(white: 0.75))
                            Text(inc)
                                .font(.subheadline)
                        }
                    }
                    if room.inclusions?.count ?? 0 > 8 && showAllInclusions ?? false{
                        Button("View All") {
                            withAnimation { showAllInclusions = true }
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct PolicyCardView: View {
    let policies: [String]

    var body: some View {
        VStack(spacing: 0) {
            Text("Cancellation Policy")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color.blue)

            VStack(alignment: .leading, spacing: 12) {
                if policies.isEmpty {
                    Text("No cancellation policy provided.")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                } else {
                    ForEach(policies, id: \.self) { policy in
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                            Text(policy)
                                .font(.subheadline)
                        }
                    }
                }
                if policies.count > 3 {
                    Button("View All") { }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color(.systemGray6))
        }
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

//#Preview {
//    let sampleRoom = RoomType(
//        freeCancel: true,
//        isAgency: false,
//        eCashInfo: ECashInfo(ecashDiscount: 0, earnECash: 0, message: ""),
//        onRequest: false,
//        ratePlanId: "",
//        loadedCurrencyCode: "INR",
//        loadedTotalAmount: 1000,
//        roomTypeId: "",
//        breakPolicy: false,
//        sellingPrice: 1200,
//        strikeOffPrice: "",
//        roomSize: "25m²",
//        supplier: "",
//        freeCancelDeadLine: "",
//        offers: [],
//        intechCode: "",
//        roomDesc: "",
//        roomAmenities: [
//            RoomAmenity(code: "wifi", price: "", name: "Free WiFi", category: "")
//        ],
//        guaranteeType: "",
//        roomsLeft: 2,
//        name: "Deluxe Room",
//        totalRoomPrice: 1200,
//        roomImages: [
//            RoomImage(code: "", caption: nil, thumburl: "", url: "https://placekitten.com/400/200")
//        ],
//        currencyCode: "INR",
//        cancellationPolicy: [
//            "Cancel up to 24 hours before check-in",
//            "50% charge within 24 hours"
//        ],
//        inclusions: ["Breakfast", "Shuttle", "Pool Access", "Gym Access"],
//        bedType: "King Bed"
//    )
//    RoomDetail2(room: sampleRoom)
//}
