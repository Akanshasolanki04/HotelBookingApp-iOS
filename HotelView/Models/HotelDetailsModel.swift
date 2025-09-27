import Foundation

struct HotelServiceResponse: Codable {
    let response: HotelResponse?
}

struct HotelResponse: Codable {
    let hotelDetail: HotelDetail?
}


struct HotelDetail: Codable {
    let hotelId: String?
    let hotelName: String?
    let description: String?
    let rating : String?
    let address: HotelAddress?
    let longitude: String?
    let latitude: String?
    let landmarks: [Landmark]?
    let checkIn : String?
    let checkOut: String?
    let hotelImages : [HotelImage]?
    let amenitiesPopup: [String: [String]]?
    let roomTypes: [RoomType]?
    let reviews: [HotelReviews]?
    let hotelDeals: [HotelDeal]?
}


struct HotelAddress: Codable {
    let addressLine1: String?
    let area: String?
    let city: String?
    let country: String?
    let postalCode: String?
}

struct Landmark: Codable {
    let name: String?
    let distance: String?
}

struct HotelImage: Codable {
    let targetImageUrl: String?
}
struct RoomType: Codable, Identifiable {
    var id: String?
    let roomTypeId: String?
    let name: String?
    let sellingPrice: Int?
    let strikeOffPrice: Int?
    let totalRoomPrice: Int?
    let roomSize: String?
    let bedType: String?
    let roomImages: [String]?
    let roomAmenities: [String]?
    let inclusions: [String]?
    let cancellationPolicy: [String]?
//    let checkin : String?
//    let checkout : String?
   

}

struct HotelReviews: Codable {
    let reviewedBy: String?
    let reviewDateTime: String?
    let review: String?
    let reviewRating: Int?
}

struct HotelDeal: Codable {
    let dealTitle: String
    let dealDescription: String
    let validTill: String
}
