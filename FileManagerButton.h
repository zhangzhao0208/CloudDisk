//
//  FileManagerButton.h
//  CloudDisk
//
//  Created by suorui on 16/9/13.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileDownloadManager.h"
#import "TotalModel.h"
#import <UAProgressView/UAProgressView.h>
#import "Masonry.h"
#import "RoundProgress.h"
@class FileDownloadManager;
typedef enum : NSUInteger {
    sunday = 0,
    monday ,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
} weekday;

typedef NS_ENUM(NSInteger, ButtonState){
    ButtonNormal,
    ButtonDownloading,
    ButtonPause,
    ButtonComplete,
};



@interface FileManagerButton : UIButton{
    
}

@property (nonatomic,assign)ButtonState downloadState;

@property (nonatomic,assign)NSProgress *progress;

@property (nonatomic,strong)TotalModel *file;
@property (nonatomic,strong)FileDownloadManager *fileDownloader;
@property(nonatomic,strong)FileManagerButton *catalogButton;
@property(nonatomic,strong)RoundProgress*progressView;




@end
