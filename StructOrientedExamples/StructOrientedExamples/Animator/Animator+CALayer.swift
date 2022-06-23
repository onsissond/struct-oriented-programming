//
//  Animator+CALayer.swift
//  StructOrientedExamples
//
//  Created by Sukhanov Evgeny on 21.06.2022.
//

import UIKit

extension Animator where Target == CALayer {
    static func changeColor(
        _ color: UIColor,
        duration: TimeInterval = 0.5
    ) -> Animator {
        Animator { layer, completion in
            CATransaction.begin()
            let animation = CABasicAnimation(keyPath: "backgroundColor")
            animation.fromValue = layer.backgroundColor
            animation.toValue = color.cgColor
            animation.duration = duration
            CATransaction.setCompletionBlock {
                completion?(true)
            }
            layer.add(animation, forKey: "backgroundColor")
            CATransaction.commit()
            layer.backgroundColor = color.cgColor
        }
    }
}
