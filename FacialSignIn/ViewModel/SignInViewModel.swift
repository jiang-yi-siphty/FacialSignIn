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
    var didUpdatePotentialVisitors: (() -> Void)?
    var showAlert: (() -> Void)?
    var updateVisitorForm: (() -> Void)?
    
    init(_ apiClient: ApiClient = ApiClient()) {
        self.apiClient = apiClient
    }
    
    
}
