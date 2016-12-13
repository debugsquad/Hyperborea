import UIKit

class VHomeFroob:VView
{
    private weak var controller:CHomeFroob!
    private weak var layoutBaseViewLeft:NSLayoutConstraint!
    private weak var layoutBaseViewTop:NSLayoutConstraint!
    private let kBaseWidth:CGFloat = 310
    private let kBaseHeight:CGFloat = 200
    private let kButtonHeight:CGFloat = 42
    private let kCornerRadius:CGFloat = 18
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CHomeFroob
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.isUserInteractionEnabled = false
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        
        let baseButton:UIButton = UIButton()
        baseButton.clipsToBounds = true
        baseButton.backgroundColor = UIColor.clear
        baseButton.translatesAutoresizingMaskIntoConstraints = false
        baseButton.addTarget(
            self,
            action:#selector(self.actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let baseView:UIView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        baseView.backgroundColor = UIColor.white
        baseView.layer.borderWidth = 0.5
        baseView.layer.borderColor = UIColor(white:0, alpha:0.8).cgColor
        baseView.layer.cornerRadius = kCornerRadius
        
        addSubview(visualEffect)
        addSubview(baseButton)
        addSubview(baseView)
        
        let layoutVisualEffectTop:NSLayoutConstraint = NSLayoutConstraint(
            item:visualEffect,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutVisualEffectBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:visualEffect,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutVisualEffectLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:visualEffect,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutVisualEffectRight:NSLayoutConstraint = NSLayoutConstraint(
            item:visualEffect,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        let layoutBaseButtonTop:NSLayoutConstraint = NSLayoutConstraint(
            item:baseButton,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutBaseButtonBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:baseButton,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutBaseButtonLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:baseButton,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutBaseButtonRight:NSLayoutConstraint = NSLayoutConstraint(
            item:baseButton,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        layoutBaseViewTop = NSLayoutConstraint(
            item:baseView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        layoutBaseViewLeft = NSLayoutConstraint(
            item:baseView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutBaseViewWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:baseView,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kBaseWidth)
        let layoutBaseViewHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:baseView,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kBaseHeight)
        
        addConstraints([
            layoutVisualEffectTop,
            layoutVisualEffectBottom,
            layoutVisualEffectLeft,
            layoutVisualEffectRight,
            layoutBaseButtonTop,
            layoutBaseButtonBottom,
            layoutBaseButtonLeft,
            layoutBaseButtonRight,
            layoutBaseViewTop,
            layoutBaseViewLeft,
            layoutBaseViewWidth,
            layoutBaseViewHeight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let remainLeft:CGFloat = width - kBaseWidth
        let remainTop:CGFloat = height - kBaseHeight
        let marginLeft:CGFloat = remainLeft / 2.0
        let marginTop:CGFloat = remainTop / 2.0
        layoutBaseViewLeft.constant = marginLeft
        layoutBaseViewTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.close()
    }
}
