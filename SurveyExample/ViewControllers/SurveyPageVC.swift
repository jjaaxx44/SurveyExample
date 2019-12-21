//
//  SurveyPageVC.swift
//  SurveyExample
//
//  Created by Abhishek Chaudhari on 20/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import UIKit
import Kingfisher
class SurveyPageVC: UIViewController {
    private let survey: Survey!
    @IBOutlet weak var surveyImageView: UIImageView!
    @IBOutlet weak var takeTheSurveyButton: UIButton!
    
    init(survey: Survey) {
        self.survey = survey
        super.init(nibName: "SurveyPageVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let urlString = survey.cover_image_url,
            let url = URL(string: "\(urlString)l") else {
            return
        }
        surveyImageView.kf.indicatorType = .activity
        surveyImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        takeTheSurveyButton.backgroundColor = AppColors.buttonColor
        takeTheSurveyButton.addBorder(borderWidth: 0.0, cornerRadius: takeTheSurveyButton.frame.height/2, borderColor: .clear)
    }

    @IBAction func takeSurveyButtonClicked(_ sender: Any) {
        print("takeSurveyButtonClicked")
    }
}
