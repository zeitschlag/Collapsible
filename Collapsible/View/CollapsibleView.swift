//
//  CollapsibleView.swift
//  Collapsible
//
//  Created by Nathan Mattes on 28.09.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import UIKit

@objc protocol CollapsibleViewDelegate {
    @objc optional var collapsedContentHeight: CGFloat { get }
    @objc optional var contentHeight: CGFloat { get }
    func collapseButtonTapped(_ sender: Any)
}

enum CollapsibleViewState {
    case Collapsed
    case Expaneded
}

class CollapsibleView: UIView {
    
    @IBOutlet var view: UIView!
    
    //MARK: - Header
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var collapseButton: UIButton!
    
    //MARK: - Content
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    
    var collapsedHeight = 42.0
    var animationDuration: TimeInterval = 0.2
    
    var state: CollapsibleViewState = .Collapsed
    
    var delegate: CollapsibleViewDelegate?
    
    @IBAction func collapseButtonTapped(_ sender: Any) {
        
        switch self.state {
        case .Collapsed:
            self.state = .Expaneded
        case .Expaneded:
            self.state = .Collapsed
        }
        
        updateView()
        self.delegate?.collapseButtonTapped(sender)
    }
    
    func updateView() {
        
        switch self.state {
        case .Collapsed:
            if let contentHeight = self.delegate?.collapsedContentHeight {
                self.contentHeightConstraint.constant = contentHeight
            } else {
                self.contentHeightConstraint.constant = 0
            }
        case .Expaneded:
            if let contentHeight = self.delegate?.contentHeight {
                self.contentHeightConstraint.constant = contentHeight
            } else {
                self.contentHeightConstraint.constant = 300
            }
        }
        
        UIView.animate(withDuration: self.animationDuration) {
            self.superview?.layoutIfNeeded()
        }
    }
    
}
