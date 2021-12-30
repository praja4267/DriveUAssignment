//
//  OffersTableViewCell.swift
//  DriveUAssignment
//
//  Created by Rajasekhar on 28/12/21.
//

import UIKit

class OffersTableViewCell: UITableViewCell {
    @IBOutlet weak var offerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.offerImageView.setCornerRadous(20)
        self.offerImageView.setBorderWidth(2, color: UIColor.black)
    }
    func configureCell(data: OffersDataModel) {
        offerImageView.kf.setImage(with: URL(string: data.image))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
