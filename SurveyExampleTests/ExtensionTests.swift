//
//  ExtensionTests.swift
//  SurveyExampleTests
//
//  Created by Abhishek Chaudhari on 22/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import XCTest
@testable import SurveyExample

class ExtensionTests: XCTestCase {
    
    func testViewBorder() {
        let border: CGFloat = 10.0
        let cornerRadius: CGFloat = 1.0
        let borderColor = UIColor.white
        
        let view = UIView()
        view.addBorder(borderWidth: border, cornerRadius: cornerRadius, borderColor: borderColor)
        
        XCTAssertTrue(view.layer.borderWidth == border)
        XCTAssertTrue(view.layer.cornerRadius == cornerRadius)
        
        let approximateColor = borderColor.cgColor.converted(to: (view.layer.borderColor?.colorSpace!)!, intent: .defaultIntent, options: nil)
        XCTAssertTrue(view.layer.borderColor == approximateColor)
    }
    
    func testUIColorExtension() {
        let extensionBlack = UIColor.init(red: 0, green: 0, blue: 0)
        let ogBlack = UIColor.black
        let worngBlack = UIColor.white
        
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0

        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        
        ogBlack.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        extensionBlack.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        //compare UIColor black with black using init extension
        XCTAssertTrue(r1 == r2 && b1 == b2 && g1 == g2 && a1 == a2)
        
        worngBlack.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        extensionBlack.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        //compare UIColor white with black using init extension
        XCTAssertFalse(r1 == r2 && b1 == b2 && g1 == g2 && a1 == a2)

        let extensionHexBlack = UIColor.init(hexString: "0000")
        
        ogBlack.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        extensionHexBlack.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        //compare UIColor black with black using init hex extension
        XCTAssertTrue(r1 == r2 && b1 == b2 && g1 == g2 && a1 == a2)
        
        worngBlack.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        extensionHexBlack.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        //compare UIColor white with black using init hex extension
        XCTAssertFalse(r1 == r2 && b1 == b2 && g1 == g2 && a1 == a2)
    }
    
    func testUIBarButtonItem() {
        let barButton = UIBarButtonItem(compactImage: UIImage(named: "left"), target: self, action: #selector(menuButtonClicked), forEvenr: .touchUpInside)
        XCTAssertTrue(barButton.customView?.frame.width == 30.0) //30 is hardcoded in code
        XCTAssertTrue(barButton.customView?.frame.height == 30.0)
        XCTAssertTrue(UIImage(named: "left") == barButton.customView?.largeContentImage)
    }

    func menuButtonClicked() { }
}
