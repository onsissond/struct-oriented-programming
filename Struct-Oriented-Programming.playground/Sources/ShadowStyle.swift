import UIKit

public struct ShadowStyle {
    public let color: UIColor
    public let opacity: Float
    public let radius: CGFloat
    public let offset: CGSize

    public init(color: UIColor, opacity: Float, radius: CGFloat, offset: CGSize) {
        self.color = color
        self.opacity = opacity
        self.radius = radius
        self.offset = offset
    }
}

extension ShadowStyle {
    public static let `default` = ShadowStyle(color: .black, opacity: 0.5, radius: 4, offset: .zero)
}
