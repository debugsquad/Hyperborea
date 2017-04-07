import UIKit

class VSettingsCellResults:VSettingsCell
{
    private weak var stepper:UIStepper!
    private weak var labelCount:UILabel!
    private let kStepperWidth:CGFloat = 110
    private let kStepperHeight:CGFloat = 60
    private let kStepperTop:CGFloat = 30
    private let kCounterRight:CGFloat = -10
    private let kCounterWidth:CGFloat = 70
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
        labelTitle.text = NSLocalizedString("VSettingsCellResults_labelTitle", comment:"")
        
        let labelCounter:UILabel = UILabel()
        labelCounter.isUserInteractionEnabled = false
        labelCounter.translatesAutoresizingMaskIntoConstraints = false
        labelCounter.backgroundColor = UIColor.clear
        labelCounter.textAlignment = NSTextAlignment.right
        labelCounter.font = UIFont.numeric(size:28)
        labelCounter.textColor = UIColor.white
        self.labelCount = labelCounter
        
        let stepper:UIStepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.clipsToBounds = true
        stepper.tintColor = UIColor.white
        stepper.minimumValue = kMinStepper
        stepper.maximumValue = kMaxStepper
        stepper.stepValue = kStepperStep
        stepper.addTarget(
            self,
            action:#selector(actionStepper(sender:)),
            for:UIControlEvents.valueChanged)
        self.stepper = stepper
        
        addSubview(labelTitle)
        addSubview(labelCounter)
        addSubview(stepper)
        
        printCounter()
        
        NSLayoutConstraint.topToTop(
            view:stepper,
            toView:self,
            constant:kStepperTop)
        NSLayoutConstraint.height(
            view:stepper,
            constant:kStepperHeight)
        NSLayoutConstraint.rightToRight(
            view:stepper,
            toView:self)
        NSLayoutConstraint.width(
            view:stepper,
            constant:kStepperWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelCounter,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelCounter,
            toView:stepper,
            constant:kCounterRight)
        NSLayoutConstraint.width(
            view:labelCounter,
            constant:kCounterWidth)
        
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionStepper(sender stepper:UIStepper)
    {
        printCounter()
    }
    
    //MARK: private
    
    func printCounter()
    {
        let value:Int = Int(stepper.value)
        let string:String = "\(value)"
        labelCount.text = string
    }
}
