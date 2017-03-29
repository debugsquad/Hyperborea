import UIKit

class VSearch:VView
{
    private(set) weak var viewBar:VSearchBar!
    private(set) weak var viewOptions:VSearchOptions!
    private(set) weak var viewResults:VSearchResults!
    private weak var controller:CSearch!
    private weak var layoutBarHeight:NSLayoutConstraint!
    private weak var layoutOptionsTop:NSLayoutConstraint!
    let kBarMaxHeight:CGFloat = 82
    private let kBarMinHeight:CGFloat = 50
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
        self.viewOptions = viewOptions
        
        let viewResults:VSearchResults = VSearchResults(
            controller:self.controller)
        self.viewResults = viewResults
        
        addSubview(viewResults)
        addSubview(viewOptions)
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
        
        layoutOptionsTop = NSLayoutConstraint.topToBottom(
            view:viewOptions,
            toView:viewBar)
        NSLayoutConstraint.height(
            view:viewOptions,
            constant:kOptionsHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewOptions,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewResults,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:viewResults,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewResults,
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
            
            self?.viewResults.refresh()
        }
    }
    
    func scrollOffset(offsetY:CGFloat)
    {
        var newBarHeight:CGFloat = kBarMaxHeight - offsetY
        var newOptionsTop:CGFloat = offsetY
        
        if newBarHeight < kBarMinHeight
        {
            newBarHeight = kBarMinHeight
        }
        
        if newOptionsTop > kOptionsHeight
        {
            newOptionsTop = kOptionsHeight
        }
        else if newOptionsTop < 0
        {
            newOptionsTop = 0
        }
        
        layoutBarHeight.constant = newBarHeight
        layoutOptionsTop.constant = -newOptionsTop
    }
}
