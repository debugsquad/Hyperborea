import UIKit

class VSearchContentMode:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let model:MSearchContentMode
    private weak var controller:CSearch!
    private weak var collectionView:VCollection!
    private let kBorderHeight:CGFloat = 1
    private let kAfterSelect:TimeInterval = 0.3
    
    init(controller:CSearch)
    {
        model = MSearchContentMode()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let borderBottom:VBorder = VBorder(color:UIColor.hyperBlue)
        
        let collectionView:VCollection = VCollection()
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
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
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSearchContentModeItem
    {
        let item:MSearchContentModeItem = model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func restart()
    {
        let indexPath:IndexPath = IndexPath(item:0, section:0)
        model.selectedIndex = indexPath.item
        collectionView.selectItem(
            at:indexPath,
            animated:true,
            scrollPosition:UICollectionViewScrollPosition())
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = collectionView.bounds.maxY
        let count:CGFloat = CGFloat(model.items.count)
        let cellWidth:CGFloat = width / count
        let size:CGSize = CGSize(
            width:cellWidth,
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
        collectionView.isUserInteractionEnabled = false
        model.selectedIndex = indexPath.item
        
        let item:MSearchContentModeItem = model.currentItem()
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAfterSelect)
        { [weak collectionView] in
            
            collectionView?.isUserInteractionEnabled = true
        }
    }
}
