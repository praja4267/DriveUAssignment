//
//  SocialMediaTableViewCell.swift
//  DriveUAssignment
//
//  Created by Rajasekhar on 28/12/21.
//

import UIKit
protocol SocialMediaTableViewCellDelegate: AnyObject {
    func updateHeightOfCollectionView(_ height: CGFloat)
    func loadDetailViewWithURL(_ urlString: String, screenName: String)
}

class SocialMediaTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var socilaMediadata = [SocialMediaDataModel]()
    private var screenName = ""
    weak var delegate: SocialMediaTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.setBorder(radius: 50, borderWidth: 2, color: .black)
        registerCell()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    
    func registerCell() {
        collectionView.register(UINib(nibName: "SocialMediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SocialMediaCollectionViewCell")
    }
    func configureCell(data: [SocialMediaDataModel], screenName: String) {
        socilaMediadata = data
        self.screenName = screenName
        setCollectionViewHeight()
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socilaMediadata.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialMediaCollectionViewCell", for: indexPath) as! SocialMediaCollectionViewCell
        cell.configureCell(data: socilaMediadata[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 117) // height = width +37
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = socilaMediadata[indexPath.item].redirectUrl
        delegate?.loadDetailViewWithURL(url, screenName: screenName)
    }
    @discardableResult func setCollectionViewHeight() -> CGFloat {
        let numberOfColumns = Int(self.bounds.width/80.0)
        let height = ((socilaMediadata.count % numberOfColumns == 0) ? (socilaMediadata.count/numberOfColumns) * 117 : ((socilaMediadata.count/numberOfColumns) + 1) * 117) + 30
        delegate?.updateHeightOfCollectionView(CGFloat(height))
        return (CGFloat(height))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
