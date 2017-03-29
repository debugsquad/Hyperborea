import UIKit

class VSearch:VView
{
    private(set) weak var viewBar:VSearchBar!
    private(set) weak var viewOptions:VSearchOptions!
    private(set) weak var viewResults:VSearchResults!
    private(set) weak var viewContent:VSearchContent!
    private weak var controller:CSearch!
    private weak var layoutBarHeight:NSLayoutConstraint!
    private weak var layoutResultsHeight:NSLayoutConstraint!
    private weak var layoutOptionsTop:NSLayoutConstraint!
    private weak var layoutContentTop:NSLayoutConstraint!
    private var resultsHeight:CGFloat
    let kBarMaxHeight:CGFloat = 82
    let kOptionsHeight:CGFloat = 54
    let barOptionsTop:CGFloat
    private let kBarMinHeight:CGFloat = 50
    
    override init(controller:CController)
    {
        resultsHeight = 0
        barOptionsTop = kOptionsHeight + kBarMaxHeight
        
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
        
        let viewContent:VSearchContent = VSearchContent(
            controller:self.controller)
        self.viewContent = viewContent
        
        addSubview(viewContent)
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
        layoutResultsHeight = NSLayoutConstraint.height(
            view:viewResults)
        NSLayoutConstraint.equalsHorizontal(
            view:viewResults,
            toView:self)

        layoutContentTop = NSLayoutConstraint.topToTop(
            view:viewContent,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:viewContent,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewContent,
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
    
    func restartScrollOffset()
    {
        scrollOffset(offsetY:0)
        viewResults.scrollToTop()
        viewBar.beginEditing()
    }
    
    func resultsHeight(resultsHeight:CGFloat)
    {
        self.resultsHeight = resultsHeight
        layoutResultsHeight.constant = resultsHeight
        viewContent.insetsTop(top:resultsHeight)
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
        layoutContentTop.constant = -offsetY
        
        if offsetY > 0
        {
            layoutResultsHeight.constant = resultsHeight
        }
        else
        {
            layoutResultsHeight.constant = resultsHeight - offsetY
        }
    }
}
