import UIKit

class VSearchContentMode:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let model:MSearchContentMode
    private weak var controller:CSearch!
    private weak var collectionView:VCollection!
    private var trackingScroll:Bool
    private let kBorderHeight:CGFloat = 1
    
    init(controller:CSearch)
    {
        model = MSearchContentMode()
        trackingScroll = false
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let borderBottom:VBorder = VBorder(color:UIColor.hyperBlue)
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceHorizontal = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(cell:VSearchContentModeCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        }
        
        addSubview(borderBottom)
        addSubview(collectionView)
        
        NSLayoutConstraint.bottomToBottom(
            view:borderBottom,
            toView:self)
        NSLayoutConstraint.height(
            view:borderBottom,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:borderBottom,
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
        let currentWidth:CGFloat = bounds.maxX
        
        if let firstCellWidth:CGFloat = model.items.first?.cellWidth
        {
            if let lastCellWidth:CGFloat = model.items.last?.cellWidth
            {
                let remainLeft:CGFloat = currentWidth - firstCellWidth
                let remainRight:CGFloat = currentWidth - lastCellWidth
                let remainLeft_2:CGFloat = remainLeft / 2.0
                let remainRight_2:CGFloat = remainRight / 2.0
                
                let indexPath:IndexPath = IndexPath(
                    item:model.selectedIndex,
                    section:0)
                
                DispatchQueue.main.async
                { [weak self] in
                    
                    if let flow:VCollectionFlow = self?.collectionView.collectionViewLayout as? VCollectionFlow
                    {
                        flow.sectionInset = UIEdgeInsets(
                            top:0,
                            left:remainLeft_2,
                            bottom:0,
                            right:remainRight_2)
                    }
                    
                    self?.collectionView.reloadData()
                    self?.collectionView.selectItem(
                        at:indexPath,
                        animated:true,
                        scrollPosition:UICollectionViewScrollPosition.centeredHorizontally)
                }
            }
        }
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSearchContentModeItem
    {
        let item:MSearchContentModeItem = model.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        if trackingScroll
        {
            let midX:CGFloat = scrollView.bounds.midX
            let midY:CGFloat = scrollView.bounds.midY
            let point:CGPoint = CGPoint(
                x:midX,
                y:midY)
            
            guard
                
                let indexPath:IndexPath = collectionView.indexPathForItem(at:point)
                
            else
            {
                return
            }
            
            model.selectedIndex = indexPath.item
            collectionView.selectItem(
                at:indexPath,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView:UIScrollView)
    {
        trackingScroll = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView:UIScrollView)
    {
        trackingScroll = false
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let item:MSearchContentModeItem = modelAtIndex(index:indexPath)
        let size:CGSize = CGSize(
            width:item.cellWidth,
            height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MSearchContentModeItem = modelAtIndex(index:indexPath)
        let cell:VSearchContentModeCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VSearchContentModeCell.reusableIdentifier,
            for:indexPath) as! VSearchContentModeCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        trackingScroll = false
        model.selectedIndex = indexPath.item
        
        collectionView.scrollToItem(
            at:indexPath,
            at:UICollectionViewScrollPosition.centeredHorizontally,
            animated:true)
    }
}
