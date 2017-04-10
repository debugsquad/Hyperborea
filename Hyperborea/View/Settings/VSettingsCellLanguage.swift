import UIKit

class VSettingsCellLanguage:VSettingsCell
{
    private weak var buttonEnglish:VSettingsCellLanguageButton!
    private weak var buttonSpanish:VSettingsCellLanguageButton!
    private weak var layoutButtonEnglishLeft:NSLayoutConstraint!
    private let buttonsWidth:CGFloat
    private let kButtonSize:CGFloat = 60
    private let kInterButtons:CGFloat = 10
    private let kButtonTop:CGFloat = 40
    private let kButtonBottom:CGFloat = -10
    private let kLabelTitleTop:CGFloat = 20
    private let kLabelTitleHeight:CGFloat = 17
    
    override init(frame:CGRect)
    {
        buttonsWidth = kButtonSize + kButtonSize + kInterButtons
        
        super.init(frame:frame)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.bold(size:14)
        labelTitle.textColor = UIColor.white
        labelTitle.text = NSLocalizedString("VSettingsCellLanguage_labelTitle", comment:"")
        
        let buttonEnglish:VSettingsCellLanguageButton = VSettingsCellLanguageButton(
            imageOn:#imageLiteral(resourceName: "assetGenericEnglishOn"),
            imageOff:#imageLiteral(resourceName: "assetGenericEnglishOff"))
        buttonEnglish.addTarget(
            self,
            action:#selector(actionEnglish(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonEnglish = buttonEnglish
        
        let buttonSpanish:VSettingsCellLanguageButton = VSettingsCellLanguageButton(
            imageOn:#imageLiteral(resourceName: "assetGenericSpanishOn"),
            imageOff:#imageLiteral(resourceName: "assetGenericSpanishOff"))
        buttonSpanish.addTarget(
            self,
            action:#selector(actionSpanish(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonSpanish = buttonSpanish
        
        addSubview(labelTitle)
        addSubview(buttonEnglish)
        addSubview(buttonSpanish)
        
        NSLayoutConstraint.topToTop(
            view:buttonEnglish,
            toView:self,
            constant:kButtonTop)
        NSLayoutConstraint.bottomToBottom(
            view:buttonEnglish,
            toView:self,
            constant:kButtonBottom)
        layoutButtonEnglishLeft = NSLayoutConstraint.leftToLeft(
            view:buttonEnglish,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonEnglish,
            constant:kButtonSize)
        
        NSLayoutConstraint.topToTop(
            view:buttonSpanish,
            toView:self,
            constant:kButtonTop)
        NSLayoutConstraint.bottomToBottom(
            view:buttonSpanish,
            toView:self,
            constant:kButtonBottom)
        NSLayoutConstraint.leftToRight(
            view:buttonSpanish,
            toView:buttonEnglish,
            constant:kInterButtons)
        NSLayoutConstraint.width(
            view:buttonSpanish,
            constant:kButtonSize)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kLabelTitleTop)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kLabelTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        updateLanguages()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainWidth:CGFloat = width - buttonsWidth
        let marginLeft:CGFloat = remainWidth / 2.0
        layoutButtonEnglishLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionEnglish(sender button:UIButton)
    {
        let languageEnglish:MLanguageEnglish = MLanguageEnglish()
        
        newLanguage(language:languageEnglish)
    }
    
    func actionSpanish(sender button:UIButton)
    {
        let languageSpanish:MLanguageSpanish = MLanguageSpanish()
        
        newLanguage(language:languageSpanish)
    }
    
    //MARK: private
    
    private func updateLanguages()
    {
        guard
        
            let language:MLanguage = MSession.sharedInstance.settings?.currentLanguage()
        
        else
        {
            return
        }
        
        if let _:MLanguageEnglish = language as? MLanguageEnglish
        {
            buttonEnglish.isSelected = true
            buttonSpanish.isSelected = false
        }
        else
        {
            buttonEnglish.isSelected = false
            buttonSpanish.isSelected = true
        }
    }
    
    private func newLanguage(language:MLanguage)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            MSession.sharedInstance.settings?.changeLanguage(language:language)
            
            DispatchQueue.main.async
            { [weak self] in
                
                self?.updateLanguages()
            }
            
            NotificationCenter.default.post(
                name:Notification.clearCache,
                object:nil)
        }
    }
}
