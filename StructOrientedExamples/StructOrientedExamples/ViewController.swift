//
//  ViewController.swift
//  StructOrientedExamples
//
//  Created by Sukhanov Evgeny on 02.06.2022.
//

import UIKit

class ViewController: UIViewController {
    private lazy var animatedView = UIView(frame: view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubscriptions()
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(animatedView)
    }
    
    private func setUpSubscriptions() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapView(_:))
        )
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        showView()
    }
    
    private func showView() {
        animatedView.alpha = 0
        animatedView.backgroundColor = .red
        animatedView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        animate(animatedView, animator: .merge(
            .fadeIn(duration: 3),
            .scale(x: 1, y: 1, duration: 1),
            Animator.changeColor(.blue, duration: 5).pullback(\.layer)
        )) { _ in
            print("Finish animation")
        }
    }
}
