//
//  AuthManager.swift
//  SurveyExample
//
//  Created by Abhishek Chaudhari on 19/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import Foundation
import KeychainSwift
import Alamofire

fileprivate struct HardCoded {
    static let grant_type = "password"
    static let username = "carlos@nimbl3.com"
    static let password = "antikera"
}

class AuthManager {
    
    static let shared = AuthManager()
    
    fileprivate let keychain = KeychainSwift()
    
    fileprivate init() { }
    
    //method to retrive token either from local valid data or using Auth
    func fetchToken(complition: @escaping (Swift.Result<String, GenralError>) -> Void) {
        if isTokenValid() {
            guard let token = keychain.get(Keychain.token) else {
                complition(.failure(.badOptional))
                return
            }
            complition(.success(token))
        }else{
            let parameters = [AuthParameters.grant_type: HardCoded.grant_type,
                              AuthParameters.username: HardCoded.username,
                              AuthParameters.password: HardCoded.password]
            
            AF.request(NimbleAPI.authUrl, method: .post, parameters: parameters).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        guard let data = response.data,
                            let authObject = try? JSONDecoder().decode(AuthModel.self, from: data),
                            let accessToken = authObject.access_token else {
                                if let json = value as? [String: Any], let errorString = json["error"] as? String {
                                    if errorString == AuthError.invalidGrant{
                                        complition(.failure(.invalidGrant))
                                    }else{
                                        complition(.failure(.authFailed))
                                    }
                                }
                                return
                        }
                        let _ = self.storeTokenInfo(authObject: authObject)
                        complition(.success(accessToken))
                    }
                case .failure(let error):
                    complition(.failure(.authFailed))
                    print(error)
                }
            }
        }
    }
    
    //stores token and expiry in keyhain
    fileprivate func storeTokenInfo(authObject: AuthModel) -> Bool{
        guard let timestamp = authObject.created_at, let expirsInTimestamp = authObject.expires_in else {
            return false
        }
        let expiryTimestamp = String(timestamp + expirsInTimestamp - 60) //60 seconds of window
        
        if keychain.set(authObject.access_token ?? "", forKey: Keychain.token) &&
            keychain.set(expiryTimestamp, forKey: Keychain.expirationDate) {
            return true
        }
        return false
    }
    
    //validates token with current time
    fileprivate func isTokenValid() -> Bool{
        if let date = keychain.get(Keychain.expirationDate){
            if date.isEmpty{
                return false
            }else{
                guard let timeInterval = Double(date) else {
                    return false
                }
                let expiryDate = Date(timeIntervalSince1970: timeInterval)
                
                switch expiryDate.compare(Date()) {
                case .orderedAscending, .orderedSame:
                    keychain.clear()
                    return false
                case .orderedDescending:
                    return true
                }
            }
        }
        return false
    }
    
    //clear local sessios
    fileprivate func resetKeychain(){
        keychain.clear()
    }
}
