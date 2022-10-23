//
//  NetworkService.swift
//  AvitoTestApp
//
//  Created by Полищук Александр on 21.10.2022.
//
import Foundation
import UIKit

class NetworkService: UIViewController {
    
//    MARK: - Создание параметров

    private var timer = Timer()

    private let oneHour: Double = 3600
    
//    MARK: - Создание URLSession Request
    
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
        setupClearCacheTimer()
    }
    
//    MARK: - Функция для сброса кэша
    
    func setupClearCacheTimer() {
        timer = Timer.scheduledTimer(timeInterval: oneHour, target: self, selector: #selector(clearCacheData), userInfo: nil, repeats: false)
    }

    @objc private func clearCacheData() {
        URLCache.shared.removeAllCachedResponses()
    }
}
