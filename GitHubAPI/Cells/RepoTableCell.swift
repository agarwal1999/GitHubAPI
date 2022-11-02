//
//  RepoTableViewCell.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 31/10/22.
//

import UIKit

class RepoTableCell: UITableViewCell {

    static let identifier = "RepoTableViewCell"
    
    var repoNameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        return label
    }()
    
    var langLabel: UILabel = {
        var label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureNameLabel()
        configureLangLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureNameLabel() {
        contentView.addSubview(repoNameLabel)
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            repoNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
            repoNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  10),
            repoNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -10),
            repoNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
        ])
    }
    
    func configureLangLabel() {
        contentView.addSubview(langLabel)
        langLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            langLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 10),
            langLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  10),
            langLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -10),
            langLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
