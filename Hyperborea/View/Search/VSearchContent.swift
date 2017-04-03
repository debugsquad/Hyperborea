import UIKit

class VSearchContent:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let modelMode:MSearchContentMode
    private weak var controller:CSearch!
    private weak var collectionView:VCollection!
    private let kHeaderHeight:CGFloat = 50
    private let kCellHeight:CGFloat = 380
    
    init(controller:CSearch)
    {
        modelMode = MSearchContentMode()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let collectionView:VCollection = VCollection()
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerHeader(header:VSearchContentHeader.self)
        collectionView.registerFooter(footer:VSearchContentFooter.self)
        collectionView.registerCell(cell:VSearchContentCellDefinition.self)
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
    
    //MARK: public
    
    func changeOrientation()
    {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func refresh()
    {
        layoutIfNeeded()
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = bounds.maxX
        let size:CGSize = CGSize(
            width:width,
            height:kCellHeight)
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        let height:CGFloat
        
        if controller.selectedEntry == nil
        {
            height = 0
        }
        else
        {
            height = kHeaderHeight
        }
        
        let size:CGSize = CGSize(width:0, height:height)
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForFooterInSection section:Int) -> CGSize
    {
        let height:CGFloat
        
        if controller.selectedEntry == nil
        {
            if controller.resultItem == nil
            {
                height = 0
            }
            else
            {
                height = bounds.height
            }
        }
        else
        {
            height = 0
        }
        
        let size:CGSize = CGSize(width:0, height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int
        
        if controller.selectedEntry == nil
        {
            count = 0
        }
        else
        {
            count = 1
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusable:UICollectionReusableView
        
        if kind == UICollectionElementKindSectionHeader
        {
            let header:VSearchContentHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VSearchContentHeader.reusableIdentifier,
                for:indexPath) as! VSearchContentHeader
            header.config(controller:controller)
            reusable = header
        }
        else
        {
            let footer:VSearchContentFooter = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VSearchContentFooter.reusableIdentifier,
                for:indexPath) as! VSearchContentFooter
            footer.config(controller:controller)
            reusable = footer
        }
        
        return reusable
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
