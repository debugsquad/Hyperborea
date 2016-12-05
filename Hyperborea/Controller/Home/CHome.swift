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
    
    //MARK: private
    
    private func cancelRequests()
    {
        NotificationCenter.default.post(
            name:Notification.requestCancel,
            object:nil)
        
        UIApplication.shared.keyWindow!.endEditing(true)
    }
    
    //MARK: public
    
    func cancel()
    {
        cancelRequests()
        
        viewHome.viewInput.viewText.text = kEmpty
        textEmpty()
    }
    
    func search()
    {
        cancelRequests()

        let text:String = viewHome.viewInput.viewText.text
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
