//
//  RequestManager.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Alamofire

class RequestManager {
    
    private var manager: Alamofire.SessionManager
    
    init(manager: Alamofire.SessionManager = Alamofire.SessionManager.default) {
        self.manager = manager
    }
    
    func request<T: Decodable>(url: URL, method: Alamofire.HTTPMethod, parameters: [String: Any], headers: HTTPHeaders, completion: @escaping (_ result: Result<T>) -> Void) {
        
        let encoding: ParameterEncoding = method == .get ? URLEncoding.queryString : JSONEncoding.default
        
        self.manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let resValue):
                if let resDic = resValue as? [String: Any] {
                    let decoder = JSONDecoder()
                    do {
                        let object = try decoder.decode(T.self, fromDict: resDic)
                        completion(.success(object))
                    } catch {
                        completion(.error(APIError.jsonConversionFailure))
                    }
                } else if let resDic = resValue as? [[String: Any]] {
                    let decoder = JSONDecoder()
                    do {
                        let objects = try decoder.decode(T.self, fromArray: resDic)
                        completion(.success(objects))
                    } catch {
                        completion (.error(APIError.jsonConversionFailure))
                    }
                } else {
                    completion(.error(APIError.jsonParsingFailure))
                }
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
}
