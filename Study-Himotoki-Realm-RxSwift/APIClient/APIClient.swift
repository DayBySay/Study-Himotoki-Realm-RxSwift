//
//  APIClient.swift
//  Study-Himotoki-Realm-RxSwift
//
//  Created by Takayuki Sei on 2018/06/23.
//  Copyright © 2018年 Takayuki Sei. All rights reserved.
//

import Foundation
import Alamofire
import Himotoki

struct URLAPIRequest: MyAPIRequest {
    typealias RequestDataType = URL
    typealias ResponseDataType = [Repo]
    
    func makeRequest(from data: URL) throws -> URLRequest {
        return URLRequest(url: data)
    }
    
    func parseResponse(data: Data) throws -> [Repo] {
        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        return try! decodeArray(json)
    }
}

protocol MyAPIRequest {
    associatedtype RequestDataType
    associatedtype ResponseDataType
    
    func makeRequest(from data: RequestDataType) throws -> URLRequest
    func parseResponse(data: Data) throws -> ResponseDataType
}

class MyAPIRequestLoader<T: MyAPIRequest> {
    let apiRequest: T
    let apiClient: APIClientProtocol
    
    init(apiRequest: T, apiClient: APIClientProtocol) {
        self.apiRequest = apiRequest
        self.apiClient = apiClient
    }
    
    func loadAPIRequest(requestData: T.RequestDataType, completion: @escaping (T.ResponseDataType?, Error?) -> Void) {
        do {
            let urlRequest = try apiRequest.makeRequest(from: requestData)
            apiClient.request(urlRequest: urlRequest) { (data, error) in
                guard let data = data else { return completion(nil, error)}
                do {
                    let parsedResponse = try self.apiRequest.parseResponse(data: data)
                    completion(parsedResponse, nil)
                } catch {
                    completion(nil, error)
                }
            }
        } catch {
            return completion(nil, error)
        }
    }
}

protocol APIClientProtocol {
    func request(urlRequest: URLRequest, completion: @escaping (_ responseData: Data?, _ error: Error?) -> Void)
}

struct AlamofireClient: APIClientProtocol {
    func request(urlRequest: URLRequest, completion: @escaping (Data?, _ error: Error?) -> Void) {
        Alamofire.request(urlRequest).responseData { (response) in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
