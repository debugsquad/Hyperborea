import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    private weak var labelTitle:UILabel!
    private weak var imageView:UIImageView!
    private weak var buttonThesaurus:UIButton!
    private weak var buttonTranslate:UIButton!
    private weak var buttonLanguage:UIButton!
    private let kContentTop:CGFloat = 20
    private let kImageLeft:CGFloat = 8
    private let kImageWidth:CGFloat = 22
    private let kTitleLeft:CGFloat = 4
    private let kTitleWidth:CGFloat = 105
    private let kButtonsWidth:CGFloat = 45
    private let kButtonsRight:CGFloat = -5
    
    convenience init(controller:CParent)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "assetHomeSearch")
        self.imageView = imageView
        
        let buttonThesaurus:UIButton = UIButton()
        buttonThesaurus.translatesAutoresizingMaskIntoConstraints = false
        buttonThesaurus.setImage(
            #imageLiteral(resourceName: "assetHomeSearch"),
            for:UIControlState.normal)
        buttonThesaurus.imageView!.clipsToBounds = true
        buttonThesaurus.imageView!.contentMode = UIViewContentMode.center
        buttonThesaurus.alpha = 0.2
        buttonThesaurus.isHidden = true
        self.buttonThesaurus = buttonThesaurus
        
        let buttonTranslate:UIButton = UIButton()
        buttonTranslate.translatesAutoresizingMaskIntoConstraints = false
        buttonTranslate.setImage(
            #imageLiteral(resourceName: "assetHomeSearch"),
            for:UIControlState.normal)
        buttonTranslate.imageView!.clipsToBounds = true
        buttonTranslate.imageView!.contentMode = UIViewContentMode.center
        buttonTranslate.alpha = 0.2
        buttonTranslate.isHidden = true
        self.buttonTranslate = buttonTranslate
        
        let buttonLanguage:UIButton = UIButton()
        buttonLanguage.translatesAutoresizingMaskIntoConstraints = false
        buttonLanguage.imageView!.clipsToBounds = true
        buttonLanguage.imageView!.contentMode = UIViewContentMode.center
        buttonLanguage.addTarget(
            self,
            action:#selector(self.actionLanguage(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonLanguage = buttonLanguage
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.font = UIFont.bold(size:13)
        labelTitle.textColor = UIColor.black
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.text = NSLocalizedString("VParentBar_titleDictionary", comment:"")
        self.labelTitle = labelTitle

        addSubview(labelTitle)
        addSubview(imageView)
        addSubview(buttonThesaurus)
        addSubview(buttonTranslate)
        addSubview(buttonLanguage)
        
        let layoutImageViewLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:kImageLeft)
        let layoutImageViewWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kImageWidth)
        let layoutImageViewTop:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kContentTop)
        let layoutImageViewBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        
        let layoutButtonLanguageRight:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonLanguage,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:kButtonsRight)
        let layoutButtonLanguageWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonLanguage,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kButtonsWidth)
        let layoutButtonLanguageTop:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonLanguage,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kContentTop)
        let layoutButtonLanguageBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonLanguage,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        
        let layoutButtonTranslateRight:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonTranslate,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:buttonLanguage,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutButtonTranslateWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonTranslate,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kButtonsWidth)
        let layoutButtonTranslateTop:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonTranslate,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kContentTop)
        let layoutButtonTranslateBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonTranslate,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        
        let layoutButtonThesaurusRight:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonThesaurus,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:buttonTranslate,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutButtonThesaurusWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonThesaurus,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kButtonsWidth)
        let layoutButtonThesaurusTop:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonThesaurus,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kContentTop)
        let layoutButtonThesaurusBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonThesaurus,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        
        let layoutLabelTitleLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:imageView,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:kTitleLeft)
        let layoutLabelTitleWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kTitleWidth)
        let layoutLabelTitleTop:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kContentTop)
        let layoutLabelTitleBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        
        addConstraints([
            layoutImageViewLeft,
            layoutImageViewWidth,
            layoutImageViewTop,
            layoutImageViewBottom,
            layoutButtonLanguageTop,
            layoutButtonLanguageBottom,
            layoutButtonLanguageRight,
            layoutButtonLanguageWidth,
            layoutButtonTranslateTop,
            layoutButtonTranslateBottom,
            layoutButtonTranslateRight,
            layoutButtonTranslateWidth,
            layoutButtonThesaurusTop,
            layoutButtonThesaurusBottom,
            layoutButtonThesaurusRight,
            layoutButtonThesaurusWidth,
            layoutLabelTitleTop,
            layoutLabelTitleLeft,
            layoutLabelTitleWidth,
            layoutLabelTitleBottom
            ])
        
        loadLanguage()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedLanguageChanged(sender:)),
            name:Notification.languageChanged,
            object:nil)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notified
    
    func notifiedLanguageChanged(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.loadLanguage()
        }
    }
    
    //MARK: actions
    
    func actionLanguage(sender button:UIButton)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        controller.viewParent.restartScroll()
        
        let controllerLanguage:CHomeLanguage = CHomeLanguage()
        controller.animateOver(controller:controllerLanguage)
    }
    
    //MARK: private
    
    func loadLanguage()
    {
        let languageImage:UIImage? = MSession.sharedInstance.language?.image
        buttonLanguage.setImage(
            languageImage,
            for:UIControlState.normal)
    }
}
