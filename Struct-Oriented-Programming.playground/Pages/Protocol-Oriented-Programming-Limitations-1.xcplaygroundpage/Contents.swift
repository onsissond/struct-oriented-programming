/*:
 # Protocol oriented programming limitations
 ## Can't extend protocol to conform another protocol
*/
import UIKit
/*:
 ### Protocol oriented way
*/
protocol JSONRepresentable {
    var json: String { get }
}

func printJSON(_ t: JSONRepresentable) {
    print(t.json)
}

/*
 Extension of protocol 'Encodable' cannot have an inheritance clause

 extension Encodable: JSONRepresentable {
    var json: String {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(self)
        return String(data: data, encoding: .utf8)!
    }
}
*/




/*:
 ### Struct oriented way
*/
struct JSONRepresenting<Target> {
    var json: (Target) -> String
}

extension JSONRepresenting where Target: Encodable {
    init() {
        self.init(json: { encodable in
            let encoder = JSONEncoder()
            let data = try! encoder.encode(encodable)
            return String(data: data, encoding: .utf8)!
        })
    }
}






struct User: Encodable {
    var name: String
    var age: Int
}

func printJSON<Target>(
    _ target: Target,
    formatter: JSONRepresenting<Target>
) {
    print(formatter.json(target))
}

let user = User(name: "Bob", age: 30)
printJSON(user, formatter: JSONRepresenting())



/*:
 ### JSON representing for the dictionary
*/
extension JSONRepresenting where Target == [AnyHashable: Any] {
    init() {
        self.init(json: { dictionary in
            let data = try! JSONSerialization.data(
                withJSONObject: dictionary,
                options: .fragmentsAllowed
            )
            return String(data: data, encoding: .utf8)!
        })
    }
}

let userInfo: [AnyHashable: Any] = [
    "banner": [
        "title": "hello",
        "subtitle": "world"
    ]
]

printJSON(userInfo, formatter: JSONRepresenting())

//: [Next](@next)



/*:
 ### Multiple conformance
*/
extension JSONRepresenting where Target: Encodable {
    static var unformatted: JSONRepresenting {
        JSONRepresenting { encodable in
            let encoder = JSONEncoder()
            let data = try! encoder.encode(encodable)
            return String(data: data, encoding: .utf8)!
        }
    }
    
    static var formatted: JSONRepresenting {
        JSONRepresenting { encodable in
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try! encoder.encode(encodable)
            return String(data: data, encoding: .utf8)!
        }
    }
}

printJSON(user, formatter: .formatted)


extension JSONRepresenting where Target == [AnyHashable: Any] {
    static var unformatted: JSONRepresenting {
        JSONRepresenting { dictionary in
            let data = try! JSONSerialization.data(
                withJSONObject: dictionary,
                options: .fragmentsAllowed
            )
            return String(data: data, encoding: .utf8)!
        }
    }

    static var formatted: JSONRepresenting {
        JSONRepresenting { dictionary in
            let data = try! JSONSerialization.data(
                withJSONObject: dictionary,
                options: .prettyPrinted
            )
            return String(data: data, encoding: .utf8)!
        }
    }
}

printJSON(userInfo, formatter: .formatted)


//: [Play with animations](Struct-Oriented-Programming-Usages)



