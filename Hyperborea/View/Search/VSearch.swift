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
    private weak var layoutResultsTop:NSLayoutConstraint!
    private weak var layoutOptionsTop:NSLayoutConstraint!
    private weak var layoutContentTop:NSLayoutConstraint!
    let kBarMaxHeight:CGFloat = 82
    let kOptionsHeight:CGFloat = 54
    let barOptionsTop:CGFloat
    private let kBarMinHeight:CGFloat = 50
    
    override init(controller:CController)
    {
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
        
        layoutResultsTop = NSLayoutConstraint.topToTop(
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
    
    //MARK: private
    
    private func scrollAll(offsetY:CGFloat)
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
        
        if offsetY > 0
        {
            layoutContentTop.constant = -offsetY
        }
        else
        {
            layoutContentTop.constant = 0
        }
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
        scrollResults(offsetY:0)
        viewResults.scrollToTop()
        viewBar.beginEditing()
    }
    
    func resultsHeight(resultsHeight:CGFloat)
    {
        layoutResultsHeight.constant = resultsHeight
        viewContent.insetsTop(top:resultsHeight)
    }
    
    func scrollResults(offsetY:CGFloat)
    {
        layoutResultsTop.constant = 0
        scrollAll(offsetY:offsetY)
    }
    
    func scrollContent(offsetY:CGFloat)
    {
        layoutResultsTop.constant = -offsetY
        scrollAll(offsetY:offsetY)
    }
}
