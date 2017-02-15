import UIKit

class CHomeLanguage:CController
{
    private weak var viewLanguage:VHomeLanguage!
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        viewLanguage.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        
        viewLanguage.viewWillDisappear()
    }
    
    override func loadView()
    {
        let viewLanguage:VHomeLanguage = VHomeLanguage(controller:self)
        self.viewLanguage = viewLanguage
        view = viewLanguage
    }
    
    //MARK: public
    
    func dismiss()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func selectLanguage(model:MSessionLanguage)
    {
        MSession.sharedInstance.changeLanguage(language:model)
        dismiss()
        
        AMain.sharedInstance?.trackLanguage(name:model.name)
    }
}
