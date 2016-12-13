import Foundation

extension Notification
{
    static let sessionLoaded:Notification.Name = Notification.Name("sessionLoaded")
    static let requestCancel:Notification.Name = Notification.Name("requestCancel")
    static let languageChanged:Notification.Name = Notification.Name("languageChanged")
    static let fluxUpdate:Notification.Name = Notification.Name("fluxUpdate")
}
