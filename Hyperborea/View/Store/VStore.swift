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
    private let kBarTop:CGFloat = 20
    private let kBarHeight:CGFloat = 64
    
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
            constant:kBarTop)
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
}
