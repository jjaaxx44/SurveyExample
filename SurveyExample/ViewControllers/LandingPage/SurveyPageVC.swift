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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var takeTheSurveyButton: UIButton!
    
    // MARK: - View lifecycle
    init(survey: Survey) {
        self.survey = survey
        super.init(nibName: "SurveyPageVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateContents()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        takeTheSurveyButton.backgroundColor = AppColors.buttonColor
        takeTheSurveyButton.addBorder(borderWidth: 0.0, cornerRadius: takeTheSurveyButton.frame.height/2, borderColor: .clear)
    }

    // MARK: - View and content setup
    func updateContents(){
        guard let urlString = survey.cover_image_url,
            let url = URL(string: "\(urlString)l") else {
            return
        }
        surveyImageView.kf.indicatorType = .activity
        surveyImageView.kf.setImage(with: url, placeholder: UIImage(named: "PlaceHolder"),options: [.transition(.fade(0.2))])
        titleLabel.text = survey.title
        discriptionLabel.text = survey.description
    }
    
    // MARK: - Actions
    @IBAction func takeSurveyButtonClicked(_ sender: Any) {
        let takeSurvey = TakeSurveyVC(survey: survey)
        self.navigationController?.pushViewController(takeSurvey, animated: true)
    }
}
