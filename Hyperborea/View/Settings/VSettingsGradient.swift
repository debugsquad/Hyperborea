import UIKit

class VSettingsGradient:UIView
{
    private let kLocationTop:NSNumber = 0
    private let kLocationMiddle:NSNumber = 0.2
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
        
        let topColor:CGColor = UIColor.black.cgColor
        let middleColor:CGColor = UIColor.hyperBlue.cgColor
        let bottomColor:CGColor = UIColor.hyperOrange.cgColor
        
        gradientLayer.locations = [
            kLocationTop,
            kLocationMiddle,
            kLocationBottom
        ]
        
        gradientLayer.colors = [
            topColor,
            middleColor,
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
