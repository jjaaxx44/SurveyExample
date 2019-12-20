//
//  ViewController.swift
//  SurveyExample
//
//  Created by Abhishek Chaudhari on 25/08/18.
//  Copyright © 2018 Abhishek Chaudhari. All rights reserved.
//

import UIKit

class SurveyLandingPageVC: UIViewController {

    var surveyPageToFetchNext = 1
    let surveryCount = 2
    var surveyModels = [Survey]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setupNavigationBar()
    }

    private func setupNavigationBar(){
        self.title = "SURVEYS"
        let reload = UIBarButtonItem(compactImage: UIImage(named: "reload"), target: self, action: #selector(reloadButtonClicked), forEvenr: .touchUpInside)
        let next = UIBarButtonItem(compactImage: UIImage(named: "next"), target: self, action: #selector(nextButtonClicked), forEvenr: .touchUpInside)
        navigationItem.leftBarButtonItems = [reload, next]

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(menuButtonClicked))
    }
    
    private func getSurveys() {
        APIManager.shared.fetchSurverys(pageNumber: surveyPageToFetchNext, numebrOfSurverys: surveryCount) { result in
            switch result{
            case .success(let surveys):
                self.surveyPageToFetchNext += 1
                self.surveyModels.append(contentsOf: surveys)
                print(surveys)
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

extension SurveyLandingPageVC{
    @objc private func menuButtonClicked(){
        
    }
    
    @objc private func reloadButtonClicked(){
        surveyPageToFetchNext = 1
        self.surveyModels.removeAll()
        getSurveys()
    }
    
    @objc private func nextButtonClicked(){
        getSurveys()
    }
}
