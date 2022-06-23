//
//  UIViewController+animate.swift
//  StructOrientedExamples
//
//  Created by Sukhanov Evgeny on 21.06.2022.
//

import UIKit

extension UIViewController {
    func animate<Target>(
        _ target: Target,
        animator: Animator<Target>,
        completion: ((Bool) -> Void)? = nil
    ) {
        animator.animate(target, completion)
    }
}
