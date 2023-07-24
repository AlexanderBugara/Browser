//
//  CellModeledView.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit

protocol CellModeledView: AnyObject, UICollectionViewCell {
    typealias Presenting = (UIView & CellModeledView)

    static var className: String { get }
    func setModel(_ model: CollectionViewElement?)
}

extension CellModeledView {
    static var className: String {
        String(describing: self)
    }
}

protocol CollectionViewElement {
    typealias Presenting = CellModeledView.Presenting.Type
    var presenting: Presenting { get }
    var id: String { get }
}

