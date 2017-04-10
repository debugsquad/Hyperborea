import UIKit

class VFroobPlus:VView
{
    private weak var controller:CFroobPlus!
    private weak var blurContainer:UIView!
    private weak var layoutContentTop:NSLayoutConstraint!
    private let kAnimationDuration:TimeInterval = 0.3
    private let kContentHeight:CGFloat = 300
    private let kContentTop:CGFloat = 150
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CFroobPlus
        
        let blur:VBlur = VBlur.dark()
        
        let blurContainer:UIView = UIView()
        blurContainer.isUserInteractionEnabled = false
        blurContainer.clipsToBounds = true
        blurContainer.translatesAutoresizingMaskIntoConstraints = false
        blurContainer.alpha = 0
        self.blurContainer = blurContainer
        
        let baseButton:UIButton = UIButton()
        baseButton.clipsToBounds = true
        baseButton.backgroundColor = UIColor.clear
        baseButton.translatesAutoresizingMaskIntoConstraints = false
        baseButton.addTarget(
            self,
            action:#selector(self.actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewContent:VDrawProjectStoreContent = VDrawProjectStoreContent(
            controller:controller,
            purchase:purchase)
        
        let contentTop:CGFloat = controller.viewProject.bounds.maxY
        
        blurContainer.addSubview(blur)
        addSubview(blurContainer)
        addSubview(baseButton)
        addSubview(viewContent)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:blurContainer)
        NSLayoutConstraint.equals(
            view:blurContainer,
            toView:self)
        NSLayoutConstraint.equals(
            view:baseButton,
            toView:self)
        
        layoutContentTop = NSLayoutConstraint.topToTop(
            view:viewContent,
            toView:self,
            constant:contentTop)
        NSLayoutConstraint.height(
            view:viewContent,
            constant:kContentHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewContent,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        animateClose()
    }
    
    //MARK: public
    
    func animateClose()
    {
        layoutContentTop.constant = bounds.maxY
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
            { [weak self] in
                
                self?.alpha = 0
                self?.layoutIfNeeded()
            })
        { [weak self] (done:Bool) in
            
            self?.removeFromSuperview()
        }
    }
    
    func animateShow()
    {
        layoutContentTop.constant = kContentTop
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.blurContainer.alpha = 0.99
            self?.layoutIfNeeded()
        }
    }
}
