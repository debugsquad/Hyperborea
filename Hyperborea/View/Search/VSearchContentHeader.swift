import UIKit

class VSearchContentHeader:UICollectionReusableView
{
    private weak var controller:CSearch?
    private weak var buttonFavorite:UIButton!
    private let kButtonWidth:CGFloat = 60
    private let kButtonsRight:CGFloat = -10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let buttonShare:UIButton = UIButton()
        buttonShare.translatesAutoresizingMaskIntoConstraints = false
        buttonShare.setImage(
            #imageLiteral(resourceName: "assetGenericShare").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonShare.setImage(
            #imageLiteral(resourceName: "assetGenericShare").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonShare.imageView!.tintColor = UIColor(white:0, alpha:0.1)
        buttonShare.imageView!.clipsToBounds = true
        buttonShare.imageView!.contentMode = UIViewContentMode.center
        buttonShare.addTarget(
            self,
            action:#selector(actionShare(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonFavorite:UIButton = UIButton()
        buttonFavorite.translatesAutoresizingMaskIntoConstraints = false
        buttonFavorite.setImage(
            #imageLiteral(resourceName: "assetGenericFavoriteOff").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonFavorite.setImage(
            #imageLiteral(resourceName: "assetGenericFavoriteOn").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.highlighted)
        buttonFavorite.setImage(
            #imageLiteral(resourceName: "assetGenericFavoriteOn").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.selected)
        buttonFavorite.imageView!.clipsToBounds = true
        buttonFavorite.imageView!.contentMode = UIViewContentMode.center
        buttonFavorite.addTarget(
            self,
            action:#selector(actionFavorite(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonFavorite = buttonFavorite
        
        addSubview(buttonShare)
        addSubview(buttonFavorite)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonShare,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonShare,
            toView:self,
            constant:kButtonsRight)
        NSLayoutConstraint.width(
            view:buttonShare,
            constant:kButtonWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonFavorite,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:buttonFavorite,
            toView:buttonShare)
        NSLayoutConstraint.width(
            view:buttonFavorite,
            constant:kButtonWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: action
    
    func actionShare(sender button:UIButton)
    {
        guard
            
            let controller:CSearch = self.controller,
            let attributedString:NSAttributedString = controller.viewSearch.viewContent?.viewMode.model.currentItem().usingString(
                controller:controller)
        
        else
        {
            return
        }
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            controller.share(string:attributedString)
        }
    }
    
    func actionFavorite(sender button:UIButton)
    {
        guard
        
            let entry:MSearchEntry = controller?.modelEntry
        
        else
        {
            return
        }
        
        if button.isSelected
        {
            button.isSelected = false
            
            MSession.sharedInstance.settings?.unFavorite(
                wordId:entry.wordId,
                languageRaw:entry.languageRaw)
        }
        else
        {
            button.isSelected = true
            
            MSession.sharedInstance.settings?.makeFavorite(
                wordId:entry.wordId,
                word:entry.word,
                languageRaw:entry.languageRaw,
                region:entry.region)
        }
    }
    
    //MARK: private
    
    private func validateFavorite()
    {
        guard
        
            let entry:MSearchEntry = controller?.modelEntry,
            let favorited:Bool = MSession.sharedInstance.settings?.isFavorited(
                wordId:entry.wordId,
                languageRaw:entry.languageRaw)
        
        else
        {
            return
        }
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.buttonFavorite.isSelected = favorited
        }
    }
    
    //MARK: public
    
    func config(controller:CSearch)
    {
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.validateFavorite()
        }
    }
}
