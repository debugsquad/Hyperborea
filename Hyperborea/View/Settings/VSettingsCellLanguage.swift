import UIKit

class VSettingsCellLanguage:VSettingsCell
{
    private weak var buttonEnglish:VSettingsCellLanguageButton!
    private weak var buttonSpanish:VSettingsCellLanguageButton!
    private weak var layoutButtonEnglishLeft:NSLayoutConstraint!
    private let buttonsWidth:CGFloat
    private let kButtonSize:CGFloat = 60
    private let kInterButtons:CGFloat = 10
    private let kButtonTop:CGFloat = 30
    private let kButtonBottom:CGFloat = -10
    
    override init(frame:CGRect)
    {
        buttonsWidth = kButtonSize + kButtonSize + kInterButtons
        
        super.init(frame:frame)
        
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
        newLangugage(language:DSettings.Language.english)
    }
    
    func actionSpanish(sender button:UIButton)
    {
        newLangugage(language:DSettings.Language.spanish)
    }
    
    //MARK: private
    
    private func updateLanguages()
    {
        guard
        
            let language:DSettings.Language = MSession.sharedInstance.settings?.currentLanguage()
        
        else
        {
            return
        }
        
        switch language
        {
        case DSettings.Language.english:
            
            buttonEnglish.isSelected = true
            buttonSpanish.isSelected = false
            
            break
            
        case DSettings.Language.spanish:
            
            buttonEnglish.isSelected = false
            buttonSpanish.isSelected = true
            
            break
        }
    }
    
    private func newLangugage(language:DSettings.Language)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            MSession.sharedInstance.settings?.changeLanguage(language:language)
            
            DispatchQueue.main.async
            { [weak self] in
                
                self?.updateLanguages()
            }
        }
    }
}
