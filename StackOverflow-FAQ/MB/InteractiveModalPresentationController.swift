//
//  InteractiveModalPresentationController.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 18.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

//enum ModalScaleState {
//    case presentation
//    case interaction
//}

//final class InteractiveModalPresentationController: UIPresentationController {
//    
////    private let presentedYOffset: CGFloat = 150
////    private var direction: CGFloat = 0
////    private var state: ModalScaleState = .presentation
//    private lazy var dimmingView: UIView! = {
//        guard let container = containerView else { return nil }
//        let view = UIView(frame: container.bounds)
//        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap(tap:))))
//        return view
//    }()
//    
//    override var frameOfPresentedViewInContainerView: CGRect {
//        guard let container = containerView else { return .zero }
//        return CGRect(x: 0, y: 0, width: container.bounds.width / 2, height: container.bounds.height)
//    }
//
//    
////    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
////        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
////        presentedViewController.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPan(pan:))))
////    }
////
////    @objc func didPan(pan: UIPanGestureRecognizer) {
////        guard let view = pan.view, let superView = view.superview,
////            let presented = presentedView, let container = containerView else { return }
////
////        let location = pan.translation(in: superView)
////
////        switch pan.state {
////        case .began:
////            presented.frame.size.height = container.frame.height
////        case .changed:
////            let velocity = pan.velocity(in: superView)
////
////            switch state {
////            case .interaction:
////                presented.frame.origin.y = location.y
////            case .presentation:
////                presented.frame.origin.y = location.y
////            }
////            direction = velocity.y
////        case .ended:
////            let maxPresentedY = container.frame.height
////            switch presented.frame.origin.y {
////            case 0...maxPresentedY:
////                changeScale(to: .interaction)
////            default:
////                presentedViewController.dismiss(animated: true, completion: nil)
////            }
////        default:
////            break
////        }
////    }
//    
//    @objc func didTap(tap: UITapGestureRecognizer) {
//        presentedViewController.dismiss(animated: true, completion: nil)
//    }
//    
////    func changeScale(to state: ModalScaleState) {
////        guard let presented = presentedView else { return }
////
////        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [unowned self] in
////            presented.frame = self.frameOfPresentedViewInContainerView
////            }, completion: { (_) in
////                self.state = state
////        })
////    }
//    
//    override func presentationTransitionWillBegin() {
//        guard let container = containerView, let coordinator = presentingViewController.transitionCoordinator else { return }
//        dimmingView.alpha = 0
//        container.addSubview(dimmingView)
//        dimmingView.addSubview(presentedViewController.view)
//        coordinator.animate(alongsideTransition: { [unowned self] _ in
//            self.dimmingView.alpha = 1
//            }, completion: nil)
//    }
//    
//    override func dismissalTransitionWillBegin() {
//        guard let coordinator = presentingViewController.transitionCoordinator else { return }
//        coordinator.animate(alongsideTransition: { [unowned self] _ in
//            self.dimmingView.alpha = 0
//            }, completion: nil)
//    }
//    
//    override func dismissalTransitionDidEnd(_ completed: Bool) {
//        if completed {
//            dimmingView.removeFromSuperview()
//        }
//    }
//    
//}
//
//extension UIViewController {
//    
//func transitionVc(vc: UIViewController, duration: CFTimeInterval, type: CATransitionSubtype) {
//    let customVcTransition = vc
//    let transition = CATransition()
//    transition.duration = duration
//    transition.type = CATransitionType.push
//    transition.subtype = type
//    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//    view.window!.layer.add(transition, forKey: kCATransition)
//    present(customVcTransition, animated: false, completion: nil)
//}}
