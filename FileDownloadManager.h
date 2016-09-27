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
#import "AppDelegate.h"
#import "PublicModel.h"
#import "SRConst.h"
@protocol FileDownloadManagerDelegate <NSObject>

-(void)removeInDownloadCell:(PublicListModel*)totalModel;
-(void)updateCatalogTable;
@end

@interface FileDownloadManager : NSObject<NSCoding,UIApplicationDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate,NSURLSessionDelegate>

{
    AFURLSessionManager *manager;
    NSURL*url;
    NSURLSessionConfiguration *configuration;
    NSURLSessionDownloadTask*_downLoadTask;
    AFHTTPSessionManager *AFmanager ;
    

}
//@property (nonatomic,retain,readonly)TotalModel *file;

@property (nonatomic,strong)PublicListModel *file;
//@property(nonatomic,strong)NSURLSessionDownloadTask*downLoadTask;
@property(nonatomic,strong)NSMutableData*recordData;
@property(nonatomic,assign)id<FileDownloadManagerDelegate>fileDownloadManagerDelegate;
//初始化方法，把需要下载的文件对象传进来
- (id)initWithFile:(PublicListModel *)file;

//开始下载
- (void)startDownload;
//开始后台下载
-(void)startBackgroundDown;
//取消下载
- (void)cancelDownload;
//取消后台下载
-(void)cancelBackgroundDownload;

//是否正在下载
- (BOOL)isDownloading;
- (void)checkNet;

+ (NSString *)downloadPath;
+ (NSString *)tempPath;
//判断一个文件是否下载完毕
+ (BOOL)isDownloadFinish:(PublicListModel *)file;

//判断一个文件是否下了一部分
+ (BOOL)isFileDownloading:(PublicListModel *)file;

//自定义下载
-(void)startDownloadFile;
-(void)suspendDownload;



@end
