//
//  ViewController.swift
//  DriveUAssignment
//
//  Created by Rajasekhar on 28/12/21.
//

import UIKit

class FeedsViewController: BaseViewController {
    @IBOutlet weak var feedsTableView: UITableView!
    private var feedsViewModel = FeedsViewModel()
    var socialViewHeight: CGFloat = 100
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    func setupUI() {
        feedsTableView.dataSource = self
        feedsTableView.delegate = self
        self.feedsTableView.registerCell(type: HeaderTableViewCell.self)
        self.feedsTableView.registerCell(type: SocialMediaTableViewCell.self)
        self.feedsTableView.registerCell(type: OffersTableViewCell.self)
        feedsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableViewData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshTableViewData(_ sender: Any) {
        self.feedsViewModel.callService()
        fetchData()
        self.refreshControl.endRefreshing()
    }
    
    func fetchData() {
        showLoader()
        self.feedsViewModel.feedsLoaded = { [weak self] (_, success) in
            self?.hideLoader()
            if success {
                self?.feedsTableView.reloadData()
            } else {
                let alert = getAlert("API Error", message: "")
                self?.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.feedsTableView.beginUpdates()
        self.feedsTableView.endUpdates()
    }
}



extension FeedsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.feedsViewModel.numberOrRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: return createHeaderCell(tableView: tableView, indexPath: indexPath)
        case 1: return createSocialMediaCell(tableView: tableView, indexPath: indexPath)
        case 2: return createOffersCell(tableView: tableView, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if feedsViewModel.feedsList == nil {return nil }
        if section == 0 { return nil }
        return creteLabelView(for: section)
    }
    
    func creteLabelView(for section: Int) -> UIView? {
        let titleLabel = UILabel(frame: CGRect(x: 15, y: 15, width: self.view.bounds.width - 30, height: 60))
        titleLabel.text = feedsViewModel.getHeaderTitleForSection(section: section)
        titleLabel.font = .boldSystemFont(ofSize: 20)
        return titleLabel
    }
    
    func createHeaderCell(tableView: UITableView, indexPath: IndexPath) -> HeaderTableViewCell {
        guard let cell = tableView.dequeueCell(withType: HeaderTableViewCell.self) as? HeaderTableViewCell, let carModel = feedsViewModel.getCarModel() else { return HeaderTableViewCell()}
        cell.selectionStyle = .none
        cell.configureCell(data: carModel)
        return cell
    }
    
    func createSocialMediaCell(tableView: UITableView, indexPath: IndexPath) -> SocialMediaTableViewCell {
        guard let cell = tableView.dequeueCell(withType: SocialMediaTableViewCell.self) as? SocialMediaTableViewCell, let socialMediaModel = feedsViewModel.getSocialMediaDataModel() else { return SocialMediaTableViewCell()}
        cell.selectionStyle = .none
        cell.delegate = self
        cell.configureCell(data: socialMediaModel.features, screenName: socialMediaModel.screen)
        return cell
    }
    
    func createOffersCell(tableView: UITableView, indexPath: IndexPath) -> OffersTableViewCell {
        guard let cell = tableView.dequeueCell(withType: OffersTableViewCell.self) as? OffersTableViewCell, let offer = feedsViewModel.getOffersModel(index: indexPath.row) else { return OffersTableViewCell()}
        cell.selectionStyle = .none
        cell.configureCell(data: offer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 125
        case 1: return socialViewHeight
        case 2:
            let widthRatio = self.view.bounds.width/22.0
            let actualHeight = widthRatio * 10
            return actualHeight
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1, 2: return 60
        default: return 0.1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            guard let name = feedsViewModel.getOffersModel(index: indexPath.row)?.name else { return }
            let alert = getAlert(name, message: "")
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension FeedsViewController: SocialMediaTableViewCellDelegate {
    func loadDetailViewWithURL(_ urlString: String, screenName: String) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.urlString = urlString
        detailVC.title = screenName
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func updateHeightOfCollectionView(_ height: CGFloat) {
        socialViewHeight = height
    }
    
}
