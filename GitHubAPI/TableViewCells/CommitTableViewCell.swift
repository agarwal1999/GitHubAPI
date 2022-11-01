//
//  CommitTableViewCell.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 01/11/22.
//

import UIKit

class CommitTableViewCell: UITableViewCell {
    
    static let identifier = "CommitTableViewCell"
    
    var messageLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    var authorLabel: UILabel = {
        var label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMessageLabel()
        configureAuthorLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureMessageLabel() {
        contentView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
            messageLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  10),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -10),
        ])
    }
    
    func configureAuthorLabel() {
        contentView.addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  10),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -10),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
