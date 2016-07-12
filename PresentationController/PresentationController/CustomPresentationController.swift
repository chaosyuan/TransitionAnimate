//
//  CustomPresentationController.swift
//  PresentationController
//
//  Created by yuanwei on 16/7/11.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {

    lazy var dimmingView :UIView = {
        let view = UIView(frame: self.containerView!.bounds)
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        view.alpha = 0.0
        return view
    }()
    
    override func presentationTransitionWillBegin() {
        
        guard
            let containerView = containerView,
            let presentedView = presentedView()
            else {
                return
        }
        
        dimmingView.frame = containerView.bounds
        containerView.addSubview(dimmingView)
        containerView.addSubview(presentedView)
        
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha = 1.0
                }, completion:nil)
        }
    }
    
    override func presentationTransitionDidEnd(completed: Bool)  {
        if !completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin()  {
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha  = 0.0
                }, completion:nil)
        }
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        guard
            let containerView = containerView
            else {
                return CGRect()
        }
        
        var frame = containerView.bounds;
        frame = CGRectInset(frame, 50.0, 50.0)
        return frame
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator transitionCoordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: transitionCoordinator)
        
        guard
            let containerView = containerView
            else {
                return
        }
        transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.dimmingView.frame = containerView.bounds
            }, completion:nil)
    }
}
