/*:
 ## The type can't have multiple protocol conformance
*/
import UIKit
/*:
 ### Protocol oriented way
*/
protocol DeeplinkProcessable {
    associatedtype Deeplink

    func process(deeplink: Deeplink) -> Bool
}

func handleDeeplink<Processor: DeeplinkProcessable>(
    _ deeplink: Processor.Deeplink,
    processor: Processor
) {
    let isProcessed = processor.process(deeplink: deeplink)
    print("Deeplink is processed: \(isProcessed)")
}





/*:
 ### Handle open order deeplink
*/
struct OpenOrderDeeplink {
    let orderId: Int
}

class OrderViewController: UIViewController {}
extension OrderViewController: DeeplinkProcessable {
    typealias Deeplink = OpenOrderDeeplink
    func process(deeplink: OpenOrderDeeplink) -> Bool {
        print("\nOrderVC opens OpenOrderDeeplink")
        return true
    }
}

let openOrderDeeplink = OpenOrderDeeplink(orderId: 10)
let vc = OrderViewController()
handleDeeplink(openOrderDeeplink, processor: vc)




/*:
 ### Handle open alert deeplink
*/
struct OpenAlertDeeplink {
    let title: String
}

/*
 Redundant conformance of 'OrderViewController' to protocol 'DeeplinkProcessable'

extension OrderViewController: DeeplinkProcessable {
    typealias Deeplink = OpenAlertDeeplink
    func process(deeplink: OpenAlertDeeplink) -> Bool {
        print("\nOrderVC opens OpenAlertDeeplink")
        return true
    }
}
*/




/*:
 ### Struct oriented way
*/
struct DeeplinkProcessing<Processor, Deeplink> {
    var process: (Processor, Deeplink) -> Bool
}

extension DeeplinkProcessing where Processor == OrderViewController, Deeplink == OpenOrderDeeplink {
    init() {
        self.init(process: { vc, deeplink in
            print("\nOrderVC opens OpenOrderDeeplink")
            return true
        })
    }
}






func handleDeeplink<Processor, Deeplink>(
    _ deeplink: Deeplink,
    processor: Processor,
    processing: DeeplinkProcessing<Processor, Deeplink>
) {
    let isProcessed = processing.process(processor, deeplink)
    print("Deeplink is processed: \(isProcessed)")
}

handleDeeplink(openOrderDeeplink, processor: vc, processing: DeeplinkProcessing())




/*:
 ### Multiple conformance
*/
extension DeeplinkProcessing where Processor == OrderViewController, Deeplink == OpenAlertDeeplink {
    init() {
        self.init(process: { vc, deeplink in
            print("\nOrderVC opens OpenAlertDeeplink")
            return true
        })
    }
}

let openAlertDeeplink = OpenAlertDeeplink(title: "Oooppsss...")
handleDeeplink(openAlertDeeplink, processor: vc, processing: DeeplinkProcessing())



extension DeeplinkProcessing where Processor == OrderViewController, Deeplink == OpenAlertDeeplink {
    static let bottomSheet = DeeplinkProcessing { vc, deeplink in
        print("\nOrderVC opens bottom sheet")
        return true
    }
    
    static let alert = DeeplinkProcessing { vc, deeplink in
        print("\nOrderVC opens alert")
        return true
    }
}

handleDeeplink(openAlertDeeplink, processor: vc, processing: .alert)
handleDeeplink(openAlertDeeplink, processor: vc, processing: .bottomSheet)




//: [Previous](@previous)
