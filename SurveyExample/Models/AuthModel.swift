//
//  AuthModel.swift
//  SurveyExample
//
//  Created by Abhishek Chaudhari on 19/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import Foundation

struct AuthModel: Decodable {
    let access_token, token_type: String?
    let expires_in, created_at: Double?
}
