//
//  SignInViewModel.swift
//  FacialSignIn
//
//  Created by Yi JIANG on 2/11/18.
//  Copyright © 2018 Inteliment. All rights reserved.
//

import Foundation
import UIKit

class SignInViewModel {
    
    let apiClient: ApiClient
    
    var potentialVisitor: PotentialVisitors? {
        didSet {
            didUpdatePotentialVisitors?()
        }
    }
    var visitor: Visitor? {
        didSet {
            updateVisitorForm?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            showAlert?()
        }
    }
    
    var isLoading = false {
        didSet {
            updateLoadingStatus?()
        }
    }
    
    // MARK: - UI Binding
    var textOfNameTextField: String {
        return visitor?.name ?? ""
    }
    var textOfMobileTextField: String {
        return visitor?.mobile ?? ""
    }
    var textOfEmailTextField: String {
        return visitor?.email ?? ""
    }
    var imageOfVisitorImage: UIImage {
        #warning("The visitor.image is a long string (.jpg). We need decode it into uiimage.")
        return UIImage()
    }
    var textOfHosterNameTextField: String {
        return visitor?.visiting ?? ""
    }
    
    
    // MARK: - Events
    var hasError: ((RequestError) -> Void)?
    var didUpdatePotentialVisitors: (() -> Void)?
    var showAlert: (() -> Void)?
    var updateVisitorForm: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    
    init(_ apiClient: ApiClient = ApiClient()) {
        self.apiClient = apiClient
    }
    
    func createNewVisitor() {
        #warning("Call new visitor API to create new visitor")
        isLoading = true
        apiClient.networkRequest(.newVisitor) { [weak self] (data, error) in
            guard let self = self else { return }
            self.isLoading = false
            if let error = error {
                self.hasError?(error)
                self.alertMessage = error.errorDescription
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    self.visitor = try decoder.decode(Visitor.self, from: data)
                } catch let error {
                    self.alertMessage = "Can't decode API response: \(error.localizedDescription)"
                }
        }
    }
    
    func recogniseVisitor() {
        #warning("Wrap 5 face images into API call's body, backend service will train it self.")
    }
        
        
}
