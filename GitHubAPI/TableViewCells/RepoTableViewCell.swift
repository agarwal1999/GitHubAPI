//
//  RepoTableViewCell.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 31/10/22.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    static let identifier = "RepoTableViewCell"
    
    var myLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel() {
        contentView.addSubview(myLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
            myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -10),
            myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  10),
            myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -10),
        ])
    }
    
    func configure(with model: Repository) {
        myLabel.text = "\(model.name) and \(model.language)"
    }
}
