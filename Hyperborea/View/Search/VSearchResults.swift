import UIKit

class VSearchResults:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CSearch!
    private weak var collectionView:VCollection!
    private var trackScroll:Bool
    
    init(controller:CSearch)
    {
        trackScroll = false
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let flow:VSearchResultsFlow = VSearchResultsFlow(
            controller:controller)
        
        let collectionView:VCollection = VCollection(
            flow:flow)
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VSearchResultsCell.self)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        if trackScroll
        {
            let offsetY:CGFloat = scrollView.contentOffset.y
            controller.viewSearch.scrollResults(offsetY:offsetY)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView:UIScrollView)
    {
        trackScroll = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView:UIScrollView)
    {
        trackScroll = false
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSearchResultsItem
    {
        let item:MSearchResultsItem = controller.modelResults!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.reloadData()
    }
    
    func scrollToTop()
    {
        let rect:CGRect = CGRect(x:0, y:0, width:1, height:1)
        collectionView.scrollRectToVisible(rect, animated:true)
    }
    
    func changeOrientation()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        scrollToTop()
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        guard
        
            let count:Int = controller.modelResults?.items.count
        
        else
        {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MSearchResultsItem = modelAtIndex(index:indexPath)
        let cell:VSearchResultsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VSearchResultsCell.reusableIdentifier,
            for:indexPath) as! VSearchResultsCell
        cell.config(model:item)
        
        return cell
    }
}
