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
        self.cancelPreviousSurveryRequest()
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
                            guard let surveyArray = response.data?.processData(classType: [Survey].self) as? [Survey] else {
                                complition(.failure(.apiFailed))
                                return
                            }
                            complition(.success(surveyArray))
                        }
                    case .failure(let error):
                        if let errorString = error.errorDescription, errorString.contains("cancelled") {
                            complition(.failure(.requestCancelled))
                        }else{
                            complition(.failure(.apiFailed))
                        }
                    }
                }
            case .failure(let err):
                complition(.failure(err))
            }
        }
    }
    
    private func cancelPreviousSurveryRequest(){
        Alamofire.Session.default.session.getAllTasks { (dataTasks) in
            dataTasks.forEach {
                if let urlString = $0.originalRequest?.url?.absoluteString{
                    if (urlString.contains(NimbleAPI.surveyUrl)) {
                        $0.cancel()
                    }
                }
            }
        }
    }
}
