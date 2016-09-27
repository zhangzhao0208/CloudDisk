//
//  PublicModel.h
//  CloudDisk
//
//  Created by suorui on 16/9/26.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PublicListModel;
@interface PublicModel : NSObject
@property(nonatomic,strong)NSMutableArray*resultList;
@property(nonatomic,strong)PublicListModel*publicListModel;
@property(nonatomic,copy)NSString*resultCode;
@end


@interface PublicListModel : NSObject <NSCoding>
@property(nonatomic,copy)NSString*createdate;
@property(nonatomic,copy)NSString*PublicDescription;
@property(nonatomic,copy)NSString*fileID;
@property(nonatomic,copy)NSString*islock;
@property(nonatomic,copy)NSString*name;
@property(nonatomic,copy)NSString*parentId;
@property(nonatomic,copy)NSString*password;
@property(nonatomic,copy)NSString*path;
@property(nonatomic,copy)NSString*size;
@property(nonatomic,copy)NSString*type;
@property(nonatomic,copy)NSString*userId;

@property(nonatomic,assign)BOOL selectedButton;
@property(nonatomic,assign)BOOL isFromToolCell;
@property(nonatomic,assign)NSInteger selectedRow;
//下载
@property(nonatomic,assign)NSInteger  fileButtonState;
@property (nonatomic,copy)NSString *length;
@property (nonatomic,copy)NSString *tname;
@property(nonatomic,assign)BOOL isEnterDownloadControl;

@end
