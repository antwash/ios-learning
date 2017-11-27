//  CustomAnimationPresentor.swift
//  Instagram
//  Created by Anthony Washington on 11/26/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit

class CustomAnimationPresentor: NSObject {}

extension CustomAnimationPresentor: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext:
        UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let container = transitionContext.containerView
        guard let presentView = transitionContext.view(forKey: .to) else { return }
        guard let fromThisView = transitionContext.view(forKey: .from) else { return }
        
        container.addSubview(presentView)
        
        let beginFrame = CGRect(x: -presentView.frame.width, y: 0, width:
            presentView.frame.width, height: presentView.frame.height)
        presentView.frame = beginFrame
        
        // animate too view
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping:
            1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
            presentView.frame = CGRect(x: 0, y: 0, width: presentView.frame.width, height:
                presentView.frame.height)
            fromThisView.frame = CGRect(x: fromThisView.frame.width, y: 0, width:
                fromThisView.frame.width, height: fromThisView.frame.height)
                
        }) { (_) in transitionContext.completeTransition(true) }
    }
}

