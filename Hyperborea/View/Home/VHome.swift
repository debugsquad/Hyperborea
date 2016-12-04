import UIKit

class VHome:VView
{
    private weak var controller:CHome!
    private weak var viewInput:VHomeInput!
    private weak var viewHelper:VHomeHelper!
    private weak var layoutViewHelperBottom:NSLayoutConstraint!
    private weak var layoutInputTop:NSLayoutConstraint!
    private weak var layoutInputHeight:NSLayoutConstraint!
    private let kInputMaxHeight:CGFloat = 300
    private let kHelperHeight:CGFloat = 50
    private let kAnimationDuration:TimeInterval = 0.3
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CHome
        
        let viewInput:VHomeInput = VHomeInput(controller:self.controller)
        self.viewInput = viewInput
        
        let viewHelper:VHomeHelper = VHomeHelper(controller:self.controller)
        self.viewHelper = viewHelper
        
        addSubview(viewInput)
        addSubview(viewHelper)
        
        layoutInputTop = NSLayoutConstraint(
            item:viewInput,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        layoutInputHeight = NSLayoutConstraint(
            item:viewInput,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kInputMaxHeight)
        let layoutInputLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewInput,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutInputRight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewInput,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        layoutViewHelperBottom = NSLayoutConstraint(
            item:viewHelper,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutViewHelperHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewHelper,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kHelperHeight)
        let layoutViewHelperLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewHelper,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutViewHelperRight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewHelper,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        addConstraints([
            layoutInputTop,
            layoutInputHeight,
            layoutInputRight,
            layoutInputLeft,
            layoutViewHelperBottom,
            layoutViewHelperHeight,
            layoutViewHelperLeft,
            layoutViewHelperRight])
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedKeyboardChanged(sender:)),
            name:NSNotification.Name.UIKeyboardWillChangeFrame,
            object:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notifications
    
    func notifiedKeyboardChanged(sender notification:Notification)
    {
        guard
            
            let userInfo:[AnyHashable:Any] = notification.userInfo,
            let keyboardFrameValue:NSValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue
            
        else
        {
            return
        }
        
        let keyRect:CGRect = keyboardFrameValue.cgRectValue
        let yOrigin = keyRect.origin.y
        let height:CGFloat = bounds.maxY
        let keyboardHeight:CGFloat
        
        if yOrigin < height
        {
            keyboardHeight = height - yOrigin
        }
        else
        {
            keyboardHeight = 0
        }
        
        layoutViewHelperBottom.constant = -keyboardHeight
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
