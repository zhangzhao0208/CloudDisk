//
//  FileDownloadManager.m
//  CloudDisk
//
//  Created by suorui on 16/9/13.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "FileDownloadManager.h"
#define USER_D [NSUserDefaults standardUserDefaults]

#define NOTI_CENTER [NSNotificationCenter defaultCenter]

#define FILE_M [NSFileManager defaultManager]


@implementation FileDownloadManager

- (id)initWithFile:(TotalModel *)file{
    self = [super init];
    if (self) {
        _file = file;
    }
    
    return self;
}



- (void)createPathIfNotExeists{
    //创建下载文件夹
    if (![FILE_M fileExistsAtPath:[FileDownloadManager downloadPath]]) {
        [FILE_M createDirectoryAtPath:[FileDownloadManager downloadPath] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //创建临时文件夹
    if (![FILE_M fileExistsAtPath:[FileDownloadManager tempPath]]) {
        [FILE_M createDirectoryAtPath:[FileDownloadManager tempPath] withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (void)startDownload{
    //下载之前，先保证下载路径存在
    [self createPathIfNotExeists];
    url =[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
//     NSURL *URL = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"];
    
//    NSString*fileTempPath =[FileDownloadManager tempPath];
//    if (![FILE_M fileExistsAtPath:fileTempPath]) {
//        [FILE_M createDirectoryAtPath:fileTempPath withIntermediateDirectories:YES attributes:nil error:nil];
//        
//    }
    
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
      manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //下载Task操作
    _downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
    [NOTI_CENTER postNotificationName:@"newProgress" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:downloadProgress,@"progress", nil]];

    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *cachesPath =[FileDownloadManager downloadPath] ;
        NSLog(@"====----%@",cachesPath);
        NSString *path = [cachesPath stringByAppendingPathComponent:_file.tname];
        NSLog(@"====----%@",path);
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];
    
       [_downLoadTask resume];
 

    
}

-(void)continueDown
{
    
    if(!_recordData){
        
       NSURLRequest* request=[NSURLRequest requestWithURL:url];
        _downLoadTask=[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
             [NOTI_CENTER postNotificationName:@"newProgress" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:downloadProgress,@"progress", nil]];
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            NSString *cachesPath =[FileDownloadManager downloadPath] ;
            NSLog(@"====----%@",cachesPath);
            NSString *path = [cachesPath stringByAppendingPathComponent:_file.tname];
            NSLog(@"====----%@",path);
            return [NSURL fileURLWithPath:path];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
        }];
    }else{
        _downLoadTask=[manager downloadTaskWithResumeData:_recordData progress:^(NSProgress * _Nonnull downloadProgress) {
             [NOTI_CENTER postNotificationName:@"newProgress" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:downloadProgress,@"progress", nil]];
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            NSString *cachesPath =[FileDownloadManager downloadPath] ;
            NSLog(@"====----%@",cachesPath);
            NSString *path = [cachesPath stringByAppendingPathComponent:_file.tname];
            NSLog(@"====----%@",path);
            return [NSURL fileURLWithPath:path];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
        }];
    }
    [_downLoadTask resume];
    //继续下载
   
}

- (void)cancelDownload{
    
    [_downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        _recordData =resumeData;
        
        
        
        NSLog(@"====%@",resumeData);
    }];
    NSString*dataStr =[[FileDownloadManager tempPath] stringByAppendingPathComponent:_file.tname];
    
//    [_recordData writeToFile:dataStr atomically:YES];
       [_downLoadTask suspend];
    
}

- (BOOL)isDownloading{
    if (_downLoadTask) {
        return YES;
    }else{
        return NO;
    }
}


+ (NSString *)downloadPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/FileDown"];
}

+ (NSString *)tempPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/FileTemp"];
    
    
}

+ (BOOL)isDownloadFinish:(TotalModel *)file{
    if ([FILE_M fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",[self downloadPath],file.tname]]) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isFileDownloading:(TotalModel *)file{
    
      
    if ([FILE_M fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",[self tempPath],file.tname]]) {
        return YES;
    }else{
        return NO;
    }
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
