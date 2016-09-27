//
//  DownloadManagerSingletion.m
//  CloudDisk
//
//  Created by suorui on 16/9/20.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "DownloadManagerSingletion.h"

@implementation DownloadManagerSingletion

static DownloadManagerSingletion*downloadManager=nil;
+(DownloadManagerSingletion*)singletion
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!downloadManager) {
            downloadManager =[[DownloadManagerSingletion alloc]init];
        }
    });
    return downloadManager;
}

-(NSMutableArray*)inDownloadArray
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_inDownloadArray) {
            _inDownloadArray = [[NSMutableArray alloc]init];
            
        }

    });
        return _inDownloadArray;
}
-(NSMutableArray*)downloadOverArray
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_downloadOverArray) {
            _downloadOverArray = [[NSMutableArray alloc]init];
        }
        
    });
    return _downloadOverArray;
}
-(NSMutableDictionary*)downloaderManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_downloaderManager) {
            _downloaderManager = [[NSMutableDictionary alloc]init];
        }
        
    });
    return _downloaderManager;
}


@end
