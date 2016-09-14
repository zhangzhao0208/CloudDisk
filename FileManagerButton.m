//
//  FileManagerButton.m
//  CloudDisk
//
//  Created by suorui on 16/9/13.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "FileManagerButton.h"
#define NOTI_CENTER [NSNotificationCenter defaultCenter]

#define FILE_M [NSFileManager defaultManager]
@implementation FileManagerButton

- (void)dealloc{
    [NOTI_CENTER removeObserver:self];
   
}

-(instancetype)init
{
    self =[super init];
    if (self) {
        
        [self addNotifcation];
        
    }
    
    return self;
    
}
- (void)addNotifcation
{
   
    
    self.backgroundColor =[UIColor redColor];
    _catalogButton =[FileManagerButton buttonWithType:UIButtonTypeCustom];
    _catalogButton.backgroundColor =[UIColor yellowColor];
    _catalogButton.clipsToBounds=YES;
    _catalogButton.layer.cornerRadius=5;
    _catalogButton.userInteractionEnabled=NO;
    [self addSubview:_catalogButton];
    [_catalogButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.offset(20);
        make.center.mas_equalTo(self.center);
        
    }];

    _progressView = [RoundProgress new];
    _progressView.userInteractionEnabled=NO;
    [self addSubview:_progressView];
    _progressView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    _progressView.arcBackColor= [UIColor grayColor];
    _progressView.arcFinishColor = [UIColor blueColor];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        
    }];

   
    [NOTI_CENTER addObserver:self selector:@selector(hasNewProgress:) name:@"newProgress" object:nil];
    
    [NOTI_CENTER addObserver:self selector:@selector(downloadFinish:) name:@"downloadFinish" object:nil];
    
}

- (void)downloadFinish:(NSNotification *)noti{
    
    NSLog(@"finishtag>>>>>>>%ld",(long)self.tag);
    if (self.fileDownloader == noti.object) {
        //如果是，就设置新进度
        self.downloadState = ButtonComplete;
    }
}

- (void)hasNewProgress:(NSNotification *)noti{
    //判断这个通知是否是属于自己的下载器发送的。
    if (self.fileDownloader == noti.object) {
        //如果是，就设置新进度
//        float progress = [[noti.userInfo objectForKey:@"progress"] floatValue];
        self.progress =[noti.userInfo objectForKey:@"progress"] ;
        
        
    }
}

- (void)setDownloadState:(ButtonState)downloadState{
    _downloadState = downloadState;
    switch (downloadState) {
        case ButtonNormal:
        {
         
            [self setTitle:@"下载" forState:UIControlStateNormal];
        }
            break;
        case ButtonDownloading:
        {
            [self setTitle:@"下载中" forState:UIControlStateNormal];
        }
            break;
        case ButtonPause:
        {
//            NSLog(@"--%@",self.file.tname);
//            NSLog(@"--%@",[FileDownloadManager tempPath]);
//            NSDictionary *attr = [FILE_M attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@",[FileDownloadManager tempPath],self.file.tname] error:nil];
//            unsigned long long tempSize = [attr fileSize];
//            self.progress = (double)tempSize/(double)[self.file.length longLongValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                _progressView.percent = 1.0*self.progress.completedUnitCount/self.progress.totalUnitCount;
                NSLog(@"--+++++-%f",_progressView.percent);
            });
            

            
            [self setTitle:@"继续下载" forState:UIControlStateNormal];
        }
            break;
        case ButtonComplete:
        {
        
            [self setTitle:@"查看" forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (void)setProgress:(NSProgress *)progress
{
_progress =progress;
//    NSLog(@"progress>>>>>>>>>%f",_progress);
//    progress.completedUnitCount/progress.totalUnitCounts;
//

//NSLog(@"==========%lld======%lld",_progress.completedUnitCount, _progress.totalUnitCount);

    dispatch_async(dispatch_get_main_queue(), ^{
        _progressView.percent = 1.0*self.progress.completedUnitCount/self.progress.totalUnitCount;
        NSLog(@"--+++++-%f",_progressView.percent);
    });



}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
