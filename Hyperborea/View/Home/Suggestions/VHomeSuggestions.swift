import UIKit

class VHomeSuggestions:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CHome!
    private weak var collectionView:UICollectionView!
    private(set) var model:RModelHomeSearch?
    private let kDeselectTime:TimeInterval = 0.5
    private let kInterLine:CGFloat = 7
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = kInterLine
        flow.sectionInset = UIEdgeInsets(
            top:0,
            left:kInterLine,
            bottom:0,
            right:kInterLine)
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeSuggestionsCell.self,
            forCellWithReuseIdentifier:
            VHomeSuggestionsCell.reusableIdentifier)
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
            layoutCollectionViewRight])
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> RModelHomeSearchResult
    {
        let item:RModelHomeSearchResult = model!.results[index.item]
        
        return item
    }
    
    //MARK: public
    
    func config(model:RModelHomeSearch?)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.model = model
            self?.collectionView.reloadData()
        }
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let item:RModelHomeSearchResult = modelAtIndex(index:indexPath)
        let size:CGSize = CGSize(width:item.cellWidth, height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int
        
        if let model:RModelHomeSearch = self.model
        {
            count = model.results.count
        }
        else
        {
            count = 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:RModelHomeSearchResult = modelAtIndex(index:indexPath)
        let cell:VHomeSuggestionsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VHomeSuggestionsCell.reusableIdentifier,
            for:indexPath) as! VHomeSuggestionsCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:RModelHomeSearchResult = modelAtIndex(index:indexPath)
        collectionView.scrollToItem(
            at:indexPath,
            at:UICollectionViewScrollPosition.centeredHorizontally,
            animated:true)
        controller.selectSuggestion(item:item)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
