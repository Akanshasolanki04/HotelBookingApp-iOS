
import Foundation

struct ReviewResponseWrapper: Codable {
    let response: ReviewResponseContainer?
}

struct ReviewResponseContainer: Codable {
    let reviewResponse: ReviewData?
}

struct ReviewData: Codable {
    let reviews: [HotelReview]
}

struct HotelReview: Codable, Identifiable {
    let hotelName: String?
    let noOfRatings: String?
    let checkIn: String?
    let checkOut: String?
    let noOfNights: String?
    let roomType: String?
    let bedType: String?
    let roomSize: String?
    let roomPolicies: [String]?
    let fareBreakup: FareBreakup?

    var id: String { hotelName ?? UUID().uuidString }
}
struct FareBreakup: Codable {
    let roomFare: String?
    let taxes: String?
    let totalFare: String?
}
