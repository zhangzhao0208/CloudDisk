//
//  FileManagerButton.m
//  CloudDisk
//
//  Created by suorui on 16/9/13.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "FileManagerButton.h"
#define NOTI_CENTER [NSNotificationCenter defaultCenter]
#define USER_D [NSUserDefaults standardUserDefaults]
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

-(void)setAddProgress:(int)addProgress
{
    _catalogButton =[FileManagerButton buttonWithType:UIButtonTypeCustom];
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

}
- (void)addNotifcation
{
   
  
   
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
    
    NSLog(@"--%@",noti.object);
    NSLog(@"--%@",self.fileDownloader);
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

            if ([FILE_M fileExistsAtPath:[NSString stringWithFormat:@"%@/%@/%@",[FileDownloadManager tempPath],self.file.name,self.file.name]]) {
                NSDictionary *attr = [FILE_M attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@/%@",[FileDownloadManager tempPath],self.file.name,self.file.name] error:nil];
                unsigned long long tempSize = [attr fileSize];
                NSString*str =[NSString stringWithFormat:@"5211"];
                NSLog(@"--------++%lld",tempSize);
                NSLog(@"+++++++%lld",[str longLongValue]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                _progressView.percent = 1.0*(double)tempSize/(double)[self.file.length longLongValue];
                    _progressView.percent = 1.0*(double)tempSize/(double)[str longLongValue];
                    
                });

            }else
            {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    _progressView.percent = 1.0*self.progress.completedUnitCount/self.progress.totalUnitCount;
//             
//                });

            }
            
           
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

    dispatch_async(dispatch_get_main_queue(), ^{
        _progressView.percent = 1.0*self.progress.completedUnitCount/self.progress.totalUnitCount;
//        NSLog(@"--+++++-%lld",self.progress.completedUnitCount);
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
