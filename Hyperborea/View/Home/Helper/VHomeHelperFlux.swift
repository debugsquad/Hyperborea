import UIKit

class VHomeHelperFlux:UIButton
{
    private weak var controller:CHome!
    private weak var image:UIImageView!
    private let kAlphaSelected:CGFloat = 0.3
    private let kAlphaNotSelected:CGFloat = 1
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let image:UIImageView = UIImageView()
        image.isUserInteractionEnabled = false
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.center
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = MSession.sharedInstance.flux?.image
        self.image = image
        
        addSubview(image)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint(
            item:image,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutImageBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:image,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:image,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutImageRight:NSLayoutConstraint = NSLayoutConstraint(
            item:image,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        addConstraints([
            layoutImageTop,
            layoutImageBottom,
            layoutImageLeft,
            layoutImageRight])
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(self.notifiedFluxUpdate(sender:)),
            name:Notification.fluxUpdate,
            object:nil)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: notifications
    
    func notifiedFluxUpdate(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in

            self?.fluxUpdate()
        }
    }
    
    //MARK: private
    
    private func fluxUpdate()
    {
        image.image = MSession.sharedInstance.flux?.image
    }
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
}
