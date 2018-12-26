//
//  JustView.swift
//
import UIKit

open class JustView: UIView {

    public let contentView = UIView()
    private var contentConstraints = [String: NSLayoutConstraint]()
    public var padding: UIEdgeInsets = UIEdgeInsets() {
        didSet {
            contentConstraints["leading"]?.constant = padding.left
            contentConstraints["trailing"]?.constant = -padding.right
            contentConstraints["top"]?.constant = padding.top
            contentConstraints["bottom"]?.constant = -padding.bottom
            setNeedsUpdateConstraints()
        }
    }

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
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let leading = contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding.left)
        leading.isActive = true
        let trailing = contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding.right)
        trailing.isActive = true
        let top = contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding.top)
        top.isActive = true
        let bottom = contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding.bottom)
        bottom.isActive = true

        contentConstraints["leading"] = leading
        contentConstraints["trailing"] = trailing
        contentConstraints["top"] = top
        contentConstraints["bottom"] = bottom
    }
}

open class JustButton: UIButton {
    public convenience init() {
        self.init(type: .custom)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        onInit()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        onInit()
    }
    open func onInit() {
    }
}
