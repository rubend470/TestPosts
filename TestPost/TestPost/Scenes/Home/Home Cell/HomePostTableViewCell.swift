//
//  HomePostTableViewCell.swift
//  TestPost
//
//  Created by Ruben Duarte on 7/3/22.
//

import UIKit

class HomePostTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var photosButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    
    var observableAlbum : ((Int) -> Void)?
    var id = 0
    
    var observableComments :((Int) -> Void)?
    
    static let reuseIdentifier = "HomePostTableViewCell"
    static let cellHeight: CGFloat = 217

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configUI(dataPost : HomeModels.GetHome.Response) {
        titleLabel.text = dataPost.title
        bodyLabel.text = dataPost.body
        id = dataPost.id ?? 0
    }
    
    @IBAction func photoActio(_ sender: Any) {
        observableAlbum?(id)
    }
    @IBAction func commentsAction(_ sender: Any) {
        observableComments?(id)
    }
}
