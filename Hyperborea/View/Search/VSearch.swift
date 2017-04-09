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
    private var resultsHeight:CGFloat
    private var contentHeight:CGFloat
    private let kBarMinHeight:CGFloat = 50
    private let kInitialHeight:CGFloat = 1
    private let kMinResultsHeightForContent:CGFloat = 100
    
    override init(controller:CController)
    {
        barOptionsTop = kOptionsHeight + kBarMaxHeight
        resultsHeight = kInitialHeight
        contentHeight = kInitialHeight
        
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
    
    private func scrollToTop()
    {
        let rect:CGRect = CGRect(x:0, y:0, width:1, height:1)
        collectionView.scrollRectToVisible(rect, animated:true)
    }
    
    private func asyncShowContent(restartMode:Bool)
    {
        if restartMode
        {
            viewContent?.viewMode.restart()
        }
        
        guard
            
            let contentHeight:CGFloat = viewContent?.refresh()
            
        else
        {
            return
        }
        
        if resultsHeight < kMinResultsHeightForContent
        {
            resultsHeight = kMinResultsHeightForContent
        }
        
        self.contentHeight = contentHeight
        collectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath:IndexPath = IndexPath(item:1, section:0)
        collectionView.scrollToItem(
            at:indexPath,
            at:UICollectionViewScrollPosition.top,
            animated:true)
    }
    
    //MARK: public
    
    func refresh()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewResults?.refresh()
            self?.scrollToTop()
        }
    }
    
    func changeOrientation()
    {
        viewResults?.changeOrientation()
        viewContent?.changeOrientation()
        scrollToTop()
    }
    
    func beginSearch()
    {
        viewBar.beginEditing()
        scrollToTop()
    }
    
    func resultsHeight(resultsHeight:CGFloat)
    {
        self.resultsHeight = resultsHeight
        
        DispatchQueue.main.async
        { [weak self] in

            self?.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    func showContent(restartMode:Bool)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.asyncShowContent(restartMode:restartMode)
        }
    }
    
    func showFroob()
    {
        contentHeight = kInitialHeight
        collectionView.collectionViewLayout.invalidateLayout()
        viewResults?.refresh()
        viewContent?.froob()
        scrollToTop()
    }
    
    //MARK: collectionView delegate
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        let offsetY:CGFloat = scrollView.contentOffset.y
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
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = bounds.size.width
        let size:CGSize
        
        if indexPath.item == 0
        {
            size = CGSize(
                width:width,
                height:resultsHeight)
        }
        else
        {
            size = CGSize(
                width:width,
                height:contentHeight)
        }
        
        return size
    }
    
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
            let cellResults:VSearchCellResults = collectionView.dequeueReusableCell(
                withReuseIdentifier:
                VSearchCellResults.reusableIdentifier,
                for:indexPath) as! VSearchCellResults
            cell = cellResults
            
            if viewResults == nil
            {
                cellResults.config(controller:controller)
                viewResults = cellResults.viewResults
            }
        }
        else
        {
            let cellContent:VSearchCellContent = collectionView.dequeueReusableCell(
                withReuseIdentifier:
                VSearchCellContent.reusableIdentifier,
                for:indexPath) as! VSearchCellContent
            cell = cellContent
            
            if viewContent == nil
            {
                cellContent.config(controller:controller)
                viewContent = cellContent.viewContent
            }
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
