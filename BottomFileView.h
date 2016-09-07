//
//  BottomFileView.h
//  CloudDisk
//
//  Created by suorui on 16/9/5.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "SRConst.h"
#import "YYText.h"
#import "YYImage.h"
#import "AdjustFontSizeView.h"

typedef void(^UpLoadBlock)(NSString*);
typedef void(^DownLoadBlock)(NSString*);
typedef void(^DeleteLoadBlock)(NSString*);
typedef void(^MoreOperationBlock)(NSString*);
@protocol BottomFileViewDelegate <NSObject>

-(void)changeMoreOperationViewPosition;
-(void)removeMoreOperationView;
@end
@interface BottomFileView : UIView
@property(nonatomic,copy)UpLoadBlock upLoadBlock;
@property(nonatomic,copy)DownLoadBlock downLoadBlock;
@property(nonatomic,copy)DeleteLoadBlock deleteLoadBlock;
@property(nonatomic,copy)MoreOperationBlock moreOperationBlock;
@property(nonatomic,assign)id<BottomFileViewDelegate>BottomFileDelegate;
-(instancetype)initWithFrame:(CGRect)frame;

@end
