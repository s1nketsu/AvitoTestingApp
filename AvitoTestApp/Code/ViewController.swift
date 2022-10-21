//
//  ViewController.swift
//  AvitoTestApp
//
//  Created by Полищук Александр on 21.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    private lazy var labelText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setConstraints()
        
        networkService.request(url: urlString) { [weak self] (result) in
            switch result {
            case .success(let parsedData):
                self?.parsedData = parsedData
                self?.sortedEmployeeArray = parsedData.company.employees.sorted { $0 < $1 }
                DispatchQueue.main.async {
                    self?.labelText.text = "\(parsedData.company.name) employees"
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Вы получили ошибку:", error)
            }
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func setConstraints() {
        view.backgroundColor = .white
        view.addSubview(labelText)
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            labelText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            labelText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            labelText.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsedData?.company.employees.count ?? 0
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
