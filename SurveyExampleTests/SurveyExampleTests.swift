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
    var takeSurveyVC: TakeSurveyVC!

    static let idString = "test id"
    static let titleString = "test title"
    static let descriptionString = "test description"
    static let coverUrlString = "https://homepages.cae.wisc.edu/~ece533/images/airplane.png"
    let testSurvey = Survey(id: idString, title: titleString, description: descriptionString, cover_image_url: coverUrlString)

    private func setUpViewControllers() {
        self.surveyPageVC = SurveyPageVC(survey: testSurvey)
        self.surveyPageVC.loadView()
        self.surveyPageVC.viewDidLoad()

        self.takeSurveyVC = TakeSurveyVC(survey: testSurvey)
        self.takeSurveyVC.loadView()
        self.takeSurveyVC.viewDidLoad()
    }

    override func setUp() {
        super.setUp()

        self.setUpViewControllers()
    }

    override func tearDown() {
        surveyPageVC = nil
        takeSurveyVC = nil
        super.tearDown()
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
        let labelString = "id: \(SurveyExampleTests.idString)\n\(SurveyExampleTests.titleString)"

        XCTAssertNotNil(self.takeSurveyVC, "takeSurveyVC is nil")

        XCTAssertTrue(self.takeSurveyVC.takeSurveyDummyLlabel.text == labelString)
    }
}
