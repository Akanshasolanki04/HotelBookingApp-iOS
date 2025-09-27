////
////  Review.swift

////

////

import SwiftUI

struct Review: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Reviews")
                .font(.system(size: 25, weight: .semibold))
                .padding(.leading, 40)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<5, id: \.self) { _ in
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Name")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Spacer()
                                HStack(spacing: 2) {
                                    ForEach(0..<4, id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.black)
                                            .font(.caption)
                                    }
                                }
                            }

                            Text("Date and time")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            Text("Review - Description goes here. This is a short user review to display inside the card.")
                                .font(.body)
                                .lineLimit(4)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .frame(width: 280, height: 180)
                        .shadow(color: Color.black.opacity(0.4), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.leading, 40)
            }
        }
        .padding(.vertical, 24)
        .background(Color.white)
    }
}

#Preview {
    Review()
}
