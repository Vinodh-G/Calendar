//
//  CalendarMonthLayout.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/11/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import Foundation
import UIKit

class CalendarMonthLayout: UICollectionViewFlowLayout {

    var layoutInfoCache : [IndexPath:UICollectionViewLayoutAttributes] = [:]

    override func prepare() {
        super.prepare()
        layoutInfoCache.removeAll()
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)?.map { attributes in
            
            var elementAttributes = layoutInfoCache[attributes.indexPath]
            if elementAttributes == nil {
                elementAttributes = UICollectionViewLayoutAttributes(forCellWith: attributes.indexPath) //attributes.copy() as? UICollectionViewLayoutAttributes
                layoutInfoCache[elementAttributes!.indexPath] = elementAttributes
            }
            self.applyMonthLayoutAttributes(attributes: elementAttributes!)
            return elementAttributes!
        }
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let attributes = super.layoutAttributesForItem(at: indexPath) {
            let attri = attributes.copy() as! UICollectionViewLayoutAttributes
            self.applyMonthLayoutAttributes(attributes: attri)
            return attri
        }
        return nil
    }
    
    func applyMonthLayoutAttributes(attributes:UICollectionViewLayoutAttributes) {
        
        guard attributes.representedElementKind == nil else { return }
        guard let collectionView = collectionView else { return }
        
        var cellXOffset = CGFloat(attributes.indexPath.item % 7) * itemSize.width
        var cellYOffset = CGFloat(attributes.indexPath.item / 7) * itemSize.height
        
        let offset = CGFloat(attributes.indexPath.section)
        switch scrollDirection {
            case .horizontal:
            cellXOffset += offset * collectionView.frame.size.width
            case .vertical :
            cellYOffset += offset * collectionView.frame.size.height
        }
        
        attributes.frame = CGRect(x: cellXOffset,
                                  y: cellYOffset,
                                  width: itemSize.width,
                                  height: itemSize.height)
    }
}
