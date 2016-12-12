import Foundation

class MSessionFlux
{
    enum Status:Int16
    {
        case full
        case twoLeft
        case oneLeft
        case empty
    }
    
    var current:MSessionFluxItem?
}
