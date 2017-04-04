import UIKit

class VSearchContent:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private(set) weak var viewMode:VSearchContentMode!
    private weak var controller:CSearch!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner!
    private weak var layoutModeHeight:NSLayoutConstraint!
    private var cellHeight:CGFloat
    private let drawingOptions:NSStringDrawingOptions
    private let kModeHeight:CGFloat = 90
    private let kHeaderHeight:CGFloat = 60
    private let kLoadingHeight:CGFloat = 300
    private let kContentAddHeight:CGFloat = 40
    private let kContentRemoveWidth:CGFloat = 20
    private let kCompareHeight:CGFloat = 8000
    
    init(controller:CSearch)
    {
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        cellHeight = 0
        
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
        
        if let contentString:NSAttributedString = viewMode.model.currentItem().contentString(controller:controller)
        {
            let width:CGFloat = bounds.maxX
            let maxSize:CGSize = CGSize(
                width:width - kContentRemoveWidth,
                height:kCompareHeight)
            let boundingRect:CGRect = contentString.boundingRect(
                with:maxSize,
                options:drawingOptions,
                context:nil)
            let textHeight:CGFloat = ceil(boundingRect.size.height)
            cellHeight = textHeight + kContentAddHeight
            totalHeight = cellHeight + kModeHeight + kHeaderHeight
            
            layoutModeHeight.constant = kModeHeight
            spinner.stopAnimating()
        }
        else
        {
            cellHeight = 0
            layoutModeHeight.constant = 0
            spinner.startAnimating()
            totalHeight = kLoadingHeight
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
        let height:CGFloat
        
        if controller.modelEntry == nil
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
