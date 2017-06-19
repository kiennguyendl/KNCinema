//
//  BaseView.swift
//  KNCinema
//
//  Created by kienND9 on 6/19/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit

class BaseView: UIView {
    var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewFromXIB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViewFromXIB() {
        let bundle = Bundle( for: type(of: self))
        let view = bundle.loadNibNamed(NSStringFromClass(type(of: self)).components(separatedBy: ".").last!, owner: self, options: nil)?.first as? UIView
        guard let contentView = view else { return }
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(contentView)
    }
}
