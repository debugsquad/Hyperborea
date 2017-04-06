import UIKit

class VSearchOptions:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private let model:MSearchOptions
    private weak var controller:CSearch!
    private weak var collectionView:VCollection!
    private let kCellWidth:CGFloat = 60
    private let kDeselectTime:TimeInterval = 0.2
    
    init(controller:CSearch)
    {
        model = MSearchOptions()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let collectionView:VCollection = VCollection()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VSearchOptionsCell.self)
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
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
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSearchOptionsItem
    {
        let item:MSearchOptionsItem = model.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSize(
            width:kCellWidth,
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
        let item:MSearchOptionsItem = modelAtIndex(index:indexPath)
        let cell:VSearchOptionsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VSearchOptionsCell.reusableIdentifier,
            for:indexPath) as! VSearchOptionsCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        collectionView.isUserInteractionEnabled = false
        
        let item:MSearchOptionsItem = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
            collectionView?.isUserInteractionEnabled = true
        }
    }
}
