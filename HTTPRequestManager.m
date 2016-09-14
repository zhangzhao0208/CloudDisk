//
//  HTTPRequestManager.m
//  CloudDisk
//
//  Created by suorui on 16/9/13.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "HTTPRequestManager.h"

@implementation HTTPRequestManager

-(void)HTTPRequestDownloadWithTask:(NSURLSessionDownloadTask *)downLoadTask WithCompletation:(DownLoadButtonBlock)downLoadblock
{
    //    NSURL *URL = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"];
    
    
    
    NSURL*URL =[NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSString * CachePath =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    NSFileManager *  fileManager =[NSFileManager defaultManager];
    NSLog(@"%@",CachePath);
    NSString * folderPath = [CachePath stringByAppendingPathComponent:@"mv"];
    NSString * tempPath =[ NSTemporaryDirectory() stringByAppendingPathComponent:@"mvTemp"];
    //判断缓存文件夹和视频存放文件夹是否存在,如果不存在,就创建一个文件夹
    if (![fileManager fileExistsAtPath:folderPath])
    {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //
    if (![fileManager fileExistsAtPath:tempPath])
    {
        [fileManager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString * tempFilePath = [tempPath stringByAppendingPathComponent:@"mv.temp"];//缓存路径
    NSString * mvFilePath = [folderPath stringByAppendingPathComponent:@"mv.mp4"];//文件保存路径
    NSString * txtFilePath = [tempPath stringByAppendingPathComponent:@"mv.txt"];//保存重启程序下载的进度
    
    unsigned long long  downloadedBytes =0;
    if ([fileManager fileExistsAtPath:tempFilePath])//如果存在,说明有缓存文件
    {
        downloadedBytes = [self fileSizeAtPath:tempFilePath];//计算缓存文件的大小
        NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
        NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
        
        [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
        request = mutableURLRequest;
        NSLog(@"==============断点下载");
    }
    
    if (![fileManager  fileExistsAtPath:mvFilePath]) {
        //AFN3.0+基于封住URLSession的句柄
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        
        //下载Task操作
        
       
        
        _downLoadTask  =  [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            
            // @property int64_t totalUnitCount;     需要下载文件的总大小
            // @property int64_t completedUnitCount; 当前已经下载的大小
            [manager setDownloadTaskDidResumeBlock:^(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, int64_t fileOffset, int64_t expectedTotalBytes) {
                NSString * progress = [NSString stringWithFormat:@"%.3f",((float)fileOffset / expectedTotalBytes)];
                [progress writeToFile:txtFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                
            }];
            // 给Progress添加监听 KVO
            NSLog(@"++++++++%lld======%lld",downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            // 回到主队列刷新UI
            //      newProgress.progress = downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
            NSLog(@"--======%@",[ NSTemporaryDirectory() stringByAppendingPathComponent:@"mvTemp"]);
            
            
            [self.HTTPManagerDelegate changeProgressViewProgress:downloadProgress];
            //        dispatch_async(dispatch_get_main_queue(), ^{
            //            // 设置进度条的百分比
            //            newProgress.percent = downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
            //
            //        });
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
            
            NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) [0];
            
            NSLog(@"====----%@",cachesPath);
            NSString *path = [cachesPath stringByAppendingPathComponent:@"111"];
            NSLog(@"====----%@",cachesPath);
            
            
            
            return [NSURL fileURLWithPath:path];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            //设置下载完成操作
            // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
            if (error) {
                NSLog(@"---%@",error);
                downLoadblock(nil,error);
                return ;
            }
            //        NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
            //        UIImage *img = [UIImage imageWithContentsOfFile:imgFilePath];
            //        self.imageView.image = img;
            downLoadblock(filePath,nil);
            
        }];
        
        [_downLoadTask resume];
        
        self.downBlock(_downLoadTask);
        
    }else
    {
        [_downLoadTask suspend];
    }
}
+ (NSString *)tempPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

- (unsigned long long)fileSizeAtPath:(NSString *)fileAbsolutePath {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new];
    if ([fileManager fileExistsAtPath:fileAbsolutePath]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:fileAbsolutePath error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

@end
