import UIKit

class VSearch:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private(set) weak var viewBar:VSearchBar!
    private(set) weak var viewOptions:VSearchOptions!
    private(set) weak var viewResults:VSearchResults?
    private(set) weak var viewContent:VSearchContent?
    private weak var collectionView:VCollection!
    private weak var controller:CSearch!
    private weak var layoutBarHeight:NSLayoutConstraint!
    private weak var layoutOptionsTop:NSLayoutConstraint!
    let kBarMaxHeight:CGFloat = 82
    let kOptionsHeight:CGFloat = 54
    let barOptionsTop:CGFloat
    private let kBarMinHeight:CGFloat = 50
    private let kAfterOrientation:TimeInterval = 0.1
    
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
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(
            cell:VSearchCellResults.self)
        collectionView.registerCell(
            cell:VSearchCellContent.self)
        self.collectionView = collectionView
        
        addSubview(collectionView)
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
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func resetScrolls()
    {
        scrollAll(offsetY:0)
    }
    
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
    }
    
    //MARK: public
    
    func refresh()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewResults.refresh()
        }
    }
    
    func changeOrientation()
    {
        resetScrolls()
        viewResults.changeOrientation()
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAfterOrientation)
        { [weak self] in
            
            self?.viewContent.changeOrientation()
        }
    }
    
    func beginSearch()
    {
        resetScrolls()
        viewBar.beginEditing()
        viewResults.scrollToTop()
        viewContent.scrollToTop()
    }
    
    func resultsHeight(resultsHeight:CGFloat)
    {
        DispatchQueue.main.async
        { [weak self] in

            self?.layoutResultsHeight.constant = resultsHeight
            self?.viewContent.insetsTop(currentTop:resultsHeight)
        }
    }
    
    func scrollResults(offsetY:CGFloat)
    {
        layoutResultsTop.constant = 0
        
        if offsetY > 0
        {
            layoutContentTop.constant = -offsetY
        }
        else
        {
            layoutContentTop.constant = 0
        }
        
        scrollAll(offsetY:offsetY)
    }
    
    func scrollContent(offsetY:CGFloat)
    {
        layoutResultsTop.constant = -offsetY
        layoutContentTop.constant = 0
        scrollAll(offsetY:offsetY)
    }
    
    //MARK: collectionView
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        return 2
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VSearchCell
        
        if indexPath.item == 0
        {
            cell = collectionView.dequeueReusableCell(
                withReuseIdentifier:
                VSearchCellResults.reusableIdentifier,
                for:indexPath) as! VSearchCellResults
        }
        else
        {
            cell = collectionView.dequeueReusableCell(
                withReuseIdentifier:
                VSearchCellContent.reusableIdentifier,
                for:indexPath) as! VSearchCellContent
            
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool
    {
        return false
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
}
