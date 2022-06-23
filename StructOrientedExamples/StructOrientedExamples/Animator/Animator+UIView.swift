//
//  Animator+UIView.swift
//  StructOrientedExamples
//
//  Created by Sukhanov Evgeny on 21.06.2022.
//

import UIKit

struct UIViewAnimationParams {
    var duration: TimeInterval
    var delay: TimeInterval = 0
    var options: UIView.AnimationOptions = []

    static let `default` = UIViewAnimationParams(
        duration: 0.5,
        delay: 0,
        options: .curveEaseOut
    )
}

extension Animator where Target == UIView {
    static func fadeIn(
        _ params: UIViewAnimationParams = .default
    ) -> Animator {
        Animator { view, completion in
            UIView.animate(
                withDuration: params.duration,
                delay: params.delay,
                options: params.options,
                animations: { view.alpha = 1.0 },
                completion: completion
            )
        }
    }
    
    static func fadeIn(
        duration: TimeInterval,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = []
    ) -> Animator {
        self.fadeIn(UIViewAnimationParams(
            duration: duration,
            delay: delay,
            options: options
        ))
    }
    
    static func fadeOut(
        _ params: UIViewAnimationParams = .default
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
    
    static func fadeOut(
        duration: TimeInterval,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = []
    ) -> Animator {
        self.fadeOut(UIViewAnimationParams(
            duration: duration,
            delay: delay,
            options: options
        ))
    }
    
    static func scale(
        x: CGFloat,
        y: CGFloat,
        _ params: UIViewAnimationParams = .default
    ) -> Animator {
        Animator { view, completion in
            UIView.animate(
                withDuration: params.duration,
                delay: params.delay,
                options: params.options,
                animations: {
                    view.transform = CGAffineTransform(scaleX: x, y: y)
                },
                completion: completion
            )
        }
    }
    
    static func scale(
        x: CGFloat,
        y: CGFloat,
        duration: TimeInterval,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = []
    ) -> Animator {
        self.scale(
            x: x,
            y: y,
            UIViewAnimationParams(
                duration: duration,
                delay: delay,
                options: options
            )
        )
    }
}
