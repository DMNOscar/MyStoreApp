//
//  ViewExtension.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 10/01/25.
//

import UIKit

extension UIView {
    
    func hidde(isHidden: Bool, completition: @escaping() -> Void?) {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.isHidden = isHidden
            completition()
            
        })
    }
    
    func addOverlay(color: UIColor = .black, alpha : CGFloat = 0.8) {
        guard let _ = self.viewWithTag(0xDEADBEEA) else{ return }
        let overlay = UIView()
        overlay.tag = 0xDEADBEEA
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
    }
    
    func applyShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
}
