import UIKit

class VHomeInputText:UITextView, UITextViewDelegate
{
    private weak var controller:CHome!
    let kMaxHeight:CGFloat = 46
    private let kInsetsHorizontal:CGFloat = 5
    private let kMaxFontSize:CGFloat = 32
    
    convenience init(controller:CHome)
    {
        self.init()
        
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        textColor = UIColor.black
        tintColor = UIColor.black
        bounces = false
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        returnKeyType = UIReturnKeyType.default
        keyboardAppearance = UIKeyboardAppearance.light
        autocorrectionType = UITextAutocorrectionType.no
        spellCheckingType = UITextSpellCheckingType.no
        autocapitalizationType = UITextAutocapitalizationType.words
        contentInset = UIEdgeInsets.zero
        textContainerInset = UIEdgeInsets(
            top:0,
            left:kInsetsHorizontal,
            bottom:0,
            right:kInsetsHorizontal)
        delegate = self
        self.controller = controller
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let percent:CGFloat = height / kMaxHeight
        let fontSize:CGFloat = percent * kMaxFontSize
        font = UIFont.medium(size:fontSize)
        
        super.layoutSubviews()
    }
    
    //MARK: textView delegate
    
    func textViewDidBeginEditing(_ textView:UITextView)
    {
        controller.viewHome.scrollable = false
        
        if textView.bounds.maxY < kMaxHeight
        {
            controller.viewHome.restartScroll()
        }
    }
    
    func textViewDidEndEditing(_ textView:UITextView)
    {
        controller.viewHome.scrollable = true
    }
    
    func textView(_ textView:UITextView, shouldChangeTextIn range:NSRange, replacementText text:String) -> Bool
    {
        let currentText:NSString = textView.text as NSString
        let editedText:String = currentText.replacingCharacters(
            in:range,
            with:text)
        controller.changedText(text:editedText)
        
        return true
    }
}
