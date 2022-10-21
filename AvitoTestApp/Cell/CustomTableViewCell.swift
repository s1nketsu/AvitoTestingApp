//
//  CustomTableViewCell.swift
//  AvitoTestApp
//
//  Created by Полищук Александр on 21.10.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Avenir Next Bold", size: 20)
        label.textAlignment = .left
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone number: "
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textAlignment = .right
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var skillsLabel: UILabel = {
        let label = UILabel()
        label.text = "Skills: "
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textAlignment = .left
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(model: Model, indexPath: IndexPath) {
        nameLabel.text = model.company.employees[indexPath.row].name
        phoneLabel.text! += model.company.employees[indexPath.row].phone_number
        skillsLabel.text! += model.company.employees[indexPath.row].skills.joined(separator: ", ")
        
    }
    
    private func setConstraints() {
        self.addSubview(nameLabel)
        self.addSubview(phoneLabel)
        self.addSubview(skillsLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            phoneLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            phoneLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            phoneLabel.heightAnchor.constraint(equalToConstant: 30),
            
            skillsLabel.heightAnchor.constraint(equalToConstant: 30),
            skillsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            skillsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            skillsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        
        ])
    }
    
    
}