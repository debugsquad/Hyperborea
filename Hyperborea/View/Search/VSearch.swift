import UIKit

class VSearch:VView
{
    private weak var controller:CSearch!
    private weak var viewBar:VSearchBar!
    private weak var layoutBarHeight:NSLayoutConstraint!
    private let kBarMaxHeight:CGFloat = 100
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(red:0.84, green:0.86, blue:0.9, alpha:1)
        self.controller = controller as? CSearch
        
        let viewBar:VSearchBar = VSearchBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        addSubview(viewBar)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarMaxHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
