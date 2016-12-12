import UIKit

class VHome:VView
{
    weak var viewInput:VHomeInput!
    weak var viewHelper:VHomeHelper!
    weak var viewSuggestions:VHomeSuggestions!
    weak var viewWords:VHomeWords!
    var scrollable:Bool
    private weak var controller:CHome!
    private weak var layoutViewHelperBottom:NSLayoutConstraint!
    private weak var layoutInputTop:NSLayoutConstraint!
    private weak var layoutInputHeight:NSLayoutConstraint!
    private let kAnimationDuration:TimeInterval = 3
    private let kInputMinHeight:CGFloat = 81
    private let kHelperHeight:CGFloat = 50
    private let kSuggestionsHeight:CGFloat = 46
    private let kScrollMaxMove:CGFloat = -21
    
    override init(controller:CController)
    {
        scrollable = true
        
        super.init(controller:controller)
        self.controller = controller as? CHome
        
        let viewInput:VHomeInput = VHomeInput(controller:self.controller)
        self.viewInput = viewInput
        
        let viewHelper:VHomeHelper = VHomeHelper(controller:self.controller)
        self.viewHelper = viewHelper
        
        let viewSuggestions:VHomeSuggestions = VHomeSuggestions(controller:self.controller)
        self.viewSuggestions = viewSuggestions
        
        let viewWords:VHomeWords = VHomeWords(controller:self.controller)
        self.viewWords = viewWords
        
        addSubview(viewWords)
        addSubview(viewInput)
        addSubview(viewHelper)
        addSubview(viewSuggestions)
        
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
            constant:viewInput.kMaxHeight)
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
        
        let layoutViewSuggestionsHeight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewSuggestions,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kSuggestionsHeight)
        let layoutViewSuggestionsBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:viewSuggestions,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:viewHelper,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutViewSuggestionsLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewSuggestions,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutViewSuggestionsRight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewSuggestions,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        let layoutViewWordsTop:NSLayoutConstraint = NSLayoutConstraint(
            item:viewWords,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutViewWordsBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:viewWords,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutViewWordsLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:viewWords,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutViewWordsRight:NSLayoutConstraint = NSLayoutConstraint(
            item:viewWords,
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
            layoutViewHelperRight,
            layoutViewSuggestionsHeight,
            layoutViewSuggestionsBottom,
            layoutViewSuggestionsLeft,
            layoutViewSuggestionsRight,
            layoutViewWordsTop,
            layoutViewWordsBottom,
            layoutViewWordsLeft,
            layoutViewWordsRight])
        
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
            viewHelper.viewCancel.activate()
        }
        else
        {
            keyboardHeight = 0
            viewHelper.viewCancel.deactivate()
        }
        
        layoutViewHelperBottom.constant = -keyboardHeight
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    //MARK: public
    
    func scrollDidScroll(offsetY:CGFloat)
    {
        if scrollable
        {
            controller.parentController.viewParent.scrollDidScroll(
                offsetY:offsetY)
            
            if offsetY > kScrollMaxMove
            {
                layoutInputTop.constant = offsetY
                layoutInputHeight.constant = viewInput.kMaxHeight
            }
            else
            {
                layoutInputTop.constant = kScrollMaxMove
                
                let deltaHeight:CGFloat = abs(offsetY) - abs(kScrollMaxMove)
                let newInputHeight:CGFloat = viewInput.kMaxHeight - deltaHeight
                
                if newInputHeight > kInputMinHeight
                {
                    layoutInputHeight.constant = newInputHeight
                }
                else
                {
                    layoutInputHeight.constant = kInputMinHeight
                }
            }
        }
    }
    
    func restartScroll()
    {
        layoutInputTop.constant = 0
        layoutInputHeight.constant = viewInput.kMaxHeight
        controller.parentController.viewParent.restartScroll()
    }
}
