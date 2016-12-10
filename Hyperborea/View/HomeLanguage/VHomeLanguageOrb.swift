import UIKit

class VHomeLanguageOrb:UIView
{
    private weak var controller:CHomeLanguage!
    private let model:MSessionLanguage?
    private let kAnimationDuration:TimeInterval = 1.5
    private let kTotalSize:CGFloat = 70
    private let kBackgroundSize:CGFloat = 36
    private let kBackgroundAlpha:CGFloat = 0.7
    private let kLabelHeight:CGFloat = 18
    
    init(controller:CHomeLanguage, model:MSessionLanguage?)
    {
        self.model = model
        self.controller = controller
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let marginSize:CGFloat = (kTotalSize - kBackgroundSize) / 2.0
        
        let background:UIView = UIView()
        background.clipsToBounds = true
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = UIColor(white:0, alpha:kBackgroundAlpha)
        background.layer.cornerRadius = kBackgroundSize / 2.0
        
        addSubview(background)
        
        if let modelReceived:MSessionLanguage = model
        {
            let label:UILabel = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.isUserInteractionEnabled = false
            label.backgroundColor = UIColor.clear
            label.font = UIFont.bold(size:12)
            label.textAlignment = NSTextAlignment.center
            label.textColor = UIColor.white
            label.text = modelReceived.name
            label.alpha = 0
            
            let button:UIButton = UIButton()
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor.clear
            button.setImage(
                modelReceived.image,
                for:UIControlState.normal)
            button.imageView!.contentMode = UIViewContentMode.center
            button.imageView!.clipsToBounds = true
            button.addTarget(
                self,
                action:#selector(self.actionOrb(sender:)),
                for:UIControlEvents.touchUpInside)
            
            addSubview(label)
            background.addSubview(button)
            
            let layoutButtonTop:NSLayoutConstraint = NSLayoutConstraint(
                item:button,
                attribute:NSLayoutAttribute.top,
                relatedBy:NSLayoutRelation.equal,
                toItem:background,
                attribute:NSLayoutAttribute.top,
                multiplier:1,
                constant:0)
            let layoutButtonLeft:NSLayoutConstraint = NSLayoutConstraint(
                item:button,
                attribute:NSLayoutAttribute.left,
                relatedBy:NSLayoutRelation.equal,
                toItem:background,
                attribute:NSLayoutAttribute.left,
                multiplier:1,
                constant:0)
            let layoutButtonRight:NSLayoutConstraint = NSLayoutConstraint(
                item:button,
                attribute:NSLayoutAttribute.right,
                relatedBy:NSLayoutRelation.equal,
                toItem:background,
                attribute:NSLayoutAttribute.right,
                multiplier:1,
                constant:0)
            let layoutButtonBottom:NSLayoutConstraint = NSLayoutConstraint(
                item:button,
                attribute:NSLayoutAttribute.bottom,
                relatedBy:NSLayoutRelation.equal,
                toItem:background,
                attribute:NSLayoutAttribute.bottom,
                multiplier:1,
                constant:0)
            
            let layoutLabelHeight:NSLayoutConstraint = NSLayoutConstraint(
                item:label,
                attribute:NSLayoutAttribute.height,
                relatedBy:NSLayoutRelation.equal,
                toItem:nil,
                attribute:NSLayoutAttribute.notAnAttribute,
                multiplier:1,
                constant:kLabelHeight)
            let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint(
                item:label,
                attribute:NSLayoutAttribute.left,
                relatedBy:NSLayoutRelation.equal,
                toItem:self,
                attribute:NSLayoutAttribute.left,
                multiplier:1,
                constant:0)
            let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint(
                item:label,
                attribute:NSLayoutAttribute.right,
                relatedBy:NSLayoutRelation.equal,
                toItem:self,
                attribute:NSLayoutAttribute.right,
                multiplier:1,
                constant:0)
            let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint(
                item:label,
                attribute:NSLayoutAttribute.bottom,
                relatedBy:NSLayoutRelation.equal,
                toItem:self,
                attribute:NSLayoutAttribute.bottom,
                multiplier:1,
                constant:0)
            
            background.addConstraints([
                layoutButtonTop,
                layoutButtonBottom,
                layoutButtonLeft,
                layoutButtonRight])
            
            addConstraints([
                layoutLabelHeight,
                layoutLabelLeft,
                layoutLabelRight,
                layoutLabelBottom])
            
            UIView.animate(
                withDuration:kAnimationDuration)
            { [weak label] in
                
                label?.alpha = 1
            }
        }
        else
        {
            background.isUserInteractionEnabled = false
            isUserInteractionEnabled = false
        }
        
        let layoutBackgroundTop:NSLayoutConstraint = NSLayoutConstraint(
            item:background,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:marginSize)
        let layoutBackgroundLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:background,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:marginSize)
        let layoutBackgroundWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:background,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kBackgroundSize)
        let layoutBackgroundHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:background,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kBackgroundSize)
        
        addConstraints([
            layoutBackgroundTop,
            layoutBackgroundLeft,
            layoutBackgroundWidth,
            layoutBackgroundHeight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override var intrinsicContentSize:CGSize
    {
        get
        {
            let size:CGSize = CGSize(
                width:kTotalSize,
                height:kTotalSize)
            
            return size
        }
    }
    
    //MARK: actions
    
    func actionOrb(sender button:UIButton)
    {
        guard
        
            let model:MSessionLanguage = self.model
        
        else
        {
            return
        }
        
        controller.selectLanguage(model:model)
    }
}
