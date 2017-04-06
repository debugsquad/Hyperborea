import UIKit

class VRecent:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CRecent!
    private weak var collectionView:VCollection!
    private weak var blurContainer:UIView!
    private weak var layoutBaseBottom:NSLayoutConstraint!
    private let kBaseHeight:CGFloat = 470
    private let kBarHeight:CGFloat = 60
    private let kAnimationDuration:TimeInterval = 0.3
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CRecent
        
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
        baseView.backgroundColor = UIColor.white
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        
        let viewBar:VRecentBar = VRecentBar(
            controller:self.controller)
        
        baseView.addSubview(viewBar)
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        animateHide()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MRecentEntry
    {
        let item:MRecentEntry = controller.model!.sections[index.section].items[index.item]
        
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
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        guard
        
            let count:Int = controller.model?.sections.count
        
        else
        {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model!.sections[section].items.count
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:VRecentHeader
    }
}
