//
//  CustomPickerUI.swift
//  ICADKImagePickerControllerDemo
//
//  Created by Terenze Pro on 04/12/2016.
//  Copyright © 2016 ZhangAo. All rights reserved.
//

import UIKit

class CustomPickerUI: ICADKImagePickerControllerDefaultUIDelegate {
    
    override func imagePickerControllerCheckedNumberColor() -> UIColor {
        return .white
    }
    
    override func selectedLabelPosition() -> DKCheckedLabelPosition {
        return .bottomRight
    }
    
    override func shouldUseCheckedImage() -> Bool {
        return false
    }
    
    override func imagePickerControllerCollectionViewBackgroundColor() -> UIColor {
        return .black
    }
    
    override func layoutForImagePickerController(_ imagePickerController: ICADKImagePickerController) -> UICollectionViewLayout.Type {
        return CustomGridLayout.self
    }
}


open class CustomGridLayout: UICollectionViewFlowLayout {
    
    open override func prepare() {
        super.prepare()
        
        let minItemWidth: CGFloat = 100
        
        let interval: CGFloat = 1
        self.minimumInteritemSpacing = interval
        self.minimumLineSpacing = interval
        
        let contentWidth = self.collectionView!.bounds.width
        
        let itemCount = Int(floor(contentWidth / minItemWidth))
        var itemWidth = (contentWidth - interval * (CGFloat(itemCount) - 1)) / CGFloat(itemCount)
        let actualInterval = (contentWidth - CGFloat(itemCount) * itemWidth) / (CGFloat(itemCount) - 1)
        itemWidth += actualInterval - interval
        
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        self.itemSize = itemSize
    }
    
}
