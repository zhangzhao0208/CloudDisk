//
//  ToolTableViewCell.h
//  CloudDisk
//
//  Created by suorui on 16/9/7.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "SRConst.h"
#import "YYText.h"
#import "YYImage.h"
#import "AdjustFontSizeView.h"
#import "TotalModel.h"
#import "DownloadManagerSingletion.h"
#import "FileDownloadManager.h"
#import "PublicModel.h"
typedef void(^FileManagerCell)(PublicModel*);

@interface ToolTableViewCell : UITableViewCell
@property(nonatomic,strong)PublicListModel*totalModel;
@property(nonatomic,copy)FileManagerCell downloadFileButton;
@property(nonatomic,copy)FileManagerCell openFileButton;
@end
