//
//  DownloadManagerSingletion.h
//  CloudDisk
//
//  Created by suorui on 16/9/20.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadManagerSingletion : NSObject


+(DownloadManagerSingletion*)singletion;
@property(nonatomic ,strong)NSMutableDictionary*downloaderManager;
@property(nonatomic ,strong)NSMutableArray*inDownloadArray;
@property(nonatomic ,strong)NSMutableArray*downloadOverArray;
@property(nonatomic,assign)BOOL currentViewIsDownloadView;


@end
