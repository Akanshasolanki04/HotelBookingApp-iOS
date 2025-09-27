//
//  ImageGridView.swift
// 
//
//
//


import SwiftUI

struct ImageGridView: View {
    let images: [HotelImage]   
    @Environment(\.dismiss) private var dismiss

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(images.indices, id: \.self) { index in
                        let image = images[index]
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
                                .frame(width: 160 , height: 160)
                                .frame(maxWidth: .infinity)
                                .clipped()
                                .cornerRadius(8)
                               // .tag(index)
                        }
                    }

                }
                .padding(.horizontal, 12)
                .padding(.top, 16)
            }

            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                            .padding(16)
                    }
                }
                Spacer()
            }
        }
    }
}


//#Preview {
//    ImageGridView(images: [
//        Hotelimages(imageUrl: "", thumbUrl: nil, targetImageUrl: "https://via.placeholder.com/300"),
//        Hotelimages(imageUrl: "", thumbUrl: nil, targetImageUrl: "https://via.placeholder.com/300"),
//        Hotelimages(imageUrl: "", thumbUrl: nil, targetImageUrl: "https://via.placeholder.com/300"),
//        Hotelimages(imageUrl: "", thumbUrl: nil, targetImageUrl: "https://via.placeholder.com/300")
//    ])
//}
