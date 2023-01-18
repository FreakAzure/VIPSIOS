//
//  UINavigationView.swift
//  Vipspad
//
//  Created by Azure on 10/1/23.
//

import Foundation

import UIKit

extension UINavigationController {

    // MARK: Public

    public func pushViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void)
    {
        pushViewController(viewController, animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }

    // MARK: Internal

    func popViewController(
        animated: Bool,
        completion: @escaping () -> Void)
    {
        popViewController(animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }

    func pushVCNoDuplicate(_ vc: UIViewController, animated: Bool = true, bringFront: Bool = false, completion: (() -> Void)? = nil) {
        if let duplicateVC = viewControllers.first(where: { $0.isKind(of: vc.classForCoder) }) {
            var VCStack = viewControllers
            if bringFront, let duplicateIndex = VCStack.firstIndex(where: { duplicateVC == $0 }) {
                VCStack.remove(at: duplicateIndex)
                VCStack.append(duplicateVC)
                setViewControllers(VCStack, animated: true)
            }
            debugPrint("Push of \(vc.classForCoder) has been prevented because is already another in the stack")
            return
        }
        if isPresentingClass(vc.classForCoder) {
            debugPrint("Push of \(vc.classForCoder) has been prevented because another VC is being pushed")
            return
        }
        setPresentingClass(vc.classForCoder)

        pushViewController(vc, animated: animated) {
            completion?()

            if animated {
                // Shitty approach but with coordinator there is a timelapse yet where new VC is already presenting and is not in Navigation VCs stack, view below the tests
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.55) {
                    self.removePresentingClass(vc.classForCoder)
                }
                // After some test those are the times in which the new VC is in the stack, could be least without debugging but I can not take the risk
                // 0.5, 0.55, 0.55, 0.55, 0.55
//                for i in stride(from: 0, to: 2, by: 0.05) {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + i) {
//                        if self.viewControllers.contains(where: { $0.isKind(of: vc.classForCoder) }) {
//                            debugPrint(i)
//                        }
//                    }
//                }
            } else {
                self.removePresentingClass(vc.classForCoder)
            }

        }
    }

    func onPopToRoot(stopOn vc: UIViewController?) {
        popToViewController = vc
    }

    func popToRequiredOrRoot(animated: Bool = true) {

        if
            let vc = popToViewController,
            self.viewControllers.contains(vc)
        {
            self.popToViewController(vc, animated: animated)
        } else {
            popToRootViewController(animated: animated)
        }

        popToViewController = nil
    }

    // MARK: Private

    private static var _popToViewController = [String: UIViewController]()

    private static var _isPresentingClass = [String: [AnyClass]]()

    private var popToViewController: UIViewController? {
        get {
            let tmpAddress = String(format: "popToViewController%p", unsafeBitCast(self, to: Int.self))
            return UINavigationController._popToViewController[tmpAddress]
        }
        set(newValue) {
            let tmpAddress = String(format: "popToViewController%p", unsafeBitCast(self, to: Int.self))
            UINavigationController._popToViewController[tmpAddress] = newValue
        }
    }

    private func isPresentingClass(_ classForCoder: AnyClass) -> Bool {
        let tmpAddress = String(format: "presentingVC%p", unsafeBitCast(self, to: Int.self))
        return UINavigationController._isPresentingClass[tmpAddress]?.contains { $0 == classForCoder } ?? false
    }
    private func setPresentingClass(_ classForCoder: AnyClass) {
        let tmpAddress = String(format: "presentingVC%p", unsafeBitCast(self, to: Int.self))
        var presentingArray = UINavigationController._isPresentingClass[tmpAddress] ?? []
        presentingArray.append(classForCoder)
        UINavigationController._isPresentingClass[tmpAddress] = presentingArray
    }
    private func removePresentingClass(_ classForCoder: AnyClass) {
        let tmpAddress = String(format: "presentingVC%p", unsafeBitCast(self, to: Int.self))
        UINavigationController._isPresentingClass[tmpAddress]?.removeAll { $0 == classForCoder }
    }
}
