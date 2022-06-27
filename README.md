# Struct oriented programming vs Protocol oriented programming

- How do we use protocols
- How to do it without protocols
- How to transform any protocol to a sturct
- Porotocol's limitations
- Struct oriented programming's limitations
- Play with uikit animations

# Protocol oriented programming
```swift
protocol Animator {
    associatedtype Target
    static func animate(
        _ target: Target,
        completion: ((Bool) -> Void)?
    )
}

struct FadeInAnimator: AnimatorProtocol {
    static func animate(
        _ target: UIView,
        completion: ((Bool) -> Void)?
    ) {
        UIView.animate(
            withDuration: 5,
            delay: 0,
            options: [],
            animations: { target.alpha = 0.0 },
            completion: { completion?($0) }
        )
    }
}
```

# Struct oriented programming
```swift
struct Animator<Target> {
    typealias Completion = (Bool) -> Void
    var animate: (Target, _ completion: Completion?) -> Void
}

extension Animator where Target == UIView {
    static func fadeOut(
        params: UIViewAnimationParams
    ) -> Animator {
        Animator { view, completion in
            UIView.animate(
                withDuration: params.duration,
                delay: params.delay,
                options: params.options,
                animations: { view.alpha = 0.0 },
                completion: completion
            )
        }
    }
}
```

# Where does it use?
## [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing)

There are two main entites which you should look at:

[Diffing](https://github.com/pointfreeco/swift-snapshot-testing/blob/ad2c83170e82954d9504e4db205c43a3f493bc55/Sources/SnapshotTesting/Diffing.swift#L5-L13) - allows to compare `Value`s and convert them to and from `Data`

[Snapshotting](https://github.com/pointfreeco/swift-snapshot-testing/blob/ad2c83170e82954d9504e4db205c43a3f493bc55/Sources/SnapshotTesting/Snapshotting.swift#L5-L13) - allows to transform a snapshottable value into a diffable format (like text or an image) for snapshot testing.

More about it:

- [Protocol Witnesses: Part 1](https://www.pointfree.co/episodes/ep33-protocol-witnesses-part-1)
- [Protocol Witnesses: Part 2](https://www.pointfree.co/episodes/ep34-protocol-witnesses-part-2)
- [Advanced Protocol Witnesses: Part 1](https://www.pointfree.co/episodes/ep35-advanced-protocol-witnesses-part-1)
- [Advanced Protocol Witnesses: Part 2](https://www.pointfree.co/episodes/ep36-advanced-protocol-witnesses-part-2)
- [Protocol-Oriented Library Design: Part 1](https://www.pointfree.co/episodes/ep37-protocol-oriented-library-design-part-1)
- [Protocol-Oriented Library Design: Part 2](https://www.pointfree.co/episodes/ep38-protocol-oriented-library-design-part-2)
- [Witness-Oriented Library Design](https://www.pointfree.co/episodes/ep39-witness-oriented-library-design)
- [Async Functional Refactoring](https://www.pointfree.co/episodes/ep40-async-functional-refactoring)

# Resources
- [Stop Using Protocols!](https://riccardocipolleschi.medium.com/stop-using-protocols-cd63744a3261)
- [What is it Pullback?](https://www.pointfree.co/blog/posts/22-some-news-about-contramap)

# QRCode for this repository
<img src="Resources/QRCode.png" width="350">
