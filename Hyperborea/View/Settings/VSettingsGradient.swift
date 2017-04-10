import UIKit

class VSettingsGradient:UIView
{
    private let kLocationTop:NSNumber = 0
    private let kLocationMiddleTop:NSNumber = 0.08
    private let kLocationMiddleBottom:NSNumber = 0.5
    private let kLocationBottom:NSNumber = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        guard
            
            let gradientLayer:CAGradientLayer = self.layer as? CAGradientLayer
            
        else
        {
            return
        }
        
        let topColor:CGColor = UIColor(
            red:0.149019607843137,
            green:0.294117647058824,
            blue:0.470588235294118,
            alpha:1).cgColor
        let middleColorTop:CGColor = UIColor.hyperBlue.cgColor
        let middleColorBottom:CGColor = UIColor.hyperBlue.cgColor
        let bottomColor:CGColor = UIColor.hyperOrange.cgColor
        
        gradientLayer.locations = [
            kLocationTop,
            kLocationMiddleTop,
            kLocationMiddleBottom,
            kLocationBottom
        ]
        
        gradientLayer.colors = [
            topColor,
            middleColorTop,
            middleColorBottom,
            bottomColor
        ]
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override open class var layerClass:AnyClass
    {
        get
        {
            return CAGradientLayer.self
        }
    }
}
