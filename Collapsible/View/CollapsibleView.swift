//
//  CollapsibleView.swift
//  Collapsible
//
//  Created by Nathan Mattes on 28.09.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import UIKit

protocol CollapsibleViewDelegate {
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
    @IBOutlet weak var contentView: UIView! // This thing must conform to a protocol to set the height
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    
    var collapsedHeight = 42.0
    var animationDuration: TimeInterval = 0.2
    
    var state: CollapsibleViewState = .Collapsed
    
    var delegate: CollapsibleViewDelegate?
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }

    
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
            self.contentHeightConstraint.constant = 0
        case .Expaneded:
            self.contentHeightConstraint.constant = 300
        }
        
        UIView.animate(withDuration: self.animationDuration) {
            self.superview?.layoutIfNeeded()
        }
    }
    
}
