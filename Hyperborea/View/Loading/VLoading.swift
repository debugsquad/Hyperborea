import UIKit

class VLoading:VView
{
    private weak var controller:CLoading!
    private let kSpinnerHeight:CGFloat = 150
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        self.controller = controller as? CLoading
        
        let logo:UIImageView = UIImageView()
        logo.isUserInteractionEnabled = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.clipsToBounds = true
        logo.contentMode = UIViewContentMode.center
        logo.image = #imageLiteral(resourceName: "assetGenericLogo")
        
        let spinner:VSpinner = VSpinner()
        
        addSubview(logo)
        addSubview(spinner)
        
        let layoutLogoTop:NSLayoutConstraint = NSLayoutConstraint(
            item:logo,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutLogoBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:logo,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutLogoRight:NSLayoutConstraint = NSLayoutConstraint(
            item:logo,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        let layoutLogoLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:logo,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        let layoutSpinnerHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:spinner,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kSpinnerHeight)
        let layoutSpinnerBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:spinner,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutSpinnerLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:spinner,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutSpinnerRight:NSLayoutConstraint = NSLayoutConstraint(
            item:spinner,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        addConstraints([
            layoutSpinnerHeight,
            layoutSpinnerBottom,
            layoutSpinnerLeft,
            layoutSpinnerRight,
            layoutLogoTop,
            layoutLogoBottom,
            layoutLogoRight,
            layoutLogoLeft])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
