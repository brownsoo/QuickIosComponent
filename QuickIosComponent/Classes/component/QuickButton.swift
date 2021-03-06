import UIKit

open class QuickButton: JustButton {

    public var normalColor: UIColor = UIColor.white
    public var highlightColor: UIColor = UIColor.black.brightness(brightness: 0.5)
    public var disableColor: UIColor = UIColor.black.brightness(brightness: 0.9)
    public var borderColor: UIColor = UIColor.lightGray
    public var borderWidth: CGFloat = 1
    public var icon: UIImage? = nil {
        didSet {
            iconIv.image = icon
        }
    }

    private static let defaultColors = [UIColor(red: 255, green: 111, blue: 97),
                                        UIColor(red: 211, green: 80, blue: 145)]

    private let pi = CGFloat(Float.pi)

    private var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = defaultColors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }()

    public var gradientColors: [UIColor] = defaultColors {
        didSet {
            gradientLayer.colors = gradientColors.map{ $0.cgColor }
        }
    }

    /// Center position for gradientRotation
    public var gradientRotationCenter: CGPoint = CGPoint(x: 0.5, y: 0.5)

    /// Rotate gradient in degree
    /// It changes startPoint and endPoint of gradient layer
    public func gradientRotate(degree: CGFloat) {
        let radian = degree / 180.0 * pi
        let startX = gradientRotationCenter.x
        let startY = gradientRotationCenter.y
        self.gradientStartPoint = CGPoint(
            x: CGFloat(cos(radian + pi) * startX + 0.5),
            y: CGFloat(sin(radian + pi) * startY + 0.5))
        let endX = 1 - gradientRotationCenter.x
        let endY = 1 - gradientRotationCenter.y
        self.gradientEndPoint = CGPoint(
            x: CGFloat(cos(radian) * endX + 0.5),
            y: CGFloat(sin(radian) * endY + 0.5))
    }

    public var gradientStartPoint: CGPoint = CGPoint(x: 0, y: 0.5) {
        didSet {
            self.gradientLayer.startPoint = gradientStartPoint
        }
    }

    public var gradientEndPoint: CGPoint = CGPoint(x: 1.0, y: 0.5) {
        didSet {
            self.gradientLayer.endPoint = gradientEndPoint
        }
    }

    private var size = CGSize()
    private lazy var iconIv = UIImageView()
    private lazy var _shadowLayer: CAShapeLayer = {
        let shadow = CAShapeLayer()
        shadow.fillColor = UIColor.clear.cgColor
        shadow.shadowColor = UIColor.black.cgColor
        shadow.shadowOpacity = 0.1
        shadow.shadowRadius = 8
        shadow.shadowOffset = CGSize(width: 0, height: 4)
        return shadow
    }()

    open var shadowLayer: CAShapeLayer {
        return _shadowLayer
    }

    public var shadowing: Bool = true {
        didSet {
            setNeedsLayout()
        }
    }
    public var useGradient: Bool = false {
        didSet {
            size = CGSize()
            setNeedsLayout()
        }
    }
    public var cornerRadius: CGFloat = 8 {
        didSet {
            size = CGSize()
            setNeedsLayout()
        }
    }

    override open func onInit() {
        addSubview(iconIv)
        iconIv.translatesAutoresizingMaskIntoConstraints = false
        iconIv.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconIv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconIv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        iconIv.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        setTitleColor(UIColor.darkGray, for: .normal)
        setTitleColor(UIColor.gray, for: .disabled)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        let bw = bounds.width
        let bh = bounds.height
        let r = cornerRadius
        if size != bounds.size {
            size = bounds.size
            if !useGradient {
                setBackgroundImage(UIImage().solid(normalColor, width: bw, height: bh).round(r), for: .normal)
            }
            setBackgroundImage(UIImage().solid(highlightColor, width: bw, height: bh).round(r), for: .highlighted)
            setBackgroundImage(UIImage().solid(disableColor, width: bw, height: bh).round(r), for: .disabled)
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
            shadowLayer.shadowPath = UIBezierPath(
                roundedRect: CGRect(x: 9, y: 0, width: bw - 18, height: bh),
                cornerRadius: r).cgPath

            gradientLayer.frame = bounds
            gradientLayer.cornerRadius = r

            layer.cornerRadius = r
        }
        if isEnabled {
            if useGradient {
                layer.insertSublayer(gradientLayer, at: 0)
            } else {
                gradientLayer.removeFromSuperlayer()
            }
            if shadowing {
                layer.insertSublayer(shadowLayer, at: useGradient ? 1 : 0)
            } else {
                shadowLayer.removeFromSuperlayer()
            }
        } else {
            gradientLayer.removeFromSuperlayer()
            shadowLayer.removeFromSuperlayer()
        }

        layer.borderColor = borderColor.cgColor
        layer.borderWidth = isEnabled ? borderWidth : 0
    }
}
