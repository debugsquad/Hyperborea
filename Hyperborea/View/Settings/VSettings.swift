import UIKit

class VSettings:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CSettings!
    private weak var collectionView:VCollection!
    private(set) weak var viewBar:VSettingsBar!
    private(set) weak var viewBackground:VSettingsBackground!
    private weak var layoutBarHeight:NSLayoutConstraint!
    private let kMaxBarHeight:CGFloat = 200
    private let kCollectionBottom:CGFloat = 20
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.hyperBlue
        self.controller = controller as? CSettings
        
        let viewBar:VSettingsBar = VSettingsBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let viewBackground:VSettingsBackground = VSettingsBackground()
        self.viewBackground = viewBackground
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VSettingsCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.sectionInset = UIEdgeInsets(
                top:kMaxBarHeight,
                left:0,
                bottom:kCollectionBottom,
                right:0)
        }
        
        addSubview(viewBackground)
        addSubview(collectionView)
        addSubview(viewBar)
        
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func clean()
    {
        viewBackground.timer?.invalidate()
    }
    
    //MARK: collectionView delegate
    
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
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:VSettingsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VSettingsCell.reusableIdentifier,
            for:indexPath) as! VSettingsCell
        
        return cell
    }
}
