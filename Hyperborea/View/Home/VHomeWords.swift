import UIKit

class VHomeWords:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CHome!
    private weak var collectionView:UICollectionView!
    private var model:RModelHomeEntries?
    private let kInsetTop:CGFloat = 100
    private let kInsetBottom:CGFloat = 100
    private let kInterLine:CGFloat = 1
    private let kCellHeight:CGFloat = 80
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeWordsCell.self,
            forCellWithReuseIdentifier:
            VHomeWordsCell.reusableIdentifier)
        collectionView.register(
            VHomeWordsHeader.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VHomeWordsHeader.reusableIdentifier)
        collectionView.register(
            VHomeWordsFooter.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionFooter,
            withReuseIdentifier:
            VHomeWordsFooter.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        let layoutCollectionViewTop:NSLayoutConstraint = NSLayoutConstraint(
            item:collectionView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutCollectionViewBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:collectionView,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutCollectionViewLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:collectionView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutCollectionViewRight:NSLayoutConstraint = NSLayoutConstraint(
            item:collectionView,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        addConstraints([
            layoutCollectionViewTop,
            layoutCollectionViewBottom,
            layoutCollectionViewLeft,
            layoutCollectionViewRight
            ])
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        guard
        
            let model:RModelHomeEntries = self.model
            
        else
        {
            return UIEdgeInsets.zero
        }
        
        let insets:UIEdgeInsets
        
        if model.items.isEmpty
        {
            insets = UIEdgeInsets.zero
        }
        else
        {
            insets = UIEdgeInsets(
                top:kInsetTop,
                left:0,
                bottom:kInsetBottom,
                right:0)
        }
        
        return insets
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(
            width:width,
            height:kCellHeight)
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForHeaderInSection section:Int) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize
        
        if model == nil
        {
            size = CGSize(width:0, height:height)
        }
        else
        {
            size = CGSize.zero
        }
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize
        
        guard
            
            let model:RModelHomeEntries = self.model
            
        else
        {
            return CGSize.zero
        }
        
        if model.items.isEmpty
        {
            size = CGSize(width:0, height:height)
        }
        else
        {
            size = CGSize.zero
        }
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        guard
        
            let count:Int = model?.items.count
        
        else
        {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusableView:UICollectionReusableView
        
        if kind == UICollectionElementKindSectionHeader
        {
            let header:VHomeWordsHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VHomeWordsHeader.reusableIdentifier,
                for:indexPath) as! VHomeWordsHeader
            
            reusableView = header
        }
        else
        {
            let footer:VHomeWordsFooter = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VHomeWordsFooter.reusableIdentifier,
                for:indexPath) as! VHomeWordsFooter
            
            reusableView = footer
        }
        
        return reusableView
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VHomeWordsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VHomeWordsCell.reusableIdentifier,
            for:indexPath) as! VHomeWordsCell
        
        return cell
    }
}
