import UIKit

class VSearchBarField:UITextField, UITextFieldDelegate
{
    private weak var controller:CSearch!
    private let kFontMaxSize:CGFloat = 30
    
    init(controller:CSearch)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        font = UIFont.regular(size:kFontMaxSize)
        textColor = UIColor.black
        tintColor = UIColor.black
        clearButtonMode = UITextFieldViewMode.always
        autocorrectionType = UITextAutocorrectionType.no
        autocapitalizationType = UITextAutocapitalizationType.sentences
        spellCheckingType = UITextSpellCheckingType.no
        borderStyle = UITextBorderStyle.none
        keyboardType = UIKeyboardType.alphabet
        keyboardAppearance = UIKeyboardAppearance.light
        returnKeyType = UIReturnKeyType.done
        placeholder = NSLocalizedString("VSearchBarField_placeholder", comment:"")
        delegate = self
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: textField delegate
    
    func textFieldDidBeginEditing(_ textField:UITextField)
    {
        controller.viewSearch.viewBar.beginEditing()
    }
    
    func textFieldDidEndEditing(_ textField:UITextField)
    {
        controller.viewSearch.viewBar.endEditing()
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}
