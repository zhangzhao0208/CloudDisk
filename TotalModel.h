//
//  TotalModel.h
//  CloudDisk
//
//  Created by suorui on 16/9/7.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TotalModel : NSObject

@property(nonatomic,assign)BOOL selectedButton;
@property(nonatomic,assign)BOOL isFromToolCell;
@property(nonatomic,assign)NSInteger selectedRow;
//下载
@property (nonatomic,copy)NSString *length;
@property (nonatomic,copy)NSString *tname;
@end
