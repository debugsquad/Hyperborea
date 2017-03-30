import UIKit

class VSettings:VView
{
    private weak var controller:CSettings!
    private weak var viewBar:VSettingsBar!
    private weak var viewBackground:VSettingsBackground!
    private weak var layoutBarHeight:NSLayoutConstraint!
    private let kMaxBarHeight:CGFloat = 200
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.hyperBlue
        self.controller = controller as? CSettings
        
        let viewBar:VSettingsBar = VSettingsBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let viewBackground:VSettingsBackground = VSettingsBackground()
        self.viewBackground = viewBackground
        
        addSubview(viewBackground)
        addSubview(viewBar)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar,
            constant:kMaxBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewBackground,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
