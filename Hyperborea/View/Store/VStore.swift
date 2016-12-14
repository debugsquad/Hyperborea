import UIKit

class VStore:VView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CStore!
    private weak var viewSpinner:VSpinner?
    private weak var collectionView:UICollectionView!
    private let kHeaderHeight:CGFloat = 150
    private let kFooterHeight:CGFloat = 70
    private let kInterLine:CGFloat = 1
    private let kCollectionBottom:CGFloat = 10
    private let kBarHeight:CGFloat = 92
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.genericBorder
        self.controller = controller as? CStore
        
        let viewBar:VStoreBar = VStoreBar(controller:self.controller)
        let viewSpinner:VSpinner = VSpinner()
        self.viewSpinner = viewSpinner
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets(
            top:kInterLine,
            left:0,
            bottom:kCollectionBottom,
            right:0)
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.isHidden = true
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VStoreCellNotAvailable.self,
            forCellWithReuseIdentifier:
            VStoreCellNotAvailable.reusableIdentifier)
        collectionView.register(
            VStoreCellDeferred.self,
            forCellWithReuseIdentifier:
            VStoreCellDeferred.reusableIdentifier)
        collectionView.register(
            VStoreCellNew.self,
            forCellWithReuseIdentifier:
            VStoreCellNew.reusableIdentifier)
        collectionView.register(
            VStoreCellPurchased.self,
            forCellWithReuseIdentifier:
            VStoreCellPurchased.reusableIdentifier)
        collectionView.register(
            VStoreCellPurchasing.self,
            forCellWithReuseIdentifier:
            VStoreCellPurchasing.reusableIdentifier)
        collectionView.register(
            VStoreHeader.self,
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VStoreHeader.reusableIdentifier)
        collectionView.register(
            VStoreFooter.self,
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter,
            withReuseIdentifier:
            VStoreFooter.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        addSubview(viewSpinner)
        addSubview(viewBar)
        
        let layoutBarTop:NSLayoutConstraint = NSLayoutConstraint(
            item:viewBar,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutBarHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewBar,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kBarHeight)
        let layoutBarLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewBar,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutBarRight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewBar,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        let layoutSpinnerTop:NSLayoutConstraint = NSLayoutConstraint(
            item:viewSpinner,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:viewBar,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutSpinnerBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:viewSpinner,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutSpinnerLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewSpinner,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutSpinnerRight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewSpinner,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        let layoutCollectionTop:NSLayoutConstraint = NSLayoutConstraint(
            item:collectionView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:viewBar,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutCollectionBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:collectionView,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutCollectionLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:collectionView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutCollectionRight:NSLayoutConstraint = NSLayoutConstraint(
            item:collectionView,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        addConstraints([
            layoutBarTop,
            layoutBarHeight,
            layoutBarLeft,
            layoutBarRight,
            layoutSpinnerTop,
            layoutSpinnerBottom,
            layoutSpinnerLeft,
            layoutSpinnerRight,
            layoutCollectionTop,
            layoutCollectionBottom,
            layoutCollectionLeft,
            layoutCollectionRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MStoreItem
    {
        let itemId:MStore.PurchaseId = controller.model.references[index.section]
        let item:MStoreItem = controller.model.mapItems[itemId]!
        
        return item
    }
    
    //MARK: public
    
    func refreshStore()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewSpinner?.removeFromSuperview()
            self?.collectionView.reloadData()
            self?.collectionView.isHidden = false
            
            guard
                
                let errorMessage:String = self?.controller.model.error
                
            else
            {
                return
            }
            
            VAlert.message(message:errorMessage)
        }
    }
    
    //MARK: collection delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForFooterInSection section:Int) -> CGSize
    {
        let indexPath:IndexPath = IndexPath(item:0, section:section)
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let size:CGSize
        
        if item.status?.restorable == true
        {
            size = CGSize(width:0, height:kFooterHeight)
        }
        else
        {
            size = CGSize.zero
        }
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let cellHeight:CGFloat = item.status!.cellHeight
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:cellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        let count:Int = controller.model.references.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let indexPath:IndexPath = IndexPath(item:0, section:section)
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let count:Int
        
        if item.status == nil
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
            let item:MStoreItem = modelAtIndex(index:indexPath)
            let header:VStoreHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VStoreHeader.reusableIdentifier,
                for:indexPath) as! VStoreHeader
            header.config(model:item)
            reusable = header
        }
        else
        {
            let footer:VStoreFooter = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VStoreFooter.reusableIdentifier,
                for:indexPath) as! VStoreFooter
            footer.config(controller:controller)
            
            reusable = footer
        }
        
        return reusable
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let reusableIdentifier:String = item.status!.reusableIdentifier
        
        let cell:VStoreCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            reusableIdentifier,
            for:indexPath) as! VStoreCell
        cell.config(controller:controller, model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
}
