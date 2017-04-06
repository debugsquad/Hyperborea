import UIKit

class VRecent:VView
{
    private weak var controller:CRecent!
    private weak var blurContainer:UIView!
    private let kAnimationDuration:TimeInterval = 0.3
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CRecent
        
        let blurContainer:UIView = UIView()
        blurContainer.isUserInteractionEnabled = false
        blurContainer.translatesAutoresizingMaskIntoConstraints = false
        blurContainer.clipsToBounds = true
        blurContainer.alpha = 0
        self.blurContainer = blurContainer
        
        let blur:VBlur = VBlur.dark()
        
        blurContainer.addSubview(blur)
        addSubview(blurContainer)
        
        NSLayoutConstraint.equals(
            view:blurContainer,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:blurContainer)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func animateShow()
    {
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.blurContainer.alpha = 1
        })
        { (done:Bool) in
            
        }
    }
}
