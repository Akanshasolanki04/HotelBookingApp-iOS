//
//  Data Loader.swift
//
//

import SwiftUI

class DataLoader : ObservableObject {
    
    @Published var HotelDetails : HotelResponse?
    @Published var hotelReviewDetails: [HotelReview]?
    @Published var HotelSRP: Response?
    @Published var hotels: [Hotel]?
    
    @Published var isloading : Bool = false
    @Published  var errormessage : String?
    
    
    func loadhoteldetails(){
        guard let url = Bundle.main.url(forResource: "HotelDetails", withExtension: "json")
        else {
            errormessage = "File not found"
            return
        }
        isloading = true
        let decoder = JSONDecoder()
        do {
            
            let data = try Data(contentsOf: url)
            let response = try decoder.decode(HotelServiceResponse.self, from: data)
            self.HotelDetails = response.response
            print("HotelDetails: \(response)")
            
        }
        catch {
                errormessage = "Failed to decode JSON data : \(error.localizedDescription)"
                print("Error: \(error)")
            }
        isloading=false
        
    }
    
    func loadHotelReviewDetails() {
            guard let url = Bundle.main.url(forResource: "HotelReviews", withExtension: "json") else {
                errormessage = "HotelReviews.json file not found"
                return
            }
            
            isloading = true
        defer{isloading = false}
           
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let wrapper = try decoder.decode(ReviewResponseWrapper.self, from: data)
                self.hotelReviewDetails = wrapper.response?.reviewResponse?.reviews
                print("HotelReviews loaded successfully: \(self.hotelReviewDetails?.count) reviews")
            } catch {
//                errormessage = "Failed to decode HotelReviews.json: \(error.localizedDescription)"
//                print("Error loading HotelReviews: \(error.localizedDescription)")
                errormessage = "Failed to decode HotelReviews.json: \(error)"
                           print("Decoding error:", error)
            }
            
            isloading = false
        }
    
    func loadHotelSRP() {
        guard let url = Bundle.main.url(forResource: "HotelSRP", withExtension: "json") else {
            errormessage = "HotelSRP.json file not found"
            return
        }

        isloading = true
        defer { isloading = false }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let wrapper = try decoder.decode(Response.self, from: data)

            self.HotelSRP = wrapper
            self.hotels = wrapper.response?.searchResponse?.hotels ?? []

            print("SRPHotel loaded successfully: \(self.hotels) hotels")
        } catch {
            self.errormessage = "Failed to decode JSON: \(error)"
            print("Error decoding JSON: \(error)")
        }

        isloading = false
    }

}


