//
//  HotelDetailView.swift
//

import SwiftUI
import Foundation

struct HotelDetailView: View {
    @StateObject var dataLoader = DataLoader()
    @State private var currentIndex: Int = 0
    @State private var showImageGrid = false
    @State private var showHeader = false
    @Environment(\.dismiss) private var dismiss
    @State private var selectedRoom: RoomType? = nil

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color(.systemGray6)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        GeometryReader { geo in
                            Color.clear
                                .onChange(of: geo.frame(in: .global).minY) { newValue in
                                    withAnimation(.easeInOut) {
                                        showHeader = newValue < -150
                                    }
                                }
                        }
                        .frame(height: 0)

                        // Hotel Images
                        if let hotelImages = dataLoader.HotelDetails?.hotelDetail?.hotelImages {
                            TabView(selection: $currentIndex) {
                                ForEach(hotelImages.indices, id: \.self) { index in
                                    let image = hotelImages[index]
                                    let imageName = image.targetImageUrl ?? ""

                                    if imageName.hasPrefix("http") {
                                        if let url = URL(string: imageName) {
                                            AsyncImage(url: url) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView().frame(height: 300)
                                                case .success(let loadedImage):
                                                    loadedImage
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(height: 300)
                                                        .frame(maxWidth: .infinity)
                                                        .clipped()
                                                        .onTapGesture{
                                                            showImageGrid = true
                                                        }
                                                case .failure:
                                                    Color.red.frame(height: 300)
                                                @unknown default:
                                                    Color.gray.frame(height: 300)
                                                }
                                            }
                                            .tag(index)
                                        }
                                    } else {
                                        Image(imageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 300)
                                            .frame(maxWidth: .infinity)
                                            .clipped()
                                            .tag(index)
                                            .onTapGesture{
                                                showImageGrid = true
                                            }
                                    }
                                }

                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                            .frame(height: 300)
                        }

                        if let hotel = dataLoader.HotelDetails?.hotelDetail {
                            VStack(spacing: 16) {
                                Details(hotelDetails: hotel)
                                    .padding(.horizontal, 25)
                                    .offset(y: -32)
                                    .zIndex(1)

                                AmenitiesPreviewRow(categories: hotel.amenitiesPopup ?? [:])
                                    .padding(.top, -40)
                                    .padding(.bottom, -8)

                                CheckIN(
//                                    checkInDate: hotel.checkIn ?? "",
//                                    checkOutDate: hotel.checkOut ?? ""
                                 //   checkInTime: hotel.checkInTime ?? "",
                                   // checkOutTime: hotel.checkOutTime ?? ""
                                    checkInDate: hotel.checkIn ?? "", checkOutDate: hotel.checkOut ?? ""
                                    
                                    
                                )
                                .padding(.bottom, -8)

                                Review()
                                    .padding(.bottom, -8)

                                NearbyLandmark(landmarks: hotel.landmarks ?? [])
                                    .padding(.bottom, -8)

                                if let latitude = Double(hotel.latitude ?? ""),
                                   let longitude = Double(hotel.longitude ?? "") {
                                    Map1(latitude: latitude, longitude: longitude)
                                        .padding(.bottom, -20)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, -80)
                }
                .safeAreaInset(edge: .bottom) {
                    bookingBar
                }

                // Sticky Header
                if showHeader, let hotel = dataLoader.HotelDetails?.hotelDetail {
                    HStack(spacing: 40) {
                        Button { dismiss() } label: {
                            Image(systemName: "chevron.left")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        VStack {
                            Text(hotel.hotelName ?? "")
                                .font(.headline)
                                .bold()
                            Text("Trip ID : 234284083")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 38)

                        Spacer()
                    }
                    .padding()
                    .padding(.horizontal, 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.95))
                    .shadow(radius: 4)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showImageGrid) {
                ImageGridView(
                    images: dataLoader.HotelDetails?.hotelDetail?.hotelImages ?? []
                )
            }
            .fullScreenCover(isPresented: Binding<Bool>(
                get: { selectedRoom != nil },
                set: { if !$0 { selectedRoom = nil } }
            )) {
                if let _ = selectedRoom {
                    RoomDetailsView()
                        .environmentObject(dataLoader)
                }
            }
            .onAppear { dataLoader.loadhoteldetails() }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // Booking Bar
    private var bookingBar: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                VStack(alignment: .leading) {
                    Text("Starting from")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text("\u{20B9} 18,762")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                Spacer()
                Button {
                    if let room = dataLoader.HotelDetails?.hotelDetail?.roomTypes?.first {
                        selectedRoom = room
                    }
                } label: {
                    Text("Select Room")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 140, height: 40)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding(.horizontal, 60)
            .padding(.vertical, 20)
            .background(Color.white)
        }
        .background(Color.white.shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -2))
    }
}

#Preview {
    HotelDetailView()
}
