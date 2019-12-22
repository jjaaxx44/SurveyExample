//
//  TakeSurveyVC.swift
//  SurveyExample
//
//  Created by Abhishek Chaudhari on 21/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import UIKit

class TakeSurveyVC: UIViewController {
    private let survey: Survey!
    @IBOutlet weak var takeSurveyDummyLlabel: UILabel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        updateContents()
    }
    
    init(survey: Survey) {
        self.survey = survey
        super.init(nibName: "TakeSurveyVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View and content setup
    private func setupView(){
        self.view.backgroundColor = AppColors.navBarColor
    }
    
    private func updateContents(){
        takeSurveyDummyLlabel.text = "id: \(survey.id ?? "")\n\(survey.title ?? "")"
    }
}
