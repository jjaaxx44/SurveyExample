//
//  Constants.swift
//  SurveyExample
//
//  Created by Abhishek Chaudhari on 19/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import Foundation
import UIKit

struct NimbleAPI {
    private static let base = "https://nimble-survey-api.herokuapp.com"
    private struct Path {
        static let surveys = "/surveys.json"
        static let authToken = "/oauth/token"
    }
    static let surveyUrl = base + Path.surveys
    static let authUrl = base + Path.authToken
}

struct APIParameters {
    static let page = "page"
    static let per_page = "per_page"
    static let access_token = "access_token"
}

struct AuthParameters {
    static let grant_type = "grant_type"
    static let username = "username"
    static let password = "password"
}

struct AuthError {
    static let invalidGrant = "invalid_grant"
}

struct Keychain {
    static let expirationDate = "expirationDate"
    static let token = "token"
}

struct AppColors {
    static let navBarColor = UIColor.init(hexString: "101C37")
    static let navBarTitleColor = UIColor.white
}

enum GenralError: Error {
    case badOptional
    case authFailed
    case invalidGrant
    case apiFailed
}
