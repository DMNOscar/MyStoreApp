//
//  BaseViewController.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//
import Foundation

import UIKit
class BaseViewController: UIViewController {

    var navigationBarHidden: Bool = false
    var isLoading: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navigationController?.navigationBar.layer.shadowOpacity = 0.1
        navigationController?.navigationBar.layer.shadowRadius = 2
        
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setupNavigationBarItems()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = UIColor.init(named: "BackIcon")
    }


    

    func setupNavigationBarItems() {
        setupRemainingNavItems()
        setupBackTitle()
    }

    private func setupBackTitle() {
        navigationItem.backButtonTitle = ""
        navigationItem.hidesBackButton = false
//        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonTapped))
//        backButton.setBackgroundImage(UIImage(named: "new_back_icon"), for: .normal, barMetrics: .default) //
//        navigationItem.backBarButtonItem = backButton
    }



    func setupRemainingNavItems() {
//        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
//        
//        let titleImageView = UIImageView(image: UIImage(named: "worqout_icn_black"))
//        
//        //let defaults = UserDefaults.standard
//       
//
//        titleImageView.frame = titleView.frame
//        titleImageView.contentMode = .scaleAspectFit
//        titleView.addSubview(titleImageView)
//        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonTapped))
//        backButton.setBackgroundImage(UIImage(named: "new_back_icon"), for: .normal, barMetrics: .default) //
//        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: titleView), backButton]
    }

    
    @objc func backButtonTapped() {
        
        navigationController?.popViewController(animated: true)
    }
    
    
 
}
// FUNCIONES GENERALES

extension BaseViewController {
    
    
    func countLines(in label: UILabel) -> Int {
        
        guard let labelText = label.text else {
            return 0
        }
        
       
        let labelSize = (labelText as NSString).boundingRect(with: CGSize(width: label.frame.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: label.font],
            context: nil)
        
       
        let numberOfLines = Int(ceil(labelSize.height / label.font.lineHeight))
        return numberOfLines
    }
    
    
}
