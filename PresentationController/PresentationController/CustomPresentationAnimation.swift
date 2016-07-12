//
//  CustomPresentationAnimation.swift
//  PresentationController
//
//  Created by yuanwei on 16/7/11.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

import UIKit

class CustomPresentationAnimation: NSObject,
UIViewControllerAnimatedTransitioning {

    let isPresenting :Bool
    let duration :NSTimeInterval = 0.5
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)  {
        if isPresenting {
            animatePresentationWithTransitionContext(transitionContext)
        }
        else {
            animateDismissalWithTransitionContext(transitionContext)
        }
    }
    
    func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey),
            let containerView = transitionContext.containerView()
            else {
                return
        }
        presentedControllerView.frame = transitionContext.finalFrameForViewController(presentedController)
        presentedControllerView.center.y -= containerView.bounds.size.height
        containerView.addSubview(presentedControllerView)
        
        UIView.animateWithDuration(self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .AllowUserInteraction, animations: {
            presentedControllerView.center.y += containerView.bounds.size.height
            }, completion: {(completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
        })
    }
    
    func animateDismissalWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let presentedControllerView = transitionContext.viewForKey(UITransitionContextFromViewKey),
            let containerView = transitionContext.containerView()
            else {
                return
        }
        UIView.animateWithDuration(self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .AllowUserInteraction, animations: {
            presentedControllerView.center.y += containerView.bounds.size.height
            }, completion: {(completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
        })
    }
}
