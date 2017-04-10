import UIKit

class VFroobPlus:VView
{
    private(set) weak var viewContent:VFroobPlusContent!
    private weak var controller:CFroobPlus!
    private weak var blurContainer:UIView!
    private weak var layoutContentBottom:NSLayoutConstraint!
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
        
        let viewContent:VFroobPlusContent = VFroobPlusContent(
            controller:self.controller)
        self.viewContent = viewContent
        
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
        
        layoutContentBottom = NSLayoutConstraint.topToBottom(
            view:viewContent,
            toView:self)
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
        controller.back()
    }
    
    //MARK: public
    
    func animateShow()
    {
        let height:CGFloat = bounds.maxY
        let contentTop:CGFloat = kContentTop - height
        
        layoutContentBottom.constant = contentTop
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.blurContainer.alpha = 0.99
            self?.layoutIfNeeded()
        }
    }
}
