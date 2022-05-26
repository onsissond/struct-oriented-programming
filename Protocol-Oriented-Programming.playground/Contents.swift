protocol MyProtocol {
    var prop: String { get }
    func test(value: Int) -> String
}

class MyClass {}
extension MyClass: MyProtocol {
    var prop: String { "Hello" }
    func test(value: Int) -> String { "Test \(value)" }
}

func printProp(object: MyProtocol) {
    print(object.prop)
}

func printTest(object: MyProtocol, value: Int) {
    print(object.test(value: value))
}

let myClass = MyClass()
printProp(object: myClass)
printTest(object: myClass, value: 20)
