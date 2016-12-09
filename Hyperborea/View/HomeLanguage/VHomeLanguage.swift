import UIKit

class VHomeLanguage:VView
{
    private weak var controller:CHomeLanguage!
    private weak var layoutOrbHorizontalLeft:NSLayoutConstraint!
    private weak var layoutOrbHorizontalTop:NSLayoutConstraint!
    private weak var layoutOrbVerticalLeft:NSLayoutConstraint!
    private weak var layoutOrbVerticalTop:NSLayoutConstraint!
    private let kAlpha:CGFloat = 0.7
    
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
        
        if MSession.sharedInstance.language.languangeId == modelHorizontal.languangeId
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
        
        addConstraints([
            layoutButtonDismissTop,
            layoutButtonDismissBottom,
            layoutButtonDismissLeft,
            layoutButtonDismissRight])
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
}
