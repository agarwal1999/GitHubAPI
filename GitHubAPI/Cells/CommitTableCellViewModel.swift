//
//  CommitTableViewCellViewModel.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 01/11/22.
//

import UIKit

class CommitTableCellViewModel: NSObject {
    private var message: String
    private var author: Author?
    
    override init() {
        self.message = ""
        self.author = nil
    }
    
    init(commitData: Commit) {
        self.message = commitData.message
        self.author = commitData.author
    }
    
    func configureCell(cell: CommitTableCell) {
        cell.messageLabel.text = "\(self.message)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = dateFormatter.date(from: self.author?.date ?? "")
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        let printDate = dateFormatter.string(from: date ?? Date())
        
        cell.authorLabel.text = "\(self.author?.name ?? "Not Known") committed on \(printDate)"
    }
}
