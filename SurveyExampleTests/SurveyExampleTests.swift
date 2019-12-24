//
//  SurveyExampleTests.swift
//  SurveyExampleTests
//
//  Created by Abhishek Chaudhari on 22/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import XCTest
@testable import SurveyExample

class SurveyExampleTests: XCTestCase {
        
    var surveyPageVC: SurveyPageVC!
    var landingVC: SurveyLandingPageVC!

    static let idString = "test id"
    static let titleString = "test title"
    static let descriptionString = "test description"
    static let coverUrlString = "https://homepages.cae.wisc.edu/~ece533/images/airplane.png"
    let testSurvey = Survey(id: idString, title: titleString, description: descriptionString, cover_image_url: coverUrlString)

    private func setUpViewControllers() {
        self.surveyPageVC = SurveyPageVC(survey: testSurvey)
        self.surveyPageVC.loadView()
        self.surveyPageVC.viewDidLoad()
        
        self.landingVC = SurveyLandingPageVC()
        self.landingVC.currentSurveyPage = 1
        self.landingVC.surveryCount = 1
        self.landingVC.loadView()
        self.landingVC.viewDidLoad()

    }

    override func setUp() {
        super.setUp()

        self.setUpViewControllers()
    }

    override func tearDown() {
        surveyPageVC = nil
        super.tearDown()
    }
    
    func testLandingPage() {
        landingVC.processApiSuccess(surveys: [testSurvey, testSurvey], forPage: 1)
        XCTAssertTrue(landingVC.surveyModels.count == 2)
        XCTAssertTrue(landingVC.pageControl.numberOfPages == 2)
        XCTAssertTrue(landingVC.surveyModels.count == 2)
        XCTAssertTrue(landingVC.surveyViewItems.first is SurveyPageVC)
        
        landingVC.surveryCount = 5
        landingVC.menuButtonClicked()
        XCTAssertTrue(landingVC.surveryCount == 10)
    }


    func testSurveyPageVC() {
        XCTAssertNotNil(self.surveyPageVC, "surveyPageVC is nil")

        XCTAssertNotNil(self.surveyPageVC.titleLabel, "titleLabel is nil")
        XCTAssertNotNil(self.surveyPageVC.discriptionLabel, "discriptionLabel is nil")
        XCTAssertNotNil(self.surveyPageVC.surveyImageView, "surveyImageView is nil")

        XCTAssertTrue(self.surveyPageVC.discriptionLabel.text == SurveyExampleTests.descriptionString)
        XCTAssertTrue(self.surveyPageVC.titleLabel.text == SurveyExampleTests.titleString)
    }
    
    func testTakeSurveyVC() {
        
        let viewController = self.surveyPageVC
        let navigationController = MockNavController(rootViewController: viewController!)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        
        viewController?.takeTheSurveyButton.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(navigationController.pushedViewController is TakeSurveyVC)

        guard let takeSurveyVC = navigationController.pushedViewController as? TakeSurveyVC else{
            XCTFail()
            return
        }
        
        takeSurveyVC.loadView()
        takeSurveyVC.viewDidLoad()
        
        let labelString = "id: \(SurveyExampleTests.idString)\n\(SurveyExampleTests.titleString)"

        XCTAssertNotNil(takeSurveyVC, "takeSurveyVC is nil")

        XCTAssertTrue(takeSurveyVC.takeSurveyDummyLlabel.text == labelString)
    }
}

class MockNavController: UINavigationController {
    
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
}

