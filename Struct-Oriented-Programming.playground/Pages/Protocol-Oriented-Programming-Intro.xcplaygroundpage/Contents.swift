/*:
 # Protocol oriented programming
*/
import Foundation

struct CreatedOrderEvent {
    enum Category: String { case movie, podcast }
    var orderId: String
    var category: Category
}

struct RemovedOrderEvent {
    enum Resason: String { case notInterested, ad }
    var orderId: String
    var reason: Resason
}

struct MarkedFavoriteOrderEvent {
    var orderId: String
}










class FirebaseAnalytics {
    func logEvent(name: String, parameters: [String: Any]) {
        print("\(name) \(parameters)")
    }
}










/*:
 ### Protocol oriented way
*/
protocol FirebaseConvertable {
    var name: String { get }
    var parameters: [String: Any] { get }
}

extension FirebaseAnalytics {
    func logEvent(_ event: FirebaseConvertable) {
        logEvent(name: event.name, parameters: event.parameters)
    }
}















extension CreatedOrderEvent: FirebaseConvertable {
    var name: String { "CreatedOrder" }

    var parameters: [String: Any] {
        [
            "order_id": "\(orderId)",
            "order_category": category.rawValue
        ]
    }
}

extension RemovedOrderEvent: FirebaseConvertable {
    var name: String { "RemovedOrder" }

    var parameters: [String: Any] {
        [
            "order_id": "\(orderId)",
            "removed_reason": reason.rawValue
        ]
    }
}

extension MarkedFavoriteOrderEvent: FirebaseConvertable {
    var name: String { "MarkedFavoriteOrder" }

    var parameters: [String: Any] {
        [
            "order_id": "\(orderId)"
        ]
    }
}








let createdOrderEvent = CreatedOrderEvent(
    orderId: "666",
    category: .podcast
)
let removedOrderEvent = RemovedOrderEvent(
    orderId: "666",
    reason: .notInterested
)
let markedFavoriteOrderEvent = MarkedFavoriteOrderEvent(
    orderId: "666"
)


let firebaseAnalytics = FirebaseAnalytics()
firebaseAnalytics.logEvent(createdOrderEvent)
firebaseAnalytics.logEvent(removedOrderEvent)
firebaseAnalytics.logEvent(markedFavoriteOrderEvent)

//: [Next](Protocol-Oriented-Programming-Comparison)

