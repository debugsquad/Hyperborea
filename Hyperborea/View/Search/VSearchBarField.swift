import UIKit

class VSearchBarField:UITextField, UITextFieldDelegate
{
    private weak var controller:CSearch!
    
    init(controller:CSearch)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.regular(size:30)
        textColor = UIColor.black
        tintColor = UIColor.black
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
