import UIKit

class VRecent:VView
{
    private weak var controller:CRecent!
    private weak var blurContainer:UIView!
    private weak var layoutBaseBottom:NSLayoutConstraint!
    private let kBaseHeight:CGFloat = 320
    private let kBarHeight:CGFloat = 50
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
        
        let buttonClose:UIButton = UIButton()
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        buttonClose.clipsToBounds = true
        buttonClose.backgroundColor = UIColor.clear
        buttonClose.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let blur:VBlur = VBlur.dark()
        
        let baseView:UIView = UIView()
        baseView.backgroundColor = UIColor.white
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        
        blurContainer.addSubview(blur)
        addSubview(blurContainer)
        addSubview(buttonClose)
        addSubview(baseView)
        
        NSLayoutConstraint.equals(
            view:blurContainer,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:blurContainer)
        
        NSLayoutConstraint.equals(
            view:buttonClose,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:baseView,
            toView:self,
            constant:kBaseHeight)
        NSLayoutConstraint.height(
            view:baseView,
            constant:kBaseHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:baseView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        animateHide()
    }
    
    //MARK: private
    
    private func animateHide()
    {
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.alpha = 0
        })
        { [weak self] (done:Bool) in
            
            self?.controller.back()
        }
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
