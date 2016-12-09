import UIKit

class CHomeLanguage:CController
{
    private weak var viewLanguage:VHomeLanguage!
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        viewLanguage.viewDidAppear()
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
        parentController.dismissAnimateOver()
    }
}
