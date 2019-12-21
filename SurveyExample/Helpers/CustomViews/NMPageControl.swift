//
//  CustomePageControl.swift
//  SurveyExample
//
//  Created by Abhishek Chaudhari on 21/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import Foundation
import UIKit

class NMPageControl: UIPageControl {
    
    @IBInspectable var currentIndicatorImage: UIImage? {
      didSet {
        updateBullets()
      }
    }
    
    @IBInspectable var otherPagesIndicatorImage: UIImage? {
        didSet {
            updateBullets()
        }
    }
    
    override var numberOfPages: Int {
        didSet {
            updateBullets()
        }
    }
    
    override var currentPage: Int {
        didSet {
            updateBullets()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        pageIndicatorTintColor = .clear
        currentPageIndicatorTintColor = .clear
        clipsToBounds = false
    }
        
    private func updateBullets() {
        for (index, subview) in subviews.enumerated() {
            let imageView: UIImageView
            if let existingImageview = getImageView(forSubview: subview) {
                imageView = existingImageview
            } else {
                imageView = UIImageView(image: otherPagesIndicatorImage)
                
                imageView.center = subview.center
                subview.addSubview(imageView)
                subview.clipsToBounds = false
            }
            imageView.image = currentPage == index ? currentIndicatorImage : otherPagesIndicatorImage
        }
    }
    
    private func getImageView(forSubview view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView {
            return imageView
        } else {
            let view = view.subviews.first { (view) -> Bool in
                return view is UIImageView
                } as? UIImageView
            
            return view
        }
    }
}
