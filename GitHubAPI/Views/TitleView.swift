//
//  TitleVIew.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 02/11/22.
//

import UIKit

class TitleView: UIView {
    
    let label = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        configureImageView()
        configureLabel()
    }
    
    func setValues(labelText: String?, imageURL: String?) {
        label.text = labelText
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
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        imageView.layer.masksToBounds = true
    }
    
    func configureLabel() {
        label.text = "Saurabh Agarwal"
        label.font = UIFont.systemFont(ofSize: 16)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
        ])
    }
}
