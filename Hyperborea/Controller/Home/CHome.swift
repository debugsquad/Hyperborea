import UIKit

class CHome:CController
{
    private weak var viewHome:VHome!
    private let kEmpty:String = ""
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    //MARK: public
    
    func cancel()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        viewHome.viewInput.viewText.text = kEmpty
        textEmpty()
    }
    
    func textEmpty()
    {
        viewHome.viewInput.showPlaceholder()
        viewHome.viewHelper.textEmpty()
    }
    
    func textNotEmpty()
    {
        viewHome.viewInput.hidePlaceholder()
        viewHome.viewHelper.textNotEmpty()
    }
}
