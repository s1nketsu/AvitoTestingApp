//
//  ViewController.swift
//  AvitoTestApp
//
//  Created by Полищук Александр on 21.10.2022.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    //    MARK: - Инициализация параметров и UI элементов
    
    private let networkService = NetworkService()
    private var parsedData: Model? = nil
    private var sortedEmployeeArray = [Employees]()
    private let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    private let cellIdentifier = "cellIdentifier"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    
    //    MARK: - Жизненный цикл приложения
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
        setConstraints()
        getData()
    }
    
    //    MARK: - Создание методов
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    fileprivate func getData() {
        networkService.request(url: urlString) { [weak self] (result) in
            switch result {
            case .success(let parsedData):
                self?.parsedData = parsedData
                self?.sortedEmployeeArray = parsedData.company.employees.sorted { $0 < $1 }
                DispatchQueue.main.async {
                    self?.title = "\(parsedData.company.name) employees"
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                self?.alertNoInternet(error: error)
                print(error.localizedDescription)
            }
        }
    }
    
    private func setConstraints() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}


// MARK: - UITableViewDelegate и UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedEmployeeArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
        let model = sortedEmployeeArray
        cell.configure(emplyeesArray: model, indexPath: indexPath)
        return cell
    }
}
