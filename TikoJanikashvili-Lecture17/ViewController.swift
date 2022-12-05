//
//  ViewController.swift
//  TikoJanikashvili-Lecture17
//
//  Created by Tiko Janikashvili on 04.12.22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var animateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGreen
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(animateView)
    }
    
    // MARK: -Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        addSwipeGestureRecognizer()
    }
    
    // MARK: - Functions
    
    private func addSwipeGestureRecognizer() {
        let left = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        left.direction = .left
        
        let right = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        right.direction = .right
        
        let up = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        up.direction = .up
        
        let bottom = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        bottom.direction = .down
        
        animateView.addGestureRecognizer(left)
        animateView.addGestureRecognizer(right)
        animateView.addGestureRecognizer(bottom)
        animateView.addGestureRecognizer(up)
    }
    
    private func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: animateView.center.x , y: animateView.center.y - 10))
        animation.toValue = NSValue(cgPoint: CGPoint(x: animateView.center.x, y: animateView.center.y + 10))
        animateView.layer.add(animation, forKey: "position")
    }
    
    private func rotate() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.fromValue = 0
        animation.toValue = CGFloat.pi / 2
        animation.duration = 1
        
        animateView.layer.add(animation, forKey: "basic")
        animateView.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 0, 1)
    }
    
    @objc private func swipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
            
        case UISwipeGestureRecognizer.Direction.right:
            print("Swiped right")
            shake()
            
        case UISwipeGestureRecognizer.Direction.down:
            print("Swiped down")
            
            animateView.alpha = 1
            UIView.animate(withDuration: 2, delay: 0,  animations: {
                self.animateView.alpha = 0
            }) { _ in
                UIView.animate(withDuration: 2, delay: 0,  animations: {
                    self.animateView.alpha = 1
                })
            }
            
        case UISwipeGestureRecognizer.Direction.left:
            print("Swiped left")
            rotate()
            
            
        case UISwipeGestureRecognizer.Direction.up:
            print("Swiped up")
            
            animateView.transform = CGAffineTransform(scaleX: 3, y: 3)
            UIView.animate(withDuration: 3, delay: 0, animations: {
                self.animateView.transform = .identity
            }) { _ in
                UIView.animate(withDuration: 3, delay: 0, animations: {
                    self.animateView.transform = CGAffineTransform(scaleX: 4, y: 4)
                })
            }
            
        default:
            break
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemPurple
        NSLayoutConstraint.activate([
            animateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animateView.heightAnchor.constraint(equalToConstant: 50),
            animateView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

