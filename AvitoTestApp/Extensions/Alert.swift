//
//  Alert.swift
//  AvitoTestApp
//
//  Created by Полищук Александр on 22.10.2022.
//

import UIKit

extension ViewController {
    
//    MARK: - Создание alert
    
    func alertNoInternet(error: Error) {
        let alert = UIAlertController(title: "Connection Error", message: "\(error.localizedDescription) Please restart the App", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
