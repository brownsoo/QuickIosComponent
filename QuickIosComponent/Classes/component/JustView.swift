//
//  BaseView.swift
//  StudioBase
//
//  Created by hanhyonsoo on 2018. 6. 17..
//  Copyright © 2018년 StudioMate. All rights reserved.
//
import UIKit

open class JustView: UIView {
    public convenience init() {
        self.init(frame: CGRect())
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        onInit()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        onInit()
    }
    open func onInit() {
    }
}
