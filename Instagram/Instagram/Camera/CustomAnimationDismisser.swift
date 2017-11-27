//  CustomAnimationDismisser.swift
//  Instagram
//  Created by Anthony Washington on 11/26/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit

class CustomAnimationDismisser: NSObject {}

extension CustomAnimationDismisser: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext:
        UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        guard let fromThisView = transitionContext.view(forKey: .from) else { return }
        guard let toThisView = transitionContext.view(forKey: .to) else { return }
        
        container.addSubview(toThisView)
        
        // animate too view
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:
            1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

                fromThisView.frame = CGRect(x: -fromThisView.frame.width, y: 0, width:
                    fromThisView.frame.width, height: fromThisView.frame.height)
                
                toThisView.frame = CGRect(x: 0, y: 0, width: toThisView.frame.width, height:
                    toThisView.frame.height)
                
        }) { (_) in transitionContext.completeTransition(true) }
    }
}
