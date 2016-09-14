//
//  HTTPRequestManager.h
//  CloudDisk
//
//  Created by suorui on 16/9/13.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class ViewController;

@protocol HTTPRequestManagerDelegate <NSObject>

-(void)changeProgressViewProgress:(NSProgress*)customProgress;

@end
typedef void (^UpLoadButtonBlock)(NSDictionary*,NSError*);
typedef void (^DownLoadButtonBlock)(NSURL*,NSError*);
typedef void (^ProgressBlock)(NSProgress * );
typedef void (^DownBlock)(NSURLSessionDownloadTask * );
@interface HTTPRequestManager : NSObject

{
    //    NSURLSessionDownloadTask*downLoadTask;
    
}
@property(nonatomic,assign)id<HTTPRequestManagerDelegate>HTTPManagerDelegate;
@property(nonatomic,strong)NSURLSessionDownloadTask*downLoadTask;
@property(nonatomic,copy)ProgressBlock progressBlock;
@property(nonatomic,copy)DownBlock downBlock;


-(void)HTTPRequestDownloadWithTask:(NSURLSessionDownloadTask *)downLoadTask  WithCompletation:(DownLoadButtonBlock )downLoadblock;

-(void)HTTPRequestUploadWithTaskWithProgress:(UIProgressView*)newProgress WithCompletation:(DownLoadButtonBlock )downLoadblock;
@end
