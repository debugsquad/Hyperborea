import UIKit

class VSettingsCellLanguage:VSettingsCell
{
    private weak var buttonEnglish:VSettingsCellLanguageButton!
    private weak var buttonSpanish:VSettingsCellLanguageButton!
    private weak var layoutButtonEnglishLeft:NSLayoutConstraint!
    private let buttonsWidth:CGFloat
    private let kButtonSize:CGFloat = 60
    private let kInterButtons:CGFloat = 30
    private let kMarginVertical:CGFloat = 10
    
    override init(frame:CGRect)
    {
        buttonsWidth = kButtonSize + kButtonSize + kInterButtons
        
        super.init(frame:frame)
        
        let buttonEnglish:VSettingsCellLanguageButton = VSettingsCellLanguageButton(
            imageOn:#imageLiteral(resourceName: "assetGenericEnglishOn"),
            imageOff:#imageLiteral(resourceName: "assetGenericEnglishOff"))
        self.buttonEnglish = buttonEnglish
        
        let buttonSpanish:VSettingsCellLanguageButton = VSettingsCellLanguageButton(
            imageOn:#imageLiteral(resourceName: "assetGenericSpanishOn"),
            imageOff:#imageLiteral(resourceName: "assetGenericSpanishOff"))
        self.buttonSpanish = buttonSpanish
        
        addSubview(buttonEnglish)
        addSubview(buttonSpanish)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonEnglish,
            toView:self,
            margin:kMarginVertical)
        layoutButtonEnglishLeft = NSLayoutConstraint.leftToLeft(
            view:buttonEnglish,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonEnglish,
            constant:kButtonSize)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonSpanish,
            toView:self,
            margin:kMarginVertical)
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
}
