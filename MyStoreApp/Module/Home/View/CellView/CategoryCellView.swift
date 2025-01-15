//
//  CategoryCellView.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 15/01/25.
//

import UIKit

class CategoryCellView : UICollectionViewCell{
    
    
    @IBOutlet weak var nameCategoryLbl: UILabel!
    
    class var reuseIdentifier: String {
        return "CategoryCellViewIdentifier"
    }

    class var nibName: String {
        return "CategoryCellView"
    }

    override var isSelected: Bool {
            didSet {
                contentView.backgroundColor = isSelected ? .black :UIColor(named: "CategoryCell")
                nameCategoryLbl.textColor = isSelected ? .white : .black
            }
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupCell()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupCell()
        }
    
    func configureCell(cateoryName: String) {
        
        nameCategoryLbl.text = cateoryName
        
    }
    
    private func setupCell() {
        contentView.backgroundColor = UIColor(named: "CategoryCell")
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    }
}
