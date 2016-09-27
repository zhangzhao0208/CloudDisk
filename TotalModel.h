//
//  TotalModel.h
//  CloudDisk
//
//  Created by suorui on 16/9/7.
//  Copyright © 2016年 suorui. All rights reserved.
//


#import <Foundation/Foundation.h>
@class TotalModel;


@interface TotalModel : NSObject<NSCoding>

@property(nonatomic,assign)BOOL selectedButton;
@property(nonatomic,assign)BOOL isFromToolCell;
@property(nonatomic,assign)NSInteger selectedRow;
//下载
@property(nonatomic,assign)NSInteger  fileButtonState;
@property (nonatomic,copy)NSString *length;
@property (nonatomic,copy)NSString *tname;
@property(nonatomic,assign)BOOL isEnterDownloadControl;

@end
