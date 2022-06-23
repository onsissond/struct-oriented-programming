import UIKit

protocol StandardProtocol1 {
    var variable: String { get }
}

protocol StandardProtocol2 {
    var variable: String { get set }
}

protocol StandardProtocol3 {
    func myFunc(double: Double, int: Int) -> String
}

protocol StandardProtocol4 {
    static var staticVar: Double { get }
}

protocol StandardProtocol5 {
    static func staticFunc(bool: Bool, int: Int)
}

protocol StandardProtocol6 {
    init(double: Double)
}

protocol StandardProtocol7 {
    associatedtype T
    func myFunc(t: T, int: Int) -> String
}

protocol StandardProtocol8: StandardProtocol1 {
    func myFunc(double: Double, int: Int) -> String
}

//: [Next](Protocol-Oriented-Programming-Limitations-1)
