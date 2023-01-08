

import Foundation

// MARK: - BaseViperViewController

// swiftlint:disable all
protocol BaseViperViewController: AnyObject {

    associatedtype P: BaseViperPresenter
    var presenter: P? { get }

}

// MARK: - BaseViperPresenter

protocol BaseViperPresenter: AnyObject {
    associatedtype V: BaseViperViewController
    var view: V? { get }

    associatedtype I: BaseViperInteractor
    var interactor: I { get }

    associatedtype RType: BaseViperRouter
    var router: RType { get }

}

// MARK: - BaseViperInteractor

protocol BaseViperInteractor: AnyObject {

    associatedtype P: BaseViperPresenter
    var presenter: P? { get }

}

// MARK: - BaseViperRouter

protocol BaseViperRouter: AnyObject {}
// swiftlint:enable all
