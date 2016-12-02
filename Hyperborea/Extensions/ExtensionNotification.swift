import Foundation

extension Notification
{
    static let sessionLoaded:Notification.Name = Notification.Name("sessionLoaded")
    static let userBanned:Notification.Name = Notification.Name("userBanned")
    static let settingsLoaded:Notification.Name = Notification.Name("settingsLoaded")
    static let photosLoaded:Notification.Name = Notification.Name("photosLoaded")
    static let imageDataLoaded:Notification.Name = Notification.Name("imageDataLoaded")
    static let thumbnailReady:Notification.Name = Notification.Name("thumbnailReady")
    static let userPhotoLoaded:Notification.Name = Notification.Name("userPhotoLoaded")
    static let albumRefreshed:Notification.Name = Notification.Name("albumRefreshed")
}
