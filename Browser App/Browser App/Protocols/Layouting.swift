//
//  Layouting.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit

protocol Layouting {
    var container: UIView? { get set }
    var content: UIView? { get set }
    func layout()
    mutating func addContainer(_ conatiner: UIView)
    mutating func addContent(_ content: UIView)
}

extension Layouting {
    mutating func addContainer(_ conatiner: UIView) {
        self.container = conatiner
    }

    mutating func addContent(_ content: UIView) {
        self.content = content
    }
}
