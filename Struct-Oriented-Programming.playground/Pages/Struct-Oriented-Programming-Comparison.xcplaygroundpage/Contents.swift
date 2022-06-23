import UIKit

struct GenericStruct1<Target> {
    var variable: (Target) -> String
}

extension GenericStruct1 where Target == URL {
    init() {
        self.init(
            variable: { url in url.absoluteString }
        )
    }
}

struct GenericStruct2<Target> {
    var getVariable: (Target) -> String
    var setVariable: (Target, _ variable: String) -> Void
}

struct GenericStruct3<Target> {
    var myFunc: (Target, _ double: Double, _ int: Int) -> String
}

struct GenericStruct4<Target> {
    var staticVar: () -> Double
}

extension GenericStruct4 where Target == URL {
    init() {
        self.init(
            staticVar: { 10 }
        )
    }
}

struct GenericStruct5<Target> {
    var staticFunc: (_ bool: Bool, _ int: Int) -> Void
}

struct GenericStruct6<Target> {
    var instance: (_ double: Double) -> Target
}

extension GenericStruct6 where Target == URL {
    init() {
        self.init(
            instance: { double in
                URL(string: "https://google.com/?a=\(double)")!
            }
        )
    }
}

struct GenericStruct7<Target, T> {
    var myFunc: (Target, _ t: T, _ int: Int) -> String
}

struct GenericStruct8<Target> {
    var genericStruct1: GenericStruct1<Target>
    var myFunc: (Target, _ double: Double, _ int: Int) -> String
}

extension GenericStruct8 where Target == URL {
    init() {
        let genericStruct1 = GenericStruct1<URL> { url in
            "variable value"
        }
        self.init(
            genericStruct1: genericStruct1,
            myFunc: { url, double, int in
                url.absoluteString
            }
        )
    }
}
