//
//  SocialMediaCollectionViewCell.swift
//  DriveUAssignment
//
//  Created by Rajasekhar on 28/12/21.
//

import UIKit

class SocialMediaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var smImageView: UIImageView!
    @IBOutlet weak var smNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        smImageView.setBorder(radius: 40, borderWidth: 2, color: .black)
        // Initialization code
    }
    func configureCell(data: SocialMediaDataModel) {
        smImageView.kf.setImage(with: URL(string: data.imageUrl))
        smNameLabel.text = data.screenName
    }

}
