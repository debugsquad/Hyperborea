import UIKit

class CHome:CController, RMainDelegate
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
    
    func search(text:String)
    {
        NotificationCenter.default.post(
            name:Notification.requestCancel,
            object:nil)
        
        let settings:RSettingsHomeSearch = RSettingsHomeSearch(text:text)
        RMain.request(settings:settings, delegate:self)
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
    
    //MARK: rMain delegate
    
    func requestFinished(model:RModel?, status:RMain.StatusCode?, error:String?)
    {
        
    }
}
