import UIKit

class VSettings:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private let model:MSettings
    private weak var controller:CSettings!
    private weak var collectionView:VCollection!
    private(set) weak var viewBar:VSettingsBar!
    private(set) weak var viewBackground:VSettingsBackground!
    private weak var layoutBarHeight:NSLayoutConstraint!
    private let kMaxBarHeight:CGFloat = 200
    private let kCollectionBottom:CGFloat = 20
    private let kButtonBackWidth:CGFloat = 60
    private let kButtonBackHeight:CGFloat = 47
    private let kButtonBackBottom:CGFloat = -133
    
    override init(controller:CController)
    {
        model = MSettings()
        
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CSettings
        
        let viewGradient:VSettingsGradient = VSettingsGradient()
        
        let viewBar:VSettingsBar = VSettingsBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let viewBackground:VSettingsBackground = VSettingsBackground()
        self.viewBackground = viewBackground
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VSettingsCellLanguage.self)
        collectionView.registerCell(cell:VSettingsCellResults.self)
        collectionView.registerCell(cell:VSettingsCellRetina.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.sectionInset = UIEdgeInsets(
                top:kMaxBarHeight,
                left:0,
                bottom:kCollectionBottom,
                right:0)
        }
        
        let buttonBack:UIButton = UIButton()
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBackWhite").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBackWhite").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonBack.imageView!.clipsToBounds = true
        buttonBack.imageView!.contentMode = UIViewContentMode.center
        buttonBack.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        buttonBack.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(viewGradient)
        addSubview(viewBackground)
        addSubview(collectionView)
        addSubview(viewBar)
        addSubview(buttonBack)
        
        NSLayoutConstraint.equals(
            view:viewGradient,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar,
            constant:kMaxBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewBackground,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonBack,
            toView:viewBar,
            constant:kButtonBackBottom)
        NSLayoutConstraint.height(
            view:buttonBack,
            constant:kButtonBackHeight)
        NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonBack,
            constant:kButtonBackWidth)
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
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSettingsItem
    {
        let item:MSettingsItem = model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func clean()
    {
        viewBackground.timer?.invalidate()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MSettingsItem = modelAtIndex(index:indexPath)
        let width:CGFloat = collectionView.bounds.size.width
        let size:CGSize = CGSize(width:width, height:item.cellHeight)
        
        return size
    }
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        let offsetY:CGFloat = scrollView.contentOffset.y
        var newBarHeight:CGFloat = kMaxBarHeight - offsetY
        
        if newBarHeight < 0
        {
            newBarHeight = 0
        }
        
        layoutBarHeight.constant = newBarHeight
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let item:MSettingsItem = modelAtIndex(index:indexPath)
        let cell:VSettingsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.reusableIdentifier,
            for:indexPath) as! VSettingsCell
        cell.config(model:item, controller:controller)
        
        return cell
    }
}
