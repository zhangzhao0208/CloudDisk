//
//  TransportListTableViewCell.h
//  CloudDisk
//
//  Created by suorui on 16/9/9.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "SRConst.h"
#import "YYText.h"
#import "AdjustFontSizeView.h"
#import "TotalModel.h"
#import <UAProgressView/UAProgressView.h>
#import "FileManagerButton.h"
typedef void(^InsertCellBlock)(NSInteger);

@interface TransportListTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *catalogName;
@property(nonatomic,strong)UILabel *catalogTime;
@property(nonatomic,strong)UIImageView *catalogImageView;
@property(nonatomic,strong)FileManagerButton *fileManagerButton;
@property(nonatomic,strong)UIButton *lastCatalogButton;
@property(nonatomic,copy)InsertCellBlock insertBlock;
@property(nonatomic,copy)InsertCellBlock closeCellBlock;
@property(nonatomic,assign)NSInteger insertIndex;
@property(nonatomic,strong)TotalModel*totalModel;
@property(nonatomic,assign)NSInteger selectedRow;
@property(nonatomic,strong)UAProgressView*progressView;

@end
