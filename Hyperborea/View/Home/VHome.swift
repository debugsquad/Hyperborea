import UIKit

class VHome:VView
{
    private weak var controller:CHome!
    private weak var input:VHomeInput!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        
        self.controller = controller as? CHome
        
        let input:VHomeInput = VHomeInput(controller:self.controller)
        self.input = input
        
        addSubview(input)
        
        input.initConstraints()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
