
import Foundation

struct Response: Codable {
    let response: hotelResponse?
}

struct hotelResponse: Codable {
    let searchResponse: SearchResult?
}

struct SearchResult: Codable {
    let date: String?
    let noOfAdults: Int?
    let noOfHotels: Int?
    let hotels: [Hotel]
}

struct Hotel: Codable, Identifiable {
    let hotelId: String?
    let hotelName: String?
    let rating: String?
    let noOfRatings: Int?
    let noOfReviews: Int?
    let strikePrice: Int?
    let price: Int?
    let roomleft: String?
    let amenities: [String]?
    let savedOnBooking: Int?
    let imageUrl: String?
    let cityName: String?
    
    var id: String { hotelId ?? UUID().uuidString } 
}
