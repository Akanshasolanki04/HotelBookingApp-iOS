//
//  HotelReviewPage.swift
//
//

import SwiftUI

struct HotelReviewPage: View {
    let room: RoomType
    @State private var promoCode: String = ""
    @ObservedObject var dataLoader2: DataLoader
    @Environment(\.dismiss) private var dismiss
    // Use the first review from array
    private var reviewData: HotelReview? {
        dataLoader2.hotelReviewDetails?.first
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollView {
                hotelInfoSection
                stayDetailsSection
                roomDetailsSection
                promoCodeSection
                fareDetailsSection
            }
            .padding(.vertical)
            bookingFooter
        }
        .onAppear {
            dataLoader2.loadHotelReviewDetails()
        }
        .navigationBarBackButtonHidden(true)
    }

    private var header: some View {
        HStack(spacing: 90) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .foregroundColor(.blue)
                    .padding(.vertical, 4)
            }
            VStack(spacing: 1) {
                Text("Review Hotel Details")
                    .fontWeight(.semibold)
                Text("Trip ID: 234284083")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
    }

    private var hotelInfoSection: some View {
        Group {
            if let review = reviewData {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            Text(review.hotelName ?? "")
                                .font(.headline)
                                .lineLimit(2)
                                 
                            ForEach(0..<4, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.black)
                                    .font(.caption)
                            }
                        }
                        .padding(.bottom,20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Image("Listing-5")
                            .resizable()
                            .frame(width: 100, height: 80)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
            } else {
                Text("Loading hotel review...")
                    .font(.title3)
                    .padding()
            }
        }
    }

    private var stayDetailsSection: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Check-in").fontWeight(.semibold)
                    Text(reviewData?.checkIn ?? "")
                        .font(.subheadline)
                }
                Spacer()
                Text("\(reviewData?.noOfNights ?? "0") nights")
                    .font(.subheadline).bold()
                Spacer()
                VStack(alignment: .leading) {
                    Text("Check-out").fontWeight(.semibold)
                    Text(reviewData?.checkOut ?? "")
                        .font(.subheadline)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
        }
        .padding(.top,20)
        .padding(.horizontal)
        .padding(.bottom, 20)
    }

    private var roomDetailsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(room.name ?? "")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "bed.double.fill")
                            Text(room.bedType ?? "")
                        }
                        HStack {
                            Image(systemName: "ruler.fill")
                            Text("\(room.roomSize)")
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.black)
                }

                Spacer()

                Image("Listing-5")
                    .resizable()
                    .frame(width: 100, height: 90)
                    .cornerRadius(8)
                    .padding(.top, 0)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(reviewData?.roomPolicies ?? [], id: \.self) { policy in
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.orange)
                            .padding(.top, 2)
                        Text(policy)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .padding(.top,10)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }

    private var promoCodeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Promo Code")
                .font(.system(size: 20, weight: .semibold))
                .padding(.top , -20)
                .padding(.bottom , 10)
                .foregroundColor(.black)
            
            HStack {
                TextField("Enter code", text: $promoCode)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .font(.subheadline)
                
                Button("Apply") { }
                    .font(.subheadline)
                    .padding(8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding(.top,15)
        .padding(.all,5)
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.4)))
        .padding(.horizontal)
        .padding(.bottom)
    }

    private var fareDetailsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Fare Details").font(.headline)

            if let fare = reviewData?.fareBreakup {
                HStack {
                    Text("Room Fare")
                    Spacer()
                    Text("₹\(fare.roomFare ?? "0")")
                }
                HStack {
                    Text("Taxes")
                    Spacer()
                    Text("₹\(fare.taxes ?? "0")")
                }
                Divider()
                HStack {
                    Text("Total")
                        .bold()
                    Spacer()
                    Text("₹\(fare.totalFare ?? "0")")
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }

    private var bookingFooter: some View {
        VStack {
            Divider()
            HStack {
                VStack(alignment: .leading) {
                    Text("₹\(reviewData?.fareBreakup?.totalFare ?? "0")")
                        .font(.title3)
                        .bold()
                    Text("Total for \(reviewData?.noOfNights ?? "0") nights")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .offset(y: 14)
                .padding(.horizontal)
                Spacer()
                Button("Continue") { }
                    .fontWeight(.semibold)
                    .padding()
                    .frame(height:40)
                    .frame(minWidth: 120)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.bottom, -30)
                    .padding(.horizontal, 10)
            }
            .offset(y:-10)
            .padding()
            .background(Color(.systemBackground))
            .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: -2)
        }
    }
}
