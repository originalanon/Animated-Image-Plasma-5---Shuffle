import QtQuick 2.11
import org.kde.plasma.core 2.0 as PlasmaCore
import QtGraphicalEffects 1.0
import QtQuick.Window 2.0 // for Screen
import Qt.labs.folderlistmodel 2.11


Item {
    id: root

    width: Screen.width
    height: Screen.height

    property bool folderShuffleEnabled: wallpaper.configuration.ShuffleEnabled && wallpaper.configuration.Folder !== ""
    property url shuffleFolder: folderShuffleEnabled ? wallpaper.configuration.Folder : ""
    property string shuffledSource: ""

    function selectNextImage() {
        if (!folderShuffleEnabled || imageFolder.status !== FolderListModel.Ready || imageFolder.count === 0) {
            shuffledSource = "";
            return;
        }

        var currentIndex = -1;
        for (var index = 0; index < imageFolder.count; index++) {
            if (imageFolder.get(index, "fileUrl").toString() === shuffledSource) {
                currentIndex = index;
                break;
            }
        }

        var candidateCount = imageFolder.count - (currentIndex >= 0 ? 1 : 0);
        var nextIndex = candidateCount > 0 ? Math.floor(Math.random() * candidateCount) : 0;
        if (currentIndex >= 0 && candidateCount > 0 && nextIndex >= currentIndex) {
            nextIndex++;
        }
        shuffledSource = imageFolder.get(nextIndex, "fileUrl").toString();
    }

    onShuffleFolderChanged: {
        shuffledSource = "";
        folderRefreshTimer.restart();
    }

    FolderListModel {
        id: imageFolder
        folder: root.shuffleFolder
        showDirs: false
        showDotAndDotDot: false
        showOnlyReadable: true
        nameFilters: ["*.gif", "*.webp", "*.png", "*.jpg", "*.jpeg", "*.bmp", "*.svg",
                      "*.GIF", "*.WEBP", "*.PNG", "*.JPG", "*.JPEG", "*.BMP", "*.SVG"]
        onStatusChanged: folderRefreshTimer.restart()
        onCountChanged: folderRefreshTimer.restart()
    }

    Timer {
        id: folderRefreshTimer
        interval: 100
        onTriggered: {
            shuffleTimer.stop();
            root.selectNextImage();
            if (root.folderShuffleEnabled && imageFolder.status === FolderListModel.Ready && imageFolder.count > 1) {
                shuffleTimer.start();
            }
        }
    }

    Timer {
        id: shuffleTimer
        interval: Math.max(1, wallpaper.configuration.ShuffleInterval) * 1000
        repeat: true
        onTriggered: root.selectNextImage()
    }
    
    WindowModel {
        id:windowModel
    }
    
    Timer {
        id:timeOffsetUpdateTimer
        interval:600000
        repeat:true
        running:true
        onTriggered: {
            backgroundComponent.timeoffestForDayNight =  (Date.now()+(backgroundComponent.dayNightOffset*1000)+(new Date()).getTimezoneOffset())%86400000/86400000;
        }
    }
    
    
    BackgoundComponent {
        id:backgroundComponent
        source: root.folderShuffleEnabled && root.shuffledSource !== "" ? root.shuffledSource : wallpaper.configuration.Image
        _animation.playing: _animation.status == AnimatedImage.Ready && (!wallpaper.configuration.StopAnimOnHide || !windowModel.currentWindowMaximized) 
//         source: wallpaper.configuration.Image
//         blurEnabled: wallpaper.configuration.Blur
//         bkColor: wallpaper.configuration.Color
//         blurRadius: wallpaper.configuration.BlurRadius
//         cacheImageAnyway: wallpaper.configuration.CacheImageAnyway
    }
}
