//
//  ViewController.swift
//  InertionCube
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cubeView: UIView!

    private var secondAnimator: UIDynamicAnimator?
    private var animator: UIViewPropertyAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCube()
        configureGestures()

    }
    
    func setupCube() {
        cubeView.backgroundColor = .blue
        cubeView.layer.cornerRadius = 10
    }
    
    func configureGestures() {
        let panGesture = UITapGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: view)

        let projection = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.7 ) {
            self.cubeView.transform = .identity
        }
        projection.addAnimations {
            self.cubeView.transform = CGAffineTransform(rotationAngle: 0.2)
            self.cubeView.center = touchPoint
        }
        projection.startAnimation()
    }

}

