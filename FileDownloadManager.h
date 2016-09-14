//
//  FileDownloadManager.h
//  CloudDisk
//
//  Created by suorui on 16/9/13.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TotalModel.h"
#import "FileManagerButton.h"
#import "AFNetworking.h"
@interface FileDownloadManager : NSObject

{
    AFURLSessionManager *manager;
    NSURL*url;
}

@property (nonatomic,retain,readonly)TotalModel *file;
@property(nonatomic,strong)NSURLSessionDownloadTask*downLoadTask;
@property(nonatomic,assign)NSData*recordData;
//初始化方法，把需要下载的文件对象传进来
- (id)initWithFile:(TotalModel *)file;

//开始下载
- (void)startDownload;

//取消下载
- (void)cancelDownload;
//继续下载
-(void)continueDown;
//是否正在下载
- (BOOL)isDownloading;


+ (NSString *)downloadPath;
+ (NSString *)tempPath;
//判断一个文件是否下载完毕
+ (BOOL)isDownloadFinish:(TotalModel *)file;

//判断一个文件是否下了一部分
+ (BOOL)isFileDownloading:(TotalModel *)file;
@end
