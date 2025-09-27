//
//  DetailPolicy.swift
//

import SwiftUI

struct DetailPolicy: View {
    let cancellationPolicy: [String]   
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Policy")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.top, 0)

            if cancellationPolicy.isEmpty {
                Text("No cancellation policy available")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(cancellationPolicy, id: \.self) { policy in
                        HStack(alignment: .top, spacing: 14) {
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(.black)
                                .padding(.top, 6)

                            Text(policy)
                                .font(.system(size: 17))
                                .foregroundColor(.primary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
        .padding()
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal, -10)
    }
}


//#Preview {
//    DetailPolicy()
//}
