import UIKit

class VSearch:VView
{
    private(set) weak var viewBar:VSearchBar!
    private(set) weak var viewOptions:VSearchOptions!
    private weak var controller:CSearch!
    private weak var layoutBarHeight:NSLayoutConstraint!
    private let kBarMaxHeight:CGFloat = 82
    private let kOptionsHeight:CGFloat = 54
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CSearch
        
        let viewBar:VSearchBar = VSearchBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let viewOptions:VSearchOptions = VSearchOptions(
            controller:self.controller)
        
        addSubview(viewBar)
        addSubview(viewOptions)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarMaxHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewOptions,
            toView:viewBar)
        NSLayoutConstraint.height(
            view:viewOptions,
            constant:kOptionsHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewOptions,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func refresh()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            
        }
    }
}
