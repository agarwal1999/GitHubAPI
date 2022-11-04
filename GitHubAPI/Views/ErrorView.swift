//
//  ErrorView.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 04/11/22.
//

import UIKit

class ErrorView: UIView {
    private lazy var myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    var gradient: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]//Colors you want to add
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = CGRect.zero
       return gradientLayer
    }()
    
    init() {
        super.init(frame: .zero)
        gradient.frame = bounds
        layer.addSublayer(gradient)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func addErrorText(errorText: String?) {
        myLabel.text = errorText
    }
    
    func configureLabel() {
        addSubview(myLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            myLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
