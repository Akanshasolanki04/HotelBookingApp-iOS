//
//  RoomDetails.swift
//
import SwiftUI


struct RoomDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var dataLoader = DataLoader()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                HStack(alignment: .center) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .imageScale(.large)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 2) {
                        Text("Select Room")
                            .fontWeight(.semibold)
                        Text(dataLoader.HotelDetails?.hotelDetail?.hotelName ?? "")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    Image(systemName: "chevron.left")
                        .opacity(0)
                }
                .padding(.horizontal)
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 20)
                .padding(.bottom, 12)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 2, y: 2)
                ScrollView {
                    VStack(spacing: 20) {
                        if let roomTypes = dataLoader.HotelDetails?.hotelDetail?.roomTypes {
                            ForEach(roomTypes, id: \.roomTypeId) { room in
                                RoomCardView(room: room, dataLoader2: dataLoader)
                                    .padding(.horizontal)
                                    .background(Color.clear) 
                            }
                        } else {
                            ProgressView("Loading rooms...")
                        }
                    }
                    .padding(.top, 30)
                    .padding(.bottom)
                }
                .background(Color(.systemGroupedBackground))
            }
            .onAppear {
                dataLoader.loadhoteldetails()
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
        }
    }
}


#Preview {
    RoomDetailsView()
}
