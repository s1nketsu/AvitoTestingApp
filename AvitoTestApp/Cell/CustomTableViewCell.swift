//
//  CustomTableViewCell.swift
//  AvitoTestApp
//
//  Created by Полищук Александр on 21.10.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
//    MARK: - Инициализация UI элеметов
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        label.textAlignment = .left
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textAlignment = .right
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var skillsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textAlignment = .left
        label.tintColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//     MARK: - Инициализаторы
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Реализация методов конфигурации ячейки и setConstraints
    
    func configure(emplyeesArray: [Employees], indexPath: IndexPath) {
        nameLabel.text = emplyeesArray[indexPath.row].name
        phoneLabel.text! = "Phone number: \(emplyeesArray[indexPath.row].phone_number)"
        skillsLabel.text! = "Skills: \(emplyeesArray[indexPath.row].skills.joined(separator: ", "))"
        logoImageView.image = UIImage(named: "logo")
    }
    
    private func setConstraints() {
        self.addSubview(logoImageView)
        self.addSubview(nameLabel)
        self.addSubview(phoneLabel)
        self.addSubview(skillsLabel)
        
        NSLayoutConstraint.activate([
            
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            logoImageView.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 5),
            nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            phoneLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            phoneLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            phoneLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            skillsLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            skillsLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 5),
            skillsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            skillsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
