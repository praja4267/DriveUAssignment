//
//  HeaderTableViewCell.swift
//  DriveUAssignment
//
//  Created by Rajasekhar on 28/12/21.
//

import UIKit
import Kingfisher

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carMaker: UILabel!
    @IBOutlet weak var carRegNumber: UILabel!
    @IBOutlet weak var carType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        carImage.setBorder(radius: 10, borderWidth: 1, color: .blue)
        self.contentView.setCornerRadous(20)
        self.contentView.setBorderWidth(2, color: UIColor.black)
    }
    
    func configureCell(data: CarDataModel) {
        carMaker.text = data.make
        carRegNumber.text = data.regNo
        carType.text = "\(data.fuelType) - \(data.transmission)"
        carImage.kf.setImage(with: URL(string: data.image))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
