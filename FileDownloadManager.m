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
#define DOWNSINGLETION [DownloadManagerSingletion singletion]

@implementation FileDownloadManager


-(void)dealloc
{
   
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //通过aCoder把对象的属性转化为二进制数据
    [aCoder encodeObject:self.file forKey:@"file"];
//    [aCoder encodeDataObject:self.recordData];
  
    
}

//数据解码
- (id)initWithCoder:(NSCoder *)aDecoder
{
    //
    self = [super init];
    if (self) {
        //取出数据，并赋值给这个对象的属性
      
//        self.recordData=[aDecoder decodeDataObject];
         self.file =[aDecoder decodeObjectForKey:@"file"];
    
    }
    return self;
}


- (id)initWithFile:(PublicListModel *)file{
    self = [super init];
    if (self) {
        _file = file;
       
    }
    
    return self;
}


-(void)setFile:(PublicListModel *)file
{
    _file = file;
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

-(void)startDownloadFile
{
    NSData *sizeData = [_file.size dataUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"---%@",_file.size);

    Byte *sizeByte = (Byte *)[sizeData bytes];
    
    for (int i =0; i<[sizeData length]; i++) {
        
         NSLog(@"---%ld",[sizeData length]);
             NSLog(@"=====%ld",sizeByte[i]);
    }
    
    
           NSLog(@"=====%s",sizeByte);
        NSString*sizeStr =[NSString stringWithFormat:@"%s",sizeByte];
        NSLog(@"=====%@ ",sizeStr);
        NSLog(@"=====%@ ",_file.fileID);
        NSLog(@"=====%@ ",_file.userId);
//    NSDictionary*dic = @{@"userId":_file.userId,@"fileId":_file.fileID,@"beginLength":@"0",@"endLength":sizeStr};

//     NSURL *downloadURL = [NSURL URLWithString:downloadFileURL];
//    NSMutableURLRequest*request =[NSMutableURLRequest requestWithURL:downloadURL];
      NSURL *downloadURL =[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];

    NSMutableURLRequest*request = [NSMutableURLRequest requestWithURL:downloadURL];
    
//     request.HTTPMethod = @"POST";
//    NSString*bodyStr =[NSString stringWithFormat:@"userId:%@,fileId:%@,beginLength:0,endLength:%@",_file.userId,_file.fileID,sizeStr];
//    request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionConfiguration*confi =[NSURLSessionConfiguration defaultSessionConfiguration];
    confi.timeoutIntervalForRequest=30;
    NSURLSession *session =[NSURLSession sessionWithConfiguration:confi delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
//    dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//      
//        if (data) {
//            
//            NSLog(@"data-------%@",data);
//            NSDictionary*dic =[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
//             NSLog(@"dic-------%@",dic);
//        
//        }
//        
//        if (response) {
//             NSLog(@"response-------%@",response);
//        }
//        
//        if (error) {
//            NSLog(@"erroe====%@",error);
//        }
//   }];
//
    
    _downLoadTask = [session downloadTaskWithRequest:request];
    self.recordData =[[NSMutableData alloc]init];
    
   
//     _downLoadTask =[session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//         
//         if (location) {
//             NSLog(@"====+++++%@",location);
//         }
//         if(response)
//         {
//               NSLog(@"====+++++%@",response);
//         }
//         
//     }];
    
    
    [_downLoadTask resume];
    
}

-(void)suspendDownload
{
    [_downLoadTask suspend];
    
    NSLog(@"====+++++%@",_recordData);
       NSLog(@"====+++++%@",_recordData);
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
     NSLog(@"====%@",data);
    [_recordData appendData:data];
      NSLog(@"====%@",_recordData);
}
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error) {
        
         NSLog(@"erroe====%@",error);
    }else
    {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.recordData options:kNilOptions error:nil];
                 NSLog(@"%@",dict);
    }
}



- (void)startDownload{
    
    
    //下载之前，先保证下载路径存在
    [self createPathIfNotExeists];
//    url =[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
//     url = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"];
    
    
     NSString*dataStr =[NSString stringWithFormat:@"%@/%@/%@",[FileDownloadManager tempPath],_file.name,_file.name];
    //默认配置
    NSData *sizeData = [_file.size dataUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"---%@",_file.size);
    Byte *sizeByte = (Byte *)[sizeData bytes];
     NSLog(@"---===++++%d",sizeByte);
    for (int i =0; i<[sizeData length]; i++) {
        
        NSLog(@"---%ld",[sizeData length]);
        NSLog(@"=====%ld",sizeByte[i]);
    }
    

//    NSLog(@"=====%s",sizeByte);
    NSString*sizeStr =[NSString stringWithFormat:@"%s",sizeByte];
    NSLog(@"=====%@ ",sizeStr);
//    NSLog(@"=====%@ ",_file.fileID);
//    NSLog(@"=====%@ ",_file.userId);

   
    NSURL *downloadURL = [NSURL URLWithString:downloadFileURL];
    NSMutableURLRequest*request =[NSMutableURLRequest requestWithURL:downloadURL];
    request.HTTPMethod = @"POST";
        NSString*bodyStr =[NSString stringWithFormat:@"userId:%@,fileId:%@,beginLength:0,endLength:%@",_file.userId,_file.fileID,sizeStr];
        request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
        //请求

    configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
           //下载Task操作
    NSLog(@"===%@",_file);
    
    if(![FILE_M fileExistsAtPath:[[FileDownloadManager tempPath] stringByAppendingPathComponent:_file.name]]&&![FILE_M fileExistsAtPath:[[FileDownloadManager downloadPath] stringByAppendingPathComponent:_file.name]]){
    _downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"----%f",1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
            [NOTI_CENTER postNotificationName:@"newProgress" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:downloadProgress,@"progress", nil]];
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {

        NSString *cachesPath =[FileDownloadManager downloadPath] ;
        NSString *path = [cachesPath stringByAppendingPathComponent:_file.name];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
     
        if (filePath) {
            NSLog(@"---下载地址%@",filePath);
            [DOWNSINGLETION.inDownloadArray removeObject:_file];
            [DOWNSINGLETION.downloadOverArray addObject:_file];
            [FILE_M removeItemAtPath:[[FileDownloadManager tempPath] stringByAppendingPathComponent:_file.name] error:nil];
            
            
            if ( DOWNSINGLETION.currentViewIsDownloadView==YES) {
                [self.fileDownloadManagerDelegate removeInDownloadCell:_file];
            }

        }
        
       
        
    }];
    
       [_downLoadTask resume];
        [self isTempPathExist];
        
    }else
    {
        if ([FILE_M fileExistsAtPath:[[FileDownloadManager downloadPath] stringByAppendingPathComponent:_file.name]]) {
           
            return;
        }
        
        NSData *data =[NSData dataWithContentsOfFile:dataStr];
        _downLoadTask=[manager downloadTaskWithResumeData:data progress:^(NSProgress * _Nonnull downloadProgress) {
            
            
             NSLog(@"----%f",1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
           
               [NOTI_CENTER postNotificationName:@"newProgress" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:downloadProgress,@"progress", nil]];
            
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            NSString *cachesPath =[FileDownloadManager downloadPath] ;
            NSString *path = [cachesPath stringByAppendingPathComponent:_file.name];
            return [NSURL fileURLWithPath:path];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
     
            if (filePath) {
                NSLog(@"---下载地址%@",filePath);
             
                    [DOWNSINGLETION.inDownloadArray removeObject:_file];
                    
                    [DOWNSINGLETION.downloadOverArray addObject:_file];
                    [FILE_M removeItemAtPath:[[FileDownloadManager tempPath] stringByAppendingPathComponent:_file.name] error:nil];
                
                if ( DOWNSINGLETION.currentViewIsDownloadView==YES) {
                    [self.fileDownloadManagerDelegate removeInDownloadCell:_file];
                }
                
            }
                
            
        }];
         [_downLoadTask resume];
    }
 
}

-(void)startBackgroundDown
{
   
      [self createPathIfNotExeists];
    
       url =[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
//         url = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"];
     NSString*dataStr =[NSString stringWithFormat:@"%@/%@/%@",[FileDownloadManager tempPath],_file.name,_file.name];
    //默认配置
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:_file.tname];
//    NSLog(@"--%@",configuration.identifier);
    
    if ([configuration.identifier isEqualToString:_file.name]) {
        manager = [[AFURLSessionManager alloc] init];
    }else
    {
        manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
//    manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //下载Task操作
    
    if(![FILE_M fileExistsAtPath:dataStr]){
        NSLog(@"----后台从头下载");

        _downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            
             NSLog(@"----%f",1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
            
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            NSString *cachesPath =[FileDownloadManager downloadPath] ;
            NSString *path = [cachesPath stringByAppendingPathComponent:_file.name];

            return [NSURL fileURLWithPath:path];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//            NSLog(@"--%@",filePath);
            if (filePath) {
                NSLog(@"---下载地址%@",filePath);
                
                [DOWNSINGLETION.inDownloadArray removeObject:_file];
                [DOWNSINGLETION.downloadOverArray addObject:_file];
                [FILE_M removeItemAtPath:[[FileDownloadManager tempPath] stringByAppendingPathComponent:_file.name] error:nil];
            }
            

            
        }];
        
        [_downLoadTask resume];
        
    }else
    {
        NSData *data =[NSData dataWithContentsOfFile:dataStr];
        _downLoadTask=[manager downloadTaskWithResumeData:data progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"----%f",1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
           
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            NSString *cachesPath =[FileDownloadManager downloadPath] ;
            //            NSLog(@"====----%@",cachesPath);
            NSString *path = [cachesPath stringByAppendingPathComponent:_file.name];
            
            return [NSURL fileURLWithPath:path];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            NSLog(@"====----后台下载完成");
            if (filePath) {
                NSLog(@"---下载地址%@",filePath);
                
                [DOWNSINGLETION.inDownloadArray removeObject:_file];
                [DOWNSINGLETION.downloadOverArray addObject:_file];
                [FILE_M removeItemAtPath:[[FileDownloadManager tempPath] stringByAppendingPathComponent:_file.name] error:nil];
            }
            

            
        }];
        [_downLoadTask resume];
    }
    
      

}

-(void)cancelBackgroundDownload
{
    
        [_downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            _recordData =resumeData;
            NSString*dataStr =[NSString stringWithFormat:@"%@/%@/%@",[FileDownloadManager tempPath],_file.name,_file.name];
            NSLog(@"++++++====%@",dataStr);
            [_recordData writeToFile:dataStr atomically:YES];
            _downLoadTask=nil;
            manager=nil;

            }];
//    _downLoadTask=nil;


    NSLog(@"++++++===");
   
}

- (void)cancelDownload{
    
    
       NSLog(@"++++++====%@",_file);
    NSLog(@"---%@",_downLoadTask);
        [_downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            _recordData =resumeData;
            NSString*dataStr =[NSString stringWithFormat:@"%@/%@/%@",[FileDownloadManager tempPath],_file.name,_file.name];
            NSLog(@"++++++====%@",dataStr);
            [_recordData writeToFile:dataStr atomically:YES];
            _downLoadTask=nil;
            manager=nil;
            
        }];
  
  
   
    
    
}
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    AppDelegate *appdelgate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (appdelgate.backgroundSessionCompletionHandler) {
        void (^completionHandle)() = appdelgate.backgroundSessionCompletionHandler;
        appdelgate.backgroundSessionCompletionHandler = nil;
        completionHandle();
    }
    
    NSLog(@"All tasks are finished");
    
}

- (BOOL)isDownloading{
    
//    NSLog(@"===%@",_downLoadTask);
    if (_downLoadTask) {
        return YES;
    }else{
        return NO;
    }
}

- (void)checkNet{
    //开启网络状态监控
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status==AFNetworkReachabilityStatusReachableViaWiFi){
            NSLog(@"当前是wifi");
        }
        if(status==AFNetworkReachabilityStatusReachableViaWWAN){
            NSLog(@"当前是3G");
        }
        if(status==AFNetworkReachabilityStatusNotReachable){
            NSLog(@"当前是没有网络");
        }
        if(status==AFNetworkReachabilityStatusUnknown){
            NSLog(@"当前是未知网络");
        }
    }];
}
+ (NSString *)downloadPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/FileDown"];
}

+ (NSString *)tempPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/FileTemp"];
    
    
}
-(void)isTempPathExist
{
    if (![FILE_M fileExistsAtPath:[[FileDownloadManager tempPath] stringByAppendingPathComponent:_file.name]]) {
        [FILE_M createDirectoryAtPath:[[FileDownloadManager tempPath] stringByAppendingPathComponent:_file.name] withIntermediateDirectories:YES attributes:nil error:nil];
    }

}
+ (BOOL)isDownloadFinish:(PublicListModel *)file{
    if ([FILE_M fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",[self downloadPath],file.name]]) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isFileDownloading:(PublicListModel *)file{
    
  
//    
//    if ( [FILE_M fileExistsAtPath:[[FileDownloadManager tempPath] stringByAppendingPathComponent:file.tname]]) {
//        return YES;
//    }
//    else{
//        return NO;
//    }
    if ([FILE_M fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",[self tempPath],file.name]]) {
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
