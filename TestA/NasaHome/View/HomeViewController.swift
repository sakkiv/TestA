//
//  ViewController.swift
//  TestA
//
//  Created by vikas shankhdhar on 04/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var collectionDataView: UICollectionView!
    @IBOutlet private weak var headerTitle: UILabel!
    
    lazy var viewModel : NasaHomeDataSource = {
        let viewModel = NasaHomeDataSource(service: Services())
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionShowLoader()
        uiInitilization()
        refreshNasaData()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { (context) in
            self.updateDataSource()
        }
    }
}
//***************** UI Initialization *******///
extension HomeViewController {
    private func uiInitilization(){
        headerTitle.font =  .mainHeaderFont(ofSize: 30)
        initiateRefreshData()
        actionShowLoader()
    }
    func initiateRefreshData()-> Void {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(refreshOptions(sender:)),
                                 for: .valueChanged)
        self.collectionDataView.refreshControl = refreshControl
    }
    @objc private func refreshOptions(sender: UIRefreshControl) {
        self.refreshNasaData()
        sender.endRefreshing()
    }
}
//***************** UIToast *******///
extension HomeViewController {
    private func updateToast(msg:String){
        DispatchQueue.main.async {
            ToastClass.toastView(messsage: msg, view: self.view)
            return
        }
        self.actionHideLoader()
    }
}

//***************** UILoader *******///
extension HomeViewController {
    // show loader
    private func actionShowLoader() {
        ProgressHUD.colorAnimation = .black
        ProgressHUD.colorProgress = .clear
        ProgressHUD.colorBackground = .clear
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.show("")
    }
    // hide loader
    private func actionHideLoader() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            ProgressHUD.dismiss()
        }
    }
}
//***************** Api Fetch Data & Update *******///
extension HomeViewController {
    
    func refreshNasaData(){
        if !Reachability.isConnectedToNetwork() == true {
            self.updateToast(msg: Constants.AlertMessages.InternetError)
            return
        }
        self.getNasaData()
    }
    
    private func getNasaData() {
        self.viewModel.fetchNasaData {
            
        }
        self.viewModel.onSucessFullLoading = { [weak self] status in
            self?.viewModel.sortedData()
            self?.updateDataSource()
            self?.actionHideLoader()
        }
        
        self.viewModel.onErrorHandling = { [weak self] status in
            if let errorStatus = status {
                self?.updateToast(msg: errorStatus)
            }
        }
    }
    // refresh tableView
    private func updateDataSource(){
        DispatchQueue.main.async {
            self.collectionDataView.dataSource = self
            self.collectionDataView.delegate = self
            self.collectionDataView.reloadData()
        }
    }
    
    // Move to details page
    func adddnewUser(index:Int) {
        let bundle = Bundle(identifier: Constants.IdentifierMessages.Bundle)
        let headerView  = NasaSwipeDetailsPage(nibName: Constants.IdentifierMessages.Nib, bundle: bundle)
        headerView.viewModel.filteredData = self.viewModel.sortedArticles
        headerView.viewModel.currentImage = index
        UIView.transition(with: self.view, duration: 0.25, options: [.curveEaseIn], animations: {
            self.addChild(headerView)
            self.view.addSubview(headerView.view)
        }, completion: nil)
        
        headerView.didMove(toParent: self)
        headerView.view.frame = CGRect(x:0, y: 0, width: view.frame.width, height:  view.frame.height)
    }
    
}

//***************** CollectionView Datasource & Delegate Methods *******///
extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MyCollectionViewCell = collectionDataView.dequeueReusableCell(withReuseIdentifier: Constants.IdentifierMessages.HomeIdentifier, for: indexPath) as? MyCollectionViewCell else {
            fatalError(Constants.IdentifierMessages.CollectionCell)
        }
        let movie = viewModel.articleAtIndex(indexPath.item)
        cell.movieItem = movie
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionDataView.deselectItem(at: indexPath, animated: true)
        self.adddnewUser(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio:CGFloat = 154 / 117
        
        let width = collectionView.frame.size.width - (collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right)
        if UIApplication.shared.isLandscape {
            let numberOfColumns:CGFloat = UIDevice.current.isIPad ? 3 : 3.5
            let itemWidth = (width - (10 * (numberOfColumns + 1)))/numberOfColumns
            let height = itemWidth * ratio
            return .init(width:itemWidth, height: height)
        }
        else{
            let numberOfColumns:CGFloat = UIDevice.current.isIPad ? 4.2 : 3
            let itemWidth = (width - (10 * (numberOfColumns + 1)))/numberOfColumns
            return .init(width: itemWidth, height: itemWidth * ratio )
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
