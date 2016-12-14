import UIKit

class VHomeLanguage:VView
{
    private weak var controller:CHomeLanguage!
    private weak var layoutOrbHorizontalLeft:NSLayoutConstraint!
    private weak var layoutOrbVerticalTop:NSLayoutConstraint!
    private let kAnimationDuration:TimeInterval = 0.3
    private let kAlpha:CGFloat = 0.8
    private let kStartingLeft:CGFloat = -62
    private let kStartingTop:CGFloat = 7
    private let kFinalLeft:CGFloat = -120
    private let kFinalTop:CGFloat = 75
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(white:0, alpha:kAlpha)
        self.controller = controller as? CHomeLanguage
        
        let modelHorizontal:MSessionLanguageEnglish = MSessionLanguageEnglish()
        let modelVertical:MSessionLanguageSpanish = MSessionLanguageSpanish()
        
        let buttonDismiss:UIButton = UIButton()
        buttonDismiss.translatesAutoresizingMaskIntoConstraints = false
        buttonDismiss.backgroundColor = UIColor.clear
        buttonDismiss.addTarget(
            self,
            action:#selector(self.actionDismiss(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let orbHorizontal:VHomeLanguageOrb = VHomeLanguageOrb(
            controller:self.controller,
            model:modelHorizontal)
        
        let orbVertical:VHomeLanguageOrb = VHomeLanguageOrb(
            controller:self.controller,
            model:modelVertical)
        
        let orbCenter:VHomeLanguageOrb = VHomeLanguageOrb(
            controller:self.controller,
            model:nil)
        
        addSubview(buttonDismiss)
        addSubview(orbCenter)
        
        if MSession.sharedInstance.language?.languageId == modelHorizontal.languageId
        {
            addSubview(orbVertical)
            addSubview(orbHorizontal)
        }
        else
        {
            addSubview(orbHorizontal)
            addSubview(orbVertical)
        }
        
        let layoutButtonDismissTop:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonDismiss,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutButtonDismissBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonDismiss,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutButtonDismissLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonDismiss,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutButtonDismissRight:NSLayoutConstraint = NSLayoutConstraint(
            item:buttonDismiss,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        layoutOrbHorizontalLeft = NSLayoutConstraint(
            item:orbHorizontal,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:kStartingLeft)
        let layoutOrbHorizontalTop:NSLayoutConstraint = NSLayoutConstraint(
            item:orbHorizontal,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kStartingTop)
        
        let layoutOrbVerticalLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:orbVertical,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:kStartingLeft)
        layoutOrbVerticalTop = NSLayoutConstraint(
            item:orbVertical,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kStartingTop)
        
        let layoutOrbCenterLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:orbCenter,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:kStartingLeft)
        let layoutOrbCenterTop:NSLayoutConstraint = NSLayoutConstraint(
            item:orbCenter,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kStartingTop)
        
        addConstraints([
            layoutButtonDismissTop,
            layoutButtonDismissBottom,
            layoutButtonDismissLeft,
            layoutButtonDismissRight,
            layoutOrbHorizontalLeft,
            layoutOrbHorizontalTop,
            layoutOrbVerticalLeft,
            layoutOrbVerticalTop,
            layoutOrbCenterLeft,
            layoutOrbCenterTop])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionDismiss(sender button:UIButton)
    {
        controller.dismiss()
    }
    
    //MARK: public
    
    func viewDidAppear()
    {
        layoutOrbVerticalTop.constant = kFinalTop
        layoutOrbHorizontalLeft.constant = kFinalLeft
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    func viewWillDisappear()
    {
        layoutOrbVerticalTop.constant = kStartingTop
        layoutOrbHorizontalLeft.constant = kStartingLeft
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
