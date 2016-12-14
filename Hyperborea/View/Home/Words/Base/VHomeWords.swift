import UIKit

class VHomeWords:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private(set) var model:RModelHomeEntries?
    private weak var controller:CHome!
    private weak var collectionView:UICollectionView!
    private weak var spinner:VSpinner!
    private let kInsetTop:CGFloat = 110
    private let kInsetBottom:CGFloat = 110
    private let kInterLine:CGFloat = 40
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = kInterLine
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
        collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        collectionView.register(
            VHomeWordsCellEntry.self,
            forCellWithReuseIdentifier:
            VHomeWordsCellEntry.reusableIdentifier)
        collectionView.register(
            VHomeWordsCellOrigin.self,
            forCellWithReuseIdentifier:
            VHomeWordsCellOrigin.reusableIdentifier)
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
        
        let spinner:VSpinner = VSpinner()
        spinner.stopAnimating()
        self.spinner = spinner
        
        addSubview(collectionView)
        addSubview(spinner)
        
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
        
        let layoutSpinnerTop:NSLayoutConstraint = NSLayoutConstraint(
            item:spinner,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutSpinnerBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:spinner,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutSpinnerLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:spinner,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutSpinnerRight:NSLayoutConstraint = NSLayoutConstraint(
            item:spinner,
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
            layoutCollectionViewRight,
            layoutSpinnerTop,
            layoutSpinnerBottom,
            layoutSpinnerLeft,
            layoutSpinnerRight
            ])
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    private func modelAtIndex(index:IndexPath) -> RModelHomeEntriesItem
    {
        let item:RModelHomeEntriesItem = model!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func restartScroll()
    {
        let rect:CGRect = CGRect(x:0, y:0, width:1, height:1)
        collectionView.scrollRectToVisible(rect, animated:false)
    }
    
    func showLoading()
    {
        model = nil
        collectionView.reloadData()
        spinner.startAnimating()
    }
    
    func config(model:RModelHomeEntries?)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.model = model
            self?.collectionView.reloadData()
            self?.spinner.stopAnimating()
        }
    }
    
    //MARK: collectionView delegate
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        let offsetY:CGFloat = -scrollView.contentOffset.y
        controller.viewHome.scrollDidScroll(offsetY:offsetY)
    }
    
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
        let item:RModelHomeEntriesItem = modelAtIndex(index:indexPath)
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = item.cellHeight(cellWidth:width)
        let size:CGSize = CGSize(
            width:width,
            height:height)
        
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
            header.config(controller:controller)
            
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
        let item:RModelHomeEntriesItem = modelAtIndex(index:indexPath)
        let cell:VHomeWordsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.reusableIdentifier,
            for:indexPath) as! VHomeWordsCell
        cell.config(controller:controller, model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        let item:RModelHomeEntriesItem = modelAtIndex(index:indexPath)
        
        return item.selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        let item:RModelHomeEntriesItem = modelAtIndex(index:indexPath)
        
        return item.selectable
    }
}
