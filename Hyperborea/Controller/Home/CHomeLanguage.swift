import UIKit

class CHomeLanguage:CController
{
    private weak var viewLanguage:VHomeLanguage!
    
    override func loadView()
    {
        let viewLanguage:VHomeLanguage = VHomeLanguage(controller:self)
        self.viewLanguage = viewLanguage
        view = viewLanguage
    }
}
