//
//  AlbumCollectionViewCell.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AlbumCollectionViewCell"
    static let cellHeight: CGFloat = 270
    @IBOutlet weak var photoImageView: LHImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configUI(dataPhoto: AlbumModels.GetAlbum.Response){
        photoImageView.setImage(urlString: dataPhoto.thumbnailUrl, imageView: photoImageView)
    }
    
}
