import UIKit

class VHomeInputText:UITextView, UITextViewDelegate
{
    private weak var controller:CHome!
    private let kInsetsLeft:CGFloat = 15
    
    convenience init(controller:CHome)
    {
        self.init()
        
        font = UIFont.regular(size:25)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        textColor = UIColor.black
        tintColor = UIColor.black
        returnKeyType = UIReturnKeyType.default
        keyboardAppearance = UIKeyboardAppearance.light
        autocorrectionType = UITextAutocorrectionType.no
        spellCheckingType = UITextSpellCheckingType.no
        autocapitalizationType = UITextAutocapitalizationType.words
        contentInset = UIEdgeInsets.zero
        textContainerInset = UIEdgeInsets(
            top:0,
            left:kInsetsLeft,
            bottom:0,
            right:-kInsetsLeft)
        delegate = self
        self.controller = controller
    }
    
    //MARK: textView delegate
    
    func textView(_ textView:UITextView, shouldChangeTextIn range:NSRange, replacementText text:String) -> Bool
    {
        
    }
}
