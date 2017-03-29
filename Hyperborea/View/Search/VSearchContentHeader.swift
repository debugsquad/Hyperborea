import UIKit

class VSearchContentHeader:UICollectionReusableView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let model:MSearchContentMode
    private let kBorderHeight:CGFloat = 1
    private weak var collectionView:VCollection!
    
    override init(frame:CGRect)
    {
        model = MSearchContentMode()
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let borderTop:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        let borderBottom:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceHorizontal = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(cell:VSearchContentHeaderCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        }
        
        addSubview(borderTop)
        addSubview(borderBottom)
        addSubview(collectionView)
        
        NSLayoutConstraint.topToTop(
            view:borderTop,
            toView:self)
        NSLayoutConstraint.height(
            view:borderTop,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:borderTop,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:borderBottom,
            toView:self)
        NSLayoutConstraint.height(
            view:borderBottom,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:borderBottom,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        
        if let firstCellWidth:CGFloat = model.items.first?.cellWidth
        {
            if let lastCellWidth:CGFloat = model.items.last?.cellWidth
            {
                let remainLeft:CGFloat = width - firstCellWidth
                let remainRight:CGFloat = width - lastCellWidth
                let remainLeft_2:CGFloat = remainLeft / 2.0
                let remainRight_2:CGFloat = remainRight / 2.0
                
                if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
                {
                    flow.sectionInset = UIEdgeInsets(
                        top:0,
                        left:remainLeft_2,
                        bottom:0,
                        right:remainRight_2)
                }
                
                let indexPath:IndexPath = IndexPath(
                    item:model.selectedIndex,
                    section:0)
                
                collectionView.selectItem(
                    at:indexPath,
                    animated:true,
                    scrollPosition:UICollectionViewScrollPosition.centeredHorizontally)
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
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let item:MSearchContentModeItem = modelAtIndex(index:indexPath)
        let cell:VSearchContentHeaderCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VSearchContentHeaderCell.reusableIdentifier,
            for:indexPath) as! VSearchContentHeaderCell
        cell.config(model:item)
        
        return cell
    }
}
