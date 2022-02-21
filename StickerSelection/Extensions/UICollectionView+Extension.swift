//
//  UICollectionView+Extension.swift
//  StickerSelection
//
//  Created by Muhammad Khan on 1/18/22.
//

import UIKit

extension UICollectionView {
    func dequeReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            fatalError("Fatal error for reuseable cell at : \(indexPath)")
        }
        return cell
    }
}
