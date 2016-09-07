//
//  PublicCloudCatalogTableViewCell.h
//  CloudDisk
//
//  Created by suorui on 16/9/5.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "SRConst.h"
#import "YYText.h"
#import "AdjustFontSizeView.h"
#import "TotalModel.h"

typedef void(^InsertCellBlock)(NSInteger);
@interface PublicCloudCatalogTableViewCell : UITableViewCell

@property(nonatomic,strong)YYLabel *catalogName;
@property(nonatomic,strong)YYLabel *catalogTime;
@property(nonatomic,strong)UIImageView *catalogImageView;
@property(nonatomic,strong)UIButton *catalogButton;
@property(nonatomic,copy)InsertCellBlock insertBlock;
@property(nonatomic,assign)NSInteger insertIndex;
@property(nonatomic,strong)TotalModel*totalModel;
@end
