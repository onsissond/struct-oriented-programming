//
//  Animator.swift
//  StructOrientedExamples
//
//  Created by Sukhanov Evgeny on 02.06.2022.
//

import UIKit

struct Animator<Target> {
    typealias Completion = (Bool) -> Void
    var animate: (Target, _ completion: Completion?) -> Void
}

extension Animator {
    static func merge(_ animators: Animator...) -> Animator {
        Animator { target, completion in
            var results = Array(repeating: false, count: animators.count)
            var completed = 0
            animators.enumerated().forEach { idx, animator in
                animator.animate(target) { result in
                    results[idx] = result
                    completed += 1
                    if completed == results.count {
                        completion?(results.reduce(true) { $0 && $1 })
                    }
                }
            }
        }
    }
}

extension Animator {
    func pullback<A>(_ f: @escaping (A) -> Target) -> Animator<A> {
        Animator<A> { targetA, completion in
            self.animate(f(targetA), completion)
        }
    }
}
