//
//  TitleVIew.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 02/11/22.
//

import UIKit

class TitleView: UIView {
    
    private lazy var nameLabel = UILabel()
    private lazy var locationLabel = UILabel()
    private lazy var emailLabel = UILabel()
    private lazy var companyLabel = UILabel()
    private lazy var imageView = UIImageView()
    private lazy var gradient: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]//Colors you want to add
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
       return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradient)
        gradient.frame = bounds
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        configureImageView()
        configureNameLabel()
        configureEmailLabel()
        configureLocationLabel()
        configureCompanyLabel()
    }
    
    func setValues(labelText: String?, imageURL: String?) {
        nameLabel.text = labelText
        guard let url = URL(string: imageURL ?? "") else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }
        }
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2
    }
    
    func configureImageView() {
        addSubview(imageView)
        imageView.image = UIImage(systemName: "person.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        imageView.layer.masksToBounds = true
    }
    
    func configureNameLabel() {
        nameLabel.text = "Saurabh Agarwal"
        nameLabel.font = UIFont.systemFont(ofSize: 24)
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func configureEmailLabel() {
        emailLabel.text = "Email: saurabh.agarwal@mxplayer.in"
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    func configureLocationLabel() {
        locationLabel.text = "Location: Jaipur, Rajasthan, India"
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    func configureCompanyLabel() {
        companyLabel.text = "Company: MX Player"
        companyLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(companyLabel)
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            companyLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            companyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}
