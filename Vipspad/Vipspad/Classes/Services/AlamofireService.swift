//
//  AlamofireService.swift
//  Vipspad
//
//  Created by Azure on 8/1/23.
//

import Foundation

import Alamofire
import Foundation
import UIKit

// MARK: - AlamofireService
// swiftlint:disable file_length
class AlamofireService {

    // MARK: Lifecycle
    private init(application: AppDelegate) {
        self.application = application
    }

    // MARK: Internal
    struct IgnoreResponse: Codable {}

    // swiftlint:disable implicitly_unwrapped_optional
    private(set) static var shared: AlamofireService!

    static func configure(application: AppDelegate) {
        shared = .init(application: application)
    }

    // MARK: Private
    private enum RequestTime: Double {
        /// Quick connection and Backend with function hot preloaded
        case fast = 0.2
        /// Normal  connection and Backend with function hot preloaded
        case normal = 0.5
        /// Quick connection and Backend with function not preloaded || Slow connection and Backend with function hot preloaded
        case slow = 1.2
        /// Slow connection and Backend with function not preloaded
        case slower = 2
    }

    private weak var application: AppDelegate?
    // swiftformat:disable:next typeSugar
    private let noneParam = Optional<[String: String]>.none

    private let baseURL: String = "https://v1psend-production.up.railway.app/api/v1/"

    private func endpointCall<D: Decodable, T: Encodable>(
        path: String,
        method: HTTPMethod = .get,
        params: T?,
        timeoutInterval: TimeInterval = 5,
        success: @escaping (D) -> Void,
        failure: @escaping (String) -> Void)
    {

        guard let url = URL(string: "\(baseURL)\(path)")
        else { fatalError("Cannot retrivea a valid URL with: \(baseURL)\(path)") }
        guard let token = KeyChainService.shared.retrieveToken() else {
            failure("No token")
            return
        }
        var urlRequest = URLRequest(url: url)

        urlRequest.method = method
        urlRequest.headers = [
            .contentType("application/json"),
            .authorization(token),
        ]

        if let params = params {
            urlRequest = (try? JSONParameterEncoder.default.encode(params, into: urlRequest)) ?? urlRequest
        }

        AF.request(urlRequest)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: D.self) { response in

                let statusCode = response.response?.statusCode ?? -1

                switch response.result {
                    case .success:
                        if let response = response.value {
                            success(response)
                            return
                        }

                    case let .failure(error):
                        debugPrint(response)
                        debugPrint(error)
                        //                    debugPrint(response.result)
                        //                    debugPrint(error.errorDescription!)
                        failure(
                            error.localizedDescription + " " + String(statusCode)
                        )
                        return

                }
                failure(
                    "Failed request"
                )

            }

    }

    private func uploadImage(
        imageData: Data, contentType: String, uploadURL: URL,
        success: @escaping () -> Void,
        failure: @escaping () -> Void)
    {
        AF.upload(imageData, to: uploadURL, method: .post, headers: [.contentType(contentType)], fileManager: .default)
            .response { response in
                debugPrint(response)
                debugPrint(response.result)
                success()
            }
    }

    private func simulateRequest(
        requestTime: RequestTime = .normal,
        executeAction: @escaping () -> Void)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + requestTime.rawValue) {
            executeAction()
        }
    }

    private func genericErrorHandler(error: String) {
        debugPrint("Handle \(error)")
    }

}

// MARK: WebelAPIContractRegister
extension AlamofireService: APIContract {
    
    func getSelfData(callback: APICallback<User>) {
        endpointCall(path: VipsAPIEndpoints.GET_SELF, params: noneParam)  { (user: User) -> Void in
            callback.success(user)
        } failure: { (error: String) -> Void in
            callback.failure(error)
        }
    }
    
    func getPostFeed(page: Int, category_id: Int, callback: APICallback<Posts>) {
        
        endpointCall(path: VipsAPIEndpoints.GET_POSTS + "?category_id=\(category_id)", params: noneParam) { (posts: Posts) in
            callback.success(posts)
        } failure: { error in
            callback.failure(error)
        }

    }
    
    func getCategories(callback: APICallback<Categories>) {
        endpointCall(path: VipsAPIEndpoints.GET_CATEGORIES, params: noneParam) { (categories: Categories) -> Void in
            callback.success(categories)
        } failure: { error in
            callback.failure(error)
        }
    }
    
    
    func getRisks(callback: APICallback<[BaseProp]>) {
        endpointCall(path: VipsAPIEndpoints.GET_RISKS, params: noneParam) { (risks: [BaseProp]) -> Void in
            callback.success(risks)
        } failure: { error in
            callback.failure(error)
        }
    }
    
    
    func getNetworks(callback: APICallback<[BaseProp]>) {
        endpointCall(path: VipsAPIEndpoints.GET_NETWORKS, params: noneParam) { (networks: [BaseProp]) -> Void in
            callback.success(networks)
        } failure: { error in
            callback.failure(error)
        }
    }
    
    func uploadPost(imagesArray: [UIImage], parameters: [String: String], callback: APICallback<IgnoreResponse>) {
        guard let token = KeyChainService.shared.retrieveToken() else {
            callback.failure("No token")
            return
        }
        AF.upload(multipartFormData: { (multipartFormData) in
            for (index, image) in imagesArray.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.5) {
                    multipartFormData.append(imageData, withName: "images[]", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                }
            }
        }, to: "\(baseURL)\(VipsAPIEndpoints.UPLOAD_POST)", headers: [.authorization(token)]).response { (response) in
            switch response.result{
            case .success(_):
                let apiDictionary = response.value
                print("apiResponse --- \(String(describing: apiDictionary))")
            case .failure(_):
                print("got an error")
            }
        }
    }
}
