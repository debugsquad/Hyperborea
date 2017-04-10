import UIKit

class VFroobPlusContent:UIView
{
    private weak var controller:CFroobPlus!
    private weak var layoutBaseLeft:NSLayoutConstraint!
    private weak var layoutCircleLeft:NSLayoutConstraint!
    private let kBaseWidth:CGFloat = 299
    private let kBaseHeight:CGFloat = 260
    private let kBaseBottom:CGFloat = -2
    private let kCornerRadius:CGFloat = 20
    private let kCircleTop:CGFloat = 2
    private let kCircleSize:CGFloat = 90
    private let kLabelTitleTop:CGFloat = 70
    private let kLabelTitleHeight:CGFloat = 32
    private let kSubtitleMargin:CGFloat = 10
    private let kSubtitleHeight:CGFloat = 120
    private let kButtonsHeight:CGFloat = 62
    
    init(controller:CFroobPlus)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let baseView:UIView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        baseView.backgroundColor = UIColor.white
        baseView.layer.cornerRadius = kCornerRadius
        
        let circle:UIView = UIView()
        circle.isUserInteractionEnabled = false
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.clipsToBounds = true
        circle.backgroundColor = UIColor.white
        circle.layer.cornerRadius = kCircleSize / 2.0
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = purchase.icon
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.bolder(size:20)
        labelTitle.textColor = UIColor.black
        labelTitle.text = purchase.title
        
        let labelSubtitle:UILabel = UILabel()
        labelSubtitle.isUserInteractionEnabled = false
        labelSubtitle.backgroundColor = UIColor.clear
        labelSubtitle.translatesAutoresizingMaskIntoConstraints = false
        labelSubtitle.textAlignment = NSTextAlignment.center
        labelSubtitle.font = UIFont.regular(size:18)
        labelSubtitle.textColor = UIColor.black
        labelSubtitle.numberOfLines = 0
        labelSubtitle.text = NSLocalizedString("VDrawProjectStoreContent_labelSubtitle", comment:"")
        
        let viewButtons:VDrawProjectStoreContentButtons = VDrawProjectStoreContentButtons(
            controller:controller)
        
        circle.addSubview(imageView)
        baseView.addSubview(viewButtons)
        addSubview(baseView)
        addSubview(circle)
        addSubview(labelTitle)
        addSubview(labelSubtitle)
        
        NSLayoutConstraint.bottomToBottom(
            view:baseView,
            toView:self)
        NSLayoutConstraint.height(
            view:baseView,
            constant:kBaseHeight)
        layoutBaseLeft = NSLayoutConstraint.leftToLeft(
            view:baseView,
            toView:self)
        NSLayoutConstraint.width(
            view:baseView,
            constant:kBaseWidth)
        
        NSLayoutConstraint.topToTop(
            view:circle,
            toView:self,
            constant:kCircleTop)
        layoutCircleLeft = NSLayoutConstraint.leftToLeft(
            view:circle,
            toView:self)
        NSLayoutConstraint.size(
            view:circle,
            constant:kCircleSize)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:circle)
        
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
        
        NSLayoutConstraint.topToBottom(
            view:labelSubtitle,
            toView:labelTitle)
        NSLayoutConstraint.height(
            view:labelSubtitle,
            constant:kSubtitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelSubtitle,
            toView:baseView,
            margin:kSubtitleMargin)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewButtons,
            toView:baseView)
        NSLayoutConstraint.height(
            view:viewButtons,
            constant:kButtonsHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewButtons,
            toView:baseView)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainBase:CGFloat = width - kBaseWidth
        let baseLeft:CGFloat = remainBase / 2.0
        let remainCircle:CGFloat = width - kCircleSize
        let circleLeft:CGFloat = remainCircle / 2.0
        
        layoutBaseLeft.constant = baseLeft
        layoutCircleLeft.constant = circleLeft
        
        super.layoutSubviews()
    }
}
