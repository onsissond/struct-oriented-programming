/*:
 # Struct oriented programming
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
 ### Struct oriented way
*/
struct FirebaseConverting<Event> {
    var name: (Event) -> String
    var parameters: (Event) -> [String: Any]
}

extension FirebaseAnalytics {
    func logEvent<Event>(
        _ event: Event,
        _ converting: FirebaseConverting<Event>
    ) {
        logEvent(
            name: converting.name(event),
            parameters: converting.parameters(event)
        )
    }
}











extension FirebaseConverting where Event == CreatedOrderEvent {
    init() {
        self.init(
            name: { event in "CreatedOrder" },
            parameters: { event in
                [
                    "order_id": "\(event.orderId)",
                    "order_category": event.category.rawValue
                ]
            }
        )
    }
}

extension FirebaseConverting where Event == RemovedOrderEvent {
    init() {
        self.init(
            name: { event in "RemovedOrder" },
            parameters: { event in
                [
                    "order_id": "\(event.orderId)",
                    "removed_reason": event.reason.rawValue
                ]
            }
        )
    }
}

extension FirebaseConverting where Event == MarkedFavoriteOrderEvent {
    init() {
        self.init(
            name: { event in "MarkedFavoriteOrderEvent" },
            parameters: { event in
                [
                    "order_id": "\(event.orderId)"
                ]
            }
        )
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
firebaseAnalytics.logEvent(createdOrderEvent, FirebaseConverting())
firebaseAnalytics.logEvent(removedOrderEvent, FirebaseConverting())
firebaseAnalytics.logEvent(markedFavoriteOrderEvent, FirebaseConverting())





//: [Next](@next)
