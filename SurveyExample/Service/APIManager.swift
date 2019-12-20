//
//  APIManager.swift
//  SurveyExample
//
//  Created by Abhishek Chaudhari on 20/12/19.
//  Copyright © 2019 Abhishek Chaudhari. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    fileprivate init() { }
    
    func fetchSurverys(pageNumber: Int, numebrOfSurverys: Int, complition: @escaping (Swift.Result<[Survey], GenralError>) -> Void) {
        AuthManager.shared.fetchToken { (result) in
            switch result{
            case .success(let token):
                let parameters = [APIParameters.access_token: token,
                                  APIParameters.page: pageNumber,
                                  APIParameters.per_page: numebrOfSurverys] as [String : Any]
                
                AF.request(NimbleAPI.surveyUrl, method: .get, parameters: parameters).responseJSON { (response) in
                    switch response.result {
                    case .success(_):
                        do {
                            guard let data = response.data,
                                let serveyAraay = try? JSONDecoder().decode([Survey].self, from: data) else {
                                    complition(.failure(.apiFailed))
                                    return
                            }
                            complition(.success(serveyAraay))
                        }
                    case .failure(let error):
                        complition(.failure(.apiFailed))
                        print(error)
                    }
                }
            case .failure(let err):
                complition(.failure(err))
            }
        }
    }
}
