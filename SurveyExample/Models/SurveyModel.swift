//
//  SurveyModel.swift
//  SurveyExample
//
//  Created by Abhishek Chaudhari on 19/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import Foundation

// MARK: - Element
struct Survey: Decodable {
    let id, title, description, cover_image_url: String?
}
