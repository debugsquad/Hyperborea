import UIKit

class VSearchContent:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private(set) weak var viewMode:VSearchContentMode!
    private weak var controller:CSearch!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner!
    private weak var layoutModeHeight:NSLayoutConstraint!
    private var cellHeight:CGFloat
    private var headerHeight:CGFloat
    private let kModeHeight:CGFloat = 120
    private let kHeaderHeight:CGFloat = 60
    private let kLoadingHeight:CGFloat = 320
    
    init(controller:CSearch)
    {
        cellHeight = 0
        headerHeight = 0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let viewMode:VSearchContentMode = VSearchContentMode(
            controller:controller)
        self.viewMode = viewMode
        
        let collectionView:VCollection = VCollection()
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerHeader(header:VSearchContentHeader.self)
        collectionView.registerCell(cell:VSearchContentCellDefinition.self)
        collectionView.registerCell(cell:VSearchContentCellSynonyms.self)
        collectionView.registerCell(cell:VSearchContentCellAntonyms.self)
        collectionView.registerCell(cell:VSearchContentCellTranslations.self)
        collectionView.registerCell(cell:VSearchContentCellOrigins.self)
        self.collectionView = collectionView
        
        let spinner:VSpinner = VSpinner()
        spinner.stopAnimating()
        self.spinner = spinner
        
        addSubview(spinner)
        addSubview(viewMode)
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewMode,
            toView:self)
        layoutModeHeight = NSLayoutConstraint.height(
            view:viewMode)
        NSLayoutConstraint.equalsHorizontal(
            view:viewMode,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:collectionView,
            toView:viewMode)
        NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
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
    
    func refresh() -> CGFloat
    {
        let totalHeight:CGFloat
        let cellHeight:CGFloat = viewMode.model.currentItem().contentHeight(controller:controller)
        self.cellHeight = cellHeight
        
        if cellHeight == 0
        {
            headerHeight = 0
            layoutModeHeight.constant = 0
            totalHeight = kLoadingHeight
            
            spinner.startAnimating()
        }
        else
        {
            headerHeight = kHeaderHeight
            layoutModeHeight.constant = kModeHeight
            totalHeight = cellHeight + kModeHeight + kHeaderHeight
            
            spinner.stopAnimating()
        }
        
        collectionView.reloadData()
        
        return totalHeight
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = bounds.maxX
        let size:CGSize = CGSize(
            width:width,
            height:cellHeight)
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        let size:CGSize = CGSize(width:0, height:headerHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int
        
        if controller.modelEntry == nil
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
        let header:VSearchContentHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VSearchContentHeader.reusableIdentifier,
            for:indexPath) as! VSearchContentHeader
        header.config(controller:controller)
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let reusableIdentifier:String = viewMode.model.currentItem().reusableIdentifier
        let cell:VSearchContentCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            reusableIdentifier,
            for:indexPath) as! VSearchContentCell
        cell.config(controller:controller)
        
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
