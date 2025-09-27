//
//  SRPHotelPage.swift
//
//

import SwiftUI

struct SRPHotelView: View {
    @StateObject var dataLoader = DataLoader()

    var body: some View {
        NavigationView {
            content
                .background(Color(.systemGroupedBackground))
                .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    @ViewBuilder
    private var content: some View {
        VStack(spacing: 0) {
            header
            filterScroll
            hotelList
            Spacer()
        }
    }
    
    private var header: some View {
        ZStack {
            VStack(spacing: 2) {
                Text("New Delhi")
                    .font(.headline)
                Text("Wed, 15 May to Thu, 16 May")
                    .font(.footnote)
                Text("1 Adult | 10 Hotels")
                    .font(.footnote)
            }
            HStack {
                searchButton
                Spacer()
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.clear)
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 16)
            }
        }
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 4)
                .edgesIgnoringSafeArea(.top)
        )
    }
    
    private var searchButton: some View {
        Button(action: { /* Search action */ }) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 40, height: 40)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .padding(.leading, 16)
    }
    
    private var filterScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                FilterBox(label: "Sort", ShowArrow: false, sortbutton: true)
                FilterBox(label: "Suggested", ShowArrow: true)
                FilterBox(label: "Rate Plans", ShowArrow: true)
                FilterBox(label: "Rating", ShowArrow: true)
                FilterBox(label: "Price", ShowArrow: true)
                FilterBox(label: "Location", ShowArrow: true)
                FilterBox(label: "Facilities", ShowArrow: true)
                FilterBox(label: "Filters", ShowArrow: false, filterbutton: true)
            }
            .padding(.horizontal)
            .padding(.top, 20)
            .padding(.bottom, 5)
        }
    }
    
    private var hotelList: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let _ = dataLoader.HotelSRP?.response?.searchResponse?.hotels.first?.imageUrl {
                    ForEach(dataLoader.hotels ?? [], id: \.hotelId) { hotel in
                        NavigationLink(destination: HotelDetailView()
                                        .environmentObject(dataLoader)
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true)
                        ) {
                            SRPCardView(hotel: hotel, dataloader3: dataLoader)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding()
        }
        .onAppear { dataLoader.loadHotelSRP() }
    }
}

struct FilterBox: View {
    var label: String
    var ShowArrow: Bool = false
    var filterbutton: Bool = false
    var sortbutton: Bool = false

    var body: some View {
        HStack(spacing: 4) {
            Text(label)
            if ShowArrow {
                Image(systemName: "chevron.down")
            }
            if filterbutton {
                Image(systemName: "slider.horizontal.3")
            }
            if sortbutton {
                Image(systemName: "arrow.up.arrow.down")
            }
        }
        .font(.subheadline)
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    SRPHotelView()
        .environmentObject(DataLoader())
}
