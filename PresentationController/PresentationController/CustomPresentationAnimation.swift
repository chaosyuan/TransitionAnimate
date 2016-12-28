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
    let duration :TimeInterval = 0.5
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)  {
        if isPresenting {
            animatePresentationWithTransitionContext(transitionContext)
        }
        else {
            animateDismissalWithTransitionContext(transitionContext)
        }
    }
    
    func animatePresentationWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning?) {
        
        guard
            let presentedController = transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to),
            //Modal 转场中 获取的是presentedView返回的视图
             let presentedControllerView = transitionContext?.view(forKey: UITransitionContextViewKey.to),
             let containerView =  transitionContext?.containerView
            else {
                return
        }
        presentedControllerView.frame = (transitionContext?.finalFrame(for: presentedController))!
        presentedControllerView.center.y -= containerView.bounds.size.height
        containerView.addSubview(presentedControllerView)
        
        UIView.animate(withDuration: self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
            presentedControllerView.center.y += containerView.bounds.size.height
            }, completion: {(completed: Bool) -> Void in
                transitionContext?.completeTransition(completed)
        })
    }
    
    func animateDismissalWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning?) {
        
        guard
            let presentedControllerView = transitionContext?.view(forKey: UITransitionContextViewKey.from),
            let containerView = transitionContext?.containerView
            else {
                return
        }
        UIView.animate(withDuration: self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
            presentedControllerView.center.y += containerView.bounds.size.height
            }, completion: {(completed: Bool) -> Void in
                transitionContext?.completeTransition(completed)
        })
    }
}
