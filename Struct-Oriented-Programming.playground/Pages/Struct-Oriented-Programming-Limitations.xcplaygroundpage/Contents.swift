/*:
 # Struct oriented programming: limitations
 ## Can't use named parameters
*/

/*
struct GenericStruct<Target> {
    var myFunc: (Target, _ t: Double, _ params: Int) -> String
    var myFunc: (Target, Double, Int) -> String
}
*/










/*:
 ## Can't implement generic func
*/

protocol MyProtocol {
    func myFunc<T>(t: T) -> String
}

/*
struct MyStruct<Target> {
    var myFunc<T>: ???
}
*/







/*:
 ## Can't facilitate polymorphism
*/

struct Event {
    let name: String
}
class AnalyticManager1 {
    func logEvent(_ event: Event) {}
}
class AnalyticManager2 {
    func logEvent(_ event: Event) {}
}


protocol AnalyticManager {
    func logEvent(_ event: Event)
}
extension AnalyticManager1: AnalyticManager {}
extension AnalyticManager2: AnalyticManager {}

let managers: [AnalyticManager] = [
    AnalyticManager1(),
    AnalyticManager2()
]





struct AnalyticManaging<Manager> {
    var logEvent: (Event) -> Void
}
extension AnalyticManaging where Manager == AnalyticManager1 {
    init(manager: AnalyticManager1) {
        self.init(logEvent: { event in
            manager.logEvent(event)
        })
    }
}
extension AnalyticManaging where Manager == AnalyticManager2 {
    init(manager: AnalyticManager2) {
        self.init(logEvent: { event in
            manager.logEvent(event)
        })
    }
}

let manager1 = AnalyticManaging(manager: AnalyticManager1())
let manager2 = AnalyticManaging(manager: AnalyticManager2())
manager1.logEvent(Event(name: ""))
manager2.logEvent(Event(name: ""))
/*
let managers: [AnalyticManaging<???>] = [
    manager1,
    manager2
]
*/

func logEvent<T>(
    _ event: Event,
    with manager: AnalyticManaging<T>
) {
    manager.logEvent(event)
}
logEvent(Event(name: "Hey!"), with: manager1)
logEvent(Event(name: "Hey!"), with: manager2)

//: [Next](@next)
