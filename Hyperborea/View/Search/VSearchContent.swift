import UIKit

class VSearchContent:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CSearch!
    private weak var collectionView:VCollection!
    private var currentTop:CGFloat
    private let kHeaderHeight:CGFloat = 50
    private let kCellHeight:CGFloat = 380
    private var trackScroll:Bool
    
    init(controller:CSearch)
    {
        currentTop = 0
        trackScroll = false
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerHeader(header:VSearchContentHeader.self)
        collectionView.registerCell(cell:VSearchContentCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
        }
        
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
            let offsetY:CGFloat = scrollView.contentOffset.y + currentTop
            controller.viewSearch.scrollContent(offsetY:offsetY)
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
    
    //MARK: public
    
    func insetsTop(currentTop:CGFloat)
    {
        self.currentTop = currentTop
        collectionView.contentInset = UIEdgeInsets(
            top:currentTop,
            left:0,
            bottom:0,
            right:0)
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
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(
            width:width,
            height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let header:VSearchContentHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VSearchContentHeader.reusableIdentifier,
            for:indexPath) as! VSearchContentHeader
        header.config(controller:controller)
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VSearchContentCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VSearchContentCell.reusableIdentifier,
            for:indexPath) as! VSearchContentCell
        
        return cell
    }
}
