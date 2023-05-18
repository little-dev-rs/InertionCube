//
//  ViewController.swift
//  InertionCube
//

import UIKit

class ViewController: UIViewController {
    private lazy var cubeView: UIView = {
        let view = UIView(frame: CGRect(origin: .init(x: view.center.x - 50, y: view.center.y - 50),
                                        size: CGSize(width: 100, height: 100)))
        view.backgroundColor = .blue
        view.layer.cornerRadius = 10
        return view
    }()

    private var animator: UIDynamicAnimator!
    private var snapBehavior: UISnapBehavior!
    private var rotationBehavior: UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cubeView)
        configureGestures()
    }

    func configureGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handlePan(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: view)
        
        animator = UIDynamicAnimator(referenceView: view)
        snapBehavior = UISnapBehavior(item: cubeView, snapTo: touchPoint)
        snapBehavior.damping = 0.8

        rotationBehavior = UIDynamicItemBehavior(items: [cubeView])
        rotationBehavior.allowsRotation = true
        rotationBehavior.angularResistance = 0.5
        animator.addBehavior(rotationBehavior)
    
        switch gesture.state {
        case .began:
            animator.removeBehavior(snapBehavior)
        case .changed:
            cubeView.center = touchPoint
        case .ended, .cancelled:
            animator.addBehavior(snapBehavior)
        default:
            break
        }
    }

}

