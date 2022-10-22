//
//  NetworkService.swift
//  AvitoTestApp
//
//  Created by Полищук Александр on 21.10.2022.
//
import Foundation
import UIKit

//MARK: - Request

class NetworkService: UIViewController {

    let oneHour: Double = 3600
    
    func request(url: String, completion: @escaping (Result<Model, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    print(error)
                    return
                }
            }
            
            guard let data = data else { return }
            
            do {
                let parsedData = try JSONDecoder().decode(Model.self, from: data)
                completion(.success(parsedData))
            } catch let jsonError{
                print("Failure", jsonError)
                completion(.failure(jsonError))
            }
        }.resume()
        URLCache.shared.removeCachedResponses(since: Date.init(timeIntervalSinceNow: oneHour))
    }
}


