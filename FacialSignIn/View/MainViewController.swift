//
//  MainViewController.swift
//  FacialSignIn
//
//  Created by Yi JIANG on 30/10/18.
//  Copyright © 2018 Inteliment. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func newVisitorButtonTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "ShowSignInView", sender: self)
    }
    
    @IBAction func autoSignInButtonTouchUpInside(_ sender: Any) {
    }
    
    @IBAction func approveButtonTouchUpInside(_ sender: Any) {
    }
    
}
