//
//  ViewController.swift
//  SurveyExample
//
//  Created by Abhishek Chaudhari on 25/08/18.
//  Copyright © 2018 Abhishek Chaudhari. All rights reserved.
//

import UIKit

class SurveyLandingPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        AuthManager.shared.resetKeychain()
        
        AuthManager.shared.fetchToken { (result) in
            switch result{
            case .success(let token):
                print(token)
            case .failure(let err):
                print(err)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

