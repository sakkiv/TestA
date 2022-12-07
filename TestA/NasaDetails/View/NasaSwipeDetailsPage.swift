//
//  ImageSwipeVc.swift
//  TestA
//
//  Created by vikas shankhdhar on 05/12/22.
//

import Foundation
import UIKit

class NasaSwipeDetailsPage: UIViewController {
    
    @IBOutlet weak var headerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pageImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var descItem: UITextView!
    var viewModel: ImageSwipeViewModel = ImageSwipeViewModel()
    var movieItem: NasaHomeModel? {
        didSet {
            DispatchQueue.main.async {
                if let model = self.movieItem {
                    if let url = model.url {
                        DispatchQueue.main.async {
                            self.pageImageView.cacheImageForCollection(url, placeHolder: UIImage(named: "placeholder"))
                        }
                        self.pageImageView.contentMode = .scaleToFill
                    }
                    if let title = model.title{
                        self.headerTitle.text = title
                    }
                    
                    if let dateTitle = model.date{
                        self.dateTitle.text = dateTitle
                    }
                    
                    if let descData = model.explanation {
                        self.descItem.text = descData
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSwipe()
        self.setUIElements()
        self.viewModel.selectedImage = self.viewModel.currentImage
        self.getNasaData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//***************** UIElements *******///
extension NasaSwipeDetailsPage{
    private func setUIElements(){
        DispatchQueue.main.async {
            self.descItem.textColor = UIColor(named: "SecondaryLabel")
            self.pageImageView.backgroundColor = .clear
            self.pageImageView.layer.cornerRadius = 15
            self.pageImageView.clipsToBounds = true
            self.descItem.isEditable = false
            self.descItem.text = ""
            self.backButton.setTitle("Back", for: .normal)
            self.headerButton.setTitle("Refresh", for: .normal)
            self.backButton.titleLabel?.font = .subHeaderRegularFont(ofSize: 16)
            self.headerButton.titleLabel?.font = .subHeaderRegularFont(ofSize: 16)
            self.headerTitle.font = .subHeaderBoldFont(ofSize: 12)
            self.dateTitle.font = .subHeaderRegularFont(ofSize: 16)
            self.descItem.font =  .subHeaderRegularFont(ofSize: 16)
            self.backButton.setButtonUI()
            self.headerButton.setButtonUI()
        }
    }
    
}

extension NasaSwipeDetailsPage{
    //***************** get Initial Data  *******///
    private func getNasaData() {
        self.viewModel.articleAtIndex(){   data in
            self.movieItem = data
            self.actionHideLoader()
        }
    }
    //***************** Add Swipe Gesture  *******///
    private func setSwipe(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.pageImageView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.pageImageView.addGestureRecognizer(swipeLeft)
    }
    //***************** UILoader *******///
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            ProgressHUD.dismiss()
        }
    }
}

extension NasaSwipeDetailsPage{
    @IBAction  func refreshSource(){
        self.actionShowLoader()
        self.viewModel.currentImage = self.viewModel.selectedImage
        self.viewModel.articleAtIndex(){   data in
            self.movieItem = data
            self.actionHideLoader()
        }
    }
    
    @IBAction func removeUsr(_ sender: UIButton) {
        UIView.transition(with: self.view, duration: 0.25, options: [.curveEaseOut], animations: {
            self.view.removeFromSuperview()
        }, completion: nil)
    }
}

extension NasaSwipeDetailsPage{
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                self.actionShowLoader()
                self.viewModel.articleSwipeLeftAtIndex(){_ in
                    self.getNasaData()
                }
                
                
            case UISwipeGestureRecognizer.Direction.right:
                self.actionShowLoader()
                self.viewModel.articleSwipeRightAtIndex(){_ in
                    self.getNasaData()
                }
            default:
                break
            }
        }
    }
}
