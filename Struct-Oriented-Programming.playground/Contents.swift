struct MyStruct<A> {
    var prop: (A) -> String
    var test: (A, Int) -> String
}

class MyClass {}
extension MyStruct where A == MyClass {
    static let emptyString = MyStruct(
        prop: { myClass in "Hello" },
        test: { myClass, value in "Test \(value)" })
}

func printProp<T>(object: T, myStruct: MyStruct<T>) {
    print(myStruct.prop(object))
}

func printTest<T>(object: T, value: Int, myStruct: MyStruct<T>) {
    print(myStruct.test(object, value))
}

let myClass = MyClass()
printProp(object: myClass, myStruct: .emptyString)
printTest(object: myClass, value: 20, myStruct: .emptyString)
