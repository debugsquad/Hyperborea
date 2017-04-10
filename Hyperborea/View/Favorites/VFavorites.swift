import UIKit

class VFavorites:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CFavorites!
    private weak var collectionView:VCollection!
    private weak var blurContainer:UIView!
    private weak var layoutBaseBottom:NSLayoutConstraint!
    private let kBaseHeight:CGFloat = 470
    private let kBarHeight:CGFloat = 60
    private let kCellHeight:CGFloat = 60
    private let kCollectionBottom:CGFloat = 20
    private let kInterItem:CGFloat = 1
    private let kAnimationDuration:TimeInterval = 0.3
    private let kAfterSelect:TimeInterval = 0.3
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CFavorites
        
        let blurContainer:UIView = UIView()
        blurContainer.isUserInteractionEnabled = false
        blurContainer.translatesAutoresizingMaskIntoConstraints = false
        blurContainer.clipsToBounds = true
        blurContainer.alpha = 0
        self.blurContainer = blurContainer
        
        let buttonClose:UIButton = UIButton()
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        buttonClose.clipsToBounds = true
        buttonClose.backgroundColor = UIColor.clear
        buttonClose.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let blur:VBlur = VBlur.dark()
        
        let baseView:UIView = UIView()
        baseView.backgroundColor = UIColor(white:0.96, alpha:1)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        
        let viewBar:VFavoritesBar = VFavoritesBar(
            controller:self.controller)
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VFavoritesCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.minimumLineSpacing = kInterItem
            flow.minimumInteritemSpacing = kInterItem
            flow.sectionInset = UIEdgeInsets(
                top:0,
                left:0,
                bottom:kCollectionBottom,
                right:0)
        }
        
        baseView.addSubview(viewBar)
        baseView.addSubview(collectionView)
        blurContainer.addSubview(blur)
        addSubview(blurContainer)
        addSubview(buttonClose)
        addSubview(baseView)
        
        NSLayoutConstraint.equals(
            view:blurContainer,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:blurContainer)
        
        NSLayoutConstraint.equals(
            view:buttonClose,
            toView:self)
        
        layoutBaseBottom = NSLayoutConstraint.bottomToBottom(
            view:baseView,
            toView:self,
            constant:kBaseHeight)
        NSLayoutConstraint.height(
            view:baseView,
            constant:kBaseHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:baseView,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:baseView)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:baseView)
        
        NSLayoutConstraint.topToBottom(
            view:collectionView,
            toView:viewBar)
        NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:baseView)
        NSLayoutConstraint.equalsHorizontal(
            view:collectionView,
            toView:baseView)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        animateHide()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MFavoritesItem
    {
        let item:MFavoritesItem = controller.model!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.collectionView.reloadData()
        }
    }
    
    func animateShow()
    {
        layoutBaseBottom.constant = 0
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.blurContainer.alpha = 1
            self?.layoutIfNeeded()
        }
    }
    
    func animateHide()
    {
        layoutBaseBottom.constant = kBaseHeight
        
        UIView.animate(
        withDuration:kAnimationDuration,
        animations:
        { [weak self] in
            
            self?.alpha = 0
            self?.layoutIfNeeded()
        })
        { [weak self] (done:Bool) in
            
            self?.controller.back()
        }
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        guard
            
            let _:MFavorites = controller.model
            
        else
        {
            return 0
        }
        
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model!.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MFavoritesItem = modelAtIndex(index:indexPath)
        let cell:VFavoritesCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VFavoritesCell.reusableIdentifier,
            for:indexPath) as! VFavoritesCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        collectionView.isUserInteractionEnabled = false
        let item:MFavoritesItem = modelAtIndex(index:indexPath)
        controller.selectItem(item:item)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAfterSelect)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
            collectionView?.isUserInteractionEnabled = true
        }
    }
}
