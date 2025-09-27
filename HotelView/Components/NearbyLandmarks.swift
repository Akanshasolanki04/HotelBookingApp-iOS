//
//  NearbyLandmark.swift
// 
//



import SwiftUI

struct NearbyLandmark: View {
    let landmarks: [Landmark]
    @State private var showAllLandmarks = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Nearby Landmark")
                .font(.system(size: 25, weight: .semibold))
                .padding(.vertical, 24)

            ForEach(showAllLandmarks ? landmarks : Array(landmarks.prefix(4)), id: \.name) { landmark in
                HStack {
                    Text(landmark.name ?? "")
                    Spacer()
                    Text(landmark.distance ?? "")
                }
                Divider()
                    .transition(.move(edge: .bottom))
            }

            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showAllLandmarks.toggle()
                }
            }) {
                Text(showAllLandmarks ? "Show Less" : "Read More")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            .padding(.top, 10)
        }
        .padding(.horizontal, 40) 
        .padding(.vertical)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .frame(maxWidth: .infinity)
    }
}
//#Preview {
//NearbyLandmark(landmarks: [
//Landmark(distance: "2 km", name: "location1"),
//Landmark(distance: "3 km", name: "location2"),
//Landmark(distance: "4 km", name: "location3"),
//Landmark(distance: "5 km", name: "location4")
//                        ])
//                    }
