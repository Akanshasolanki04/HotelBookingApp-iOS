//
//  ChangingDates.swift
//
//

import SwiftUI

struct CheckIN: View {
    let checkInDate : String
    let checkOutDate : String
    var body: some View {
        ZStack {

            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text("Check -In")
                    Text(checkInDate)
                        .foregroundColor(.blue)
                }
                  
                Spacer()
                VStack(alignment: .leading, spacing: 10){
                    Text("Check -In")
                    Text(checkInDate)
                        .foregroundColor(.blue)
                }
                
            }
            
            .font(.title2)
            .fontWeight(.semibold)
            .padding()
            .padding(.horizontal,20)
            .background(Color.white)
            
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
           
           
        }
    }
}
#Preview {
    CheckIN(checkInDate: "23-09-25" , checkOutDate: "22-09-25")
}
