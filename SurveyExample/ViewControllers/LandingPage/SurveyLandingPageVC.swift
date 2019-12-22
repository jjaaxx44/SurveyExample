//
//  ViewController.swift
//  SurveyExample
//
//  Created by Abhishek Chaudhari on 25/08/18.
//  Copyright © 2018 Abhishek Chaudhari. All rights reserved.
//

import UIKit
import Foundation
import Toast_Swift

class SurveyLandingPageVC: UIViewController {
    private var pageController: UIPageViewController?
    @IBOutlet weak var pageControl: NMPageControl!
    
    private var surveyViewItems: [UIViewController] = []
    private var currentSurveyPage = 1
    private var surveryCount = 5
    private var surveyModels = [Survey]()
    
    private var leftButton: UIBarButtonItem!
    private var reloadButton: UIBarButtonItem!
    private var rightButton: UIBarButtonItem!

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setupNavigationBar()
        setupPageController()
        ToastManager.shared.isQueueEnabled = true
        getSurveys(forPage: currentSurveyPage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        let angle = CGFloat.pi/2
        pageControl.transform = CGAffineTransform(rotationAngle:  angle).concatenating(CGAffineTransform(scaleX: 2, y: 2))
    }

    // MARK: - View setup
    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        self.pageController?.didMove(toParent: self)
        
        pageControl.numberOfPages = 0
        self.view.bringSubviewToFront(pageControl)
    }

    private func setupNavigationBar(){
        self.title = "SURVEYS"
        
        leftButton = UIBarButtonItem(compactImage: UIImage(named: "left"), target: self, action: #selector(leftButtonClicked), forEvenr: .touchUpInside)
        reloadButton = UIBarButtonItem(compactImage: UIImage(named: "reload"), target: self, action: #selector(reloadButtonClicked), forEvenr: .touchUpInside)
        rightButton = UIBarButtonItem(compactImage: UIImage(named: "right"), target: self, action: #selector(rightButtonClicked), forEvenr: .touchUpInside)
        navigationItem.leftBarButtonItems = [leftButton, reloadButton, rightButton]

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(menuButtonClicked))
    }
    
    // MARK: - API call
    private func getSurveys(forPage: Int) {
        self.view.makeToastActivity(.center)
        APIManager.shared.fetchSurverys(pageNumber: forPage, numebrOfSurverys: surveryCount) { result in
            switch result{
            case .success(let surveys):
                self.processApiSuccess(surveys: surveys, forPage: forPage)
            case .failure(let err):
                switch err {
                case .requestCancelled:
                    break
                default:
                    self.view.makeToast("Something went wrong!")
                }
            }
            self.view.hideToastActivity()
        }
    }
    
    private func processApiSuccess(surveys: [Survey], forPage: Int){
        if surveys.count == 0 {
            self.view.makeToast("No more surveys!!")
            return
        }
        currentSurveyPage = forPage
        (currentSurveyPage == 1) ? (leftButton.isEnabled = false) : (leftButton.isEnabled = true)
        surveyModels.removeAll()
        surveyModels.append(contentsOf: surveys)
        populateItems()
        self.view.makeToast("Surveys \(((forPage-1)*surveryCount)+1) to \(forPage*surveryCount)", position: .center)
        if let firstViewController = surveyViewItems.first {
            self.pageController!.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

// MARK: - Actions
extension SurveyLandingPageVC{
    @objc private func menuButtonClicked(){
        surveryCount += 5
        (surveryCount > 20) ? (surveryCount = 5) : ()
        self.view.hideAllToasts(includeActivity: false, clearQueue: false)
        self.view.makeToast("Survey count per page: \(surveryCount)", position: .center)
    }
    
    @objc private func reloadButtonClicked(){
        currentSurveyPage = 1
        self.surveyModels.removeAll()
        getSurveys(forPage: currentSurveyPage)
    }
    
    @objc private func rightButtonClicked(_ sender: UIButton){
        getSurveys(forPage: currentSurveyPage + 1)
    }
    
    @objc private func leftButtonClicked(_ sender: UIButton){
        getSurveys(forPage: currentSurveyPage - 1)
    }
}

// MARK: - Page controller datasource and delegate
extension SurveyLandingPageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    fileprivate func populateItems() {
        surveyViewItems.removeAll()
        for survey in self.surveyModels {
            let surveyPage = SurveyPageVC(survey: survey)
            surveyViewItems.append(surveyPage)
        }
        pageControl.numberOfPages = self.surveyModels.count
        pageControl.currentPage = 0
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllerIndex = surveyViewItems.firstIndex(of: (pageViewController.viewControllers?.first!)!) else {
            return
        }
        pageControl.currentPage = viewControllerIndex
    }
    
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = surveyViewItems.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        if previousIndex < 0{
            return nil
        }
        return surveyViewItems[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = surveyViewItems.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        if nextIndex >= surveyViewItems.count {
            return nil
        }
        return surveyViewItems[nextIndex]
    }
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return surveyViewItems.count
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = self.pageController?.viewControllers?.first,
            let firstViewControllerIndex = surveyViewItems.firstIndex(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }
}
