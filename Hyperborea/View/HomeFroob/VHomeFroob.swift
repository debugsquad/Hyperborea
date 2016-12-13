import UIKit

class VHomeFroob:VView
{
    private weak var controller:CHomeFroob!
    private weak var clock:VHomeFroobClock?
    private weak var layoutBaseViewLeft:NSLayoutConstraint!
    private weak var layoutBaseViewTop:NSLayoutConstraint!
    private let kBaseWidth:CGFloat = 299
    private let kBaseHeight:CGFloat = 180
    private let kButtonHeight:CGFloat = 54
    private let kCornerRadius:CGFloat = 20
    private let kClockHeight:CGFloat = 35
    private let kClockTop:CGFloat = 35
    private let kLabelTitleHeight:CGFloat = 25
    private let kLabelDescrHeight:CGFloat = 20
    private let kImageTop:CGFloat = -40
    private let kImageHeight:CGFloat = 80
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CHomeFroob
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.dark)
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
        baseView.layer.cornerRadius = kCornerRadius
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.font = UIFont.bold(size:20)
        labelTitle.textColor = UIColor.black
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.text = NSLocalizedString("VHomeFroob_title", comment:"")
        
        let labelDescr:UILabel = UILabel()
        labelDescr.isUserInteractionEnabled = false
        labelDescr.font = UIFont.regular(size:15)
        labelDescr.textColor = UIColor.black
        labelDescr.textAlignment = NSTextAlignment.center
        labelDescr.backgroundColor = UIColor.clear
        labelDescr.numberOfLines = 0
        labelDescr.translatesAutoresizingMaskIntoConstraints = false
        labelDescr.text = NSLocalizedString("VHomeFroob_descr", comment:"")
        
        let clock:VHomeFroobClock = VHomeFroobClock(controller:self.controller)
        self.clock = clock
        
        let buttons:VHomeFroobButtons = VHomeFroobButtons(controller:self.controller)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericPlus")
        
        baseView.addSubview(clock)
        baseView.addSubview(labelTitle)
        baseView.addSubview(labelDescr)
        baseView.addSubview(buttons)
        addSubview(visualEffect)
        addSubview(baseButton)
        addSubview(baseView)
        addSubview(imageView)
        
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
        
        let layoutClockTop:NSLayoutConstraint = NSLayoutConstraint(
            item:clock,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:baseView,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kClockTop)
        let layoutClockHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:clock,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kClockHeight)
        let layoutClockLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:clock,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:baseView,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutClockRight:NSLayoutConstraint = NSLayoutConstraint(
            item:clock,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:baseView,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        let layoutLabelTitleTop:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:clock,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutLabelTitleHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kLabelTitleHeight)
        let layoutLabelTitleLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:baseView,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutLabelTitleRight:NSLayoutConstraint = NSLayoutConstraint(
            item:labelTitle,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:baseView,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        let layoutLabelDescrTop:NSLayoutConstraint = NSLayoutConstraint(
            item:labelDescr,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:labelTitle,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutLabelDescrHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:labelDescr,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kLabelDescrHeight)
        let layoutLabelDescrLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:labelDescr,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:baseView,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutLabelDescrRight:NSLayoutConstraint = NSLayoutConstraint(
            item:labelDescr,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:baseView,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        let layoutImageViewTop:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:baseView,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kImageTop)
        let layoutImageViewHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kImageHeight)
        let layoutImageViewLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutImageViewRight:NSLayoutConstraint = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        let layoutButtonsHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:buttons,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kButtonHeight)
        let layoutButtonsBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:buttons,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:baseView,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutButtonsLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:buttons,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:baseView,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutButtonsRight:NSLayoutConstraint = NSLayoutConstraint(
            item:buttons,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:baseView,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
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
            layoutBaseViewHeight,
            layoutClockTop,
            layoutClockHeight,
            layoutClockLeft,
            layoutClockRight,
            layoutLabelTitleTop,
            layoutLabelTitleHeight,
            layoutLabelTitleLeft,
            layoutLabelTitleRight,
            layoutLabelDescrTop,
            layoutLabelDescrHeight,
            layoutLabelDescrLeft,
            layoutLabelDescrRight,
            layoutImageViewTop,
            layoutImageViewHeight,
            layoutImageViewLeft,
            layoutImageViewRight,
            layoutButtonsHeight,
            layoutButtonsBottom,
            layoutButtonsLeft,
            layoutButtonsRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        clock?.timer?.invalidate()
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
