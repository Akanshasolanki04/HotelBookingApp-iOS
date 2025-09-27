//
//  RoomCardView.swift

//

//


import SwiftUI

struct RoomCardView: View {
    let room: RoomType
    let dataLoader2: DataLoader
    @State private var navigateToDetail = false
    @State private var navigateToReview = false

    var body: some View {
        VStack(spacing: 0) {
            // Main image
            Button(action: { navigateToDetail = true }) {
                if let imageNames = room.roomImages, !imageNames.isEmpty {
                    TabView {
                        ForEach(imageNames, id: \.self) { imageName in
                            if imageName.hasPrefix("http"),
                               let url = URL(string: imageName) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(height: 230)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 230)
                                            .clipped()
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 230)
                                            .clipped()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            } else {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 230)
                                    .clipped()
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 230)
                } else {
                    Image("roomimage1")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 230)
                        .clipped()
                }
            }
            .buttonStyle(PlainButtonStyle())
            VStack(alignment: .leading, spacing: 8) {
                Text(room.name ?? "")
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .padding(.top, 16)
                    .padding(.leading, 16)

                HStack(spacing: 12) {
                    Label(room.bedType ?? "", systemImage: "bed.double.fill")
                        .foregroundColor(.gray)
                        .font(.footnote)

                    Label(room.roomSize ?? "", systemImage: "square.grid.2x2.fill")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)

                Divider()
                    .padding(.top, 8)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Facilities")
                        .font(.headline)
                        .padding(.leading, 16)
                        .padding(.top)
                        .padding(.bottom)

                    ForEach(room.roomAmenities?.prefix(4) ?? [], id: \.self) { amenity in
                        HStack(spacing: 8) {
                            Circle()
                                .frame(width: 6, height: 6)
                            Text(amenity)
                                .font(.subheadline)
                        }
                        .padding(.leading, 16)
                    }

                    Button(action: { navigateToDetail = true }) {
                        Text("View all details")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                    }
                    .padding(.bottom , 15)
                    .padding(.leading, 16)
                }

                Divider()
                HStack {
                    VStack(alignment: .leading) {
                        Text("₹ \(room.sellingPrice ?? 0)")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Inc. of all taxes")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .offset(y: -5)
                    .padding(.leading, 16)

                    Spacer()

                    Button {
                        navigateToReview = true
                    } label: {
                        Text("Book Now")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                            .frame(width: 130, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                    .offset(y: -5)
                    .padding(.trailing, 16)
                }
                .padding(.vertical, 28)
            }
        }
        .frame(width: 370)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.systemGray3), lineWidth: 2)
        )
        NavigationLink(destination: RoomDetail2(room: room), isActive: $navigateToDetail) {
            EmptyView()
        }
        .hidden()

        NavigationLink(destination: HotelReviewPage(room: room, dataLoader2: dataLoader2), isActive: $navigateToReview) {
            EmptyView()
        }
        .hidden()
    }
}
