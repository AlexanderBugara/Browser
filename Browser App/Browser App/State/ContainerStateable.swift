//
//  ContainerStateable.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit

protocol ContainerStateable {
    var layout: Layouting { get }
    var content: UIViewController { get }
    func update(context: ContainerStateContextProtocol & UIViewController)
}

protocol ContainerStateContextProtocol: AnyObject {
    var state: ContainerStateable? { get set }
}

protocol NavigationButtonsProtocol {
    var leftButton: UIBarButtonItem? { get }
    var rightButton: UIBarButtonItem? { get }
}
