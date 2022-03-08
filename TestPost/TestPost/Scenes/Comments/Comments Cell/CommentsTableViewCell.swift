//
//  CommentsTableViewCell.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CommentsCell"
    static let cellHeight: CGFloat = 250
    @IBOutlet weak var constrainstView: NSLayoutConstraint!
    @IBOutlet weak var contrainstReighView: NSLayoutConstraint!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailConstrainst: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configUI(dataComments : CommentsModels.GetComments.Response) {
        commentsTextView.text   = dataComments.body
        emailLabel.text         = dataComments.email
    }
    
}
