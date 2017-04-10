import UIKit

class VSettingsCellRetina:VSettingsCell
{
    private weak var check:UISwitch!
    private let kCheckWidth:CGFloat = 110
    private let kCheckHeight:CGFloat = 60
    private let kCheckTop:CGFloat = 30
    private let kTitleLeft:CGFloat = 10
    private let kTitleWidth:CGFloat = 145
    private let kStepperStep:Double = 10
    private let kMinStepper:Double = 10
    private let kMaxStepper:Double = 100
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bold(size:15)
        labelTitle.textColor = UIColor.white
        labelTitle.numberOfLines = 2
        labelTitle.text = NSLocalizedString("VSettingsCellRetina_labelTitle", comment:"")
        
        let check:UISwitch = UISwitch()
        check.translatesAutoresizingMaskIntoConstraints = false
        check.clipsToBounds = true
        check.tintColor = UIColor.white
        check.onTintColor = UIColor.hyperOrange
        check.addTarget(
            self,
            action:#selector(actionCheck(sender:)),
            for:UIControlEvents.valueChanged)
        self.check = check
        
        addSubview(labelTitle)
        addSubview(check)
        
        NSLayoutConstraint.topToTop(
            view:check,
            toView:self,
            constant:kCheckTop)
        NSLayoutConstraint.height(
            view:check,
            constant:kCheckHeight)
        NSLayoutConstraint.rightToRight(
            view:check,
            toView:self)
        NSLayoutConstraint.width(
            view:check,
            constant:kCheckWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kTitleLeft)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
        
        guard
            
            let shareRetina:Bool = MSession.sharedInstance.settings?.shareRetina
            
        else
        {
            return
        }
        
        check.isOn = shareRetina
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionCheck(sender check:UISwitch)
    {
        MSession.sharedInstance.settings?.shareRetina = check.isOn
        DManager.sharedInstance?.save()
    }
}
