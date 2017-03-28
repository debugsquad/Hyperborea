import UIKit

class VSearchOptions:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CSearch!
    private weak var collectionView:VCollection!
    private let kInterItem:CGFloat = 3
    private let kCellWidth:CGFloat = 60
    
    init(controller:CSearch)
    {
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
            flow.minimumLineSpacing = kInterItem
            flow.minimumInteritemSpacing = kInterItem
            flow.sectionInset = UIEdgeInsets(
                top:kInterItem,
                left:kInterItem,
                bottom:kInterItem,
                right:kInterItem)
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
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let remainHeight:CGFloat = height - (kInterItem + kInterItem)
        let size:CGSize = CGSize(
            width:kCellWidth,
            height:remainHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        return 3
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VSearchOptionsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VSearchOptionsCell.reusableIdentifier,
            for:indexPath) as! VSearchOptionsCell
        
        return cell
    }
}
