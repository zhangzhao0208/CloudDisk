//
//  TransportListTableViewCell.m
//  CloudDisk
//
//  Created by suorui on 16/9/9.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "TransportListTableViewCell.h"
#define WIDTH self.frame.size.width
@implementation TransportListTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createCellContent];
    }
    
    
    return self;
}


-(void)setTotalModel:(TotalModel *)totalModel
{
    _totalModel = totalModel;
    
}
-(void)createCellContent
{
    _catalogImageView = [UIImageView new];
    [self addSubview:_catalogImageView];
    _catalogImageView.image = [UIImage imageNamed:@"off"];
    [_catalogImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(5);
        make.height.offset(50);
        make.width.mas_equalTo(_catalogImageView.mas_height);
        
    }];
    _catalogName = [UILabel new];
   
    _catalogName.text=@"省公司发文";
//    _catalogName.backgroundColor =[UIColor redColor];
    [AdjustFontSizeView adjustTextFontSize:WIDTH WithView:_catalogName];
    CGSize textSize =[ AdjustFontSizeView labelAdjustString:  _catalogName.text WithWidth:WIDTH-70-40 WithHeight:100 withFont:_catalogName.font];
    
    [self addSubview:_catalogName];
    
    [_catalogName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_catalogImageView.mas_right).offset(10);
        make.top.offset (10);
        make.height.offset(textSize.height);
        make.right.offset(-40);
        
    }];
    
    _catalogTime = [UILabel new];
    _catalogTime.text = @"2016-06-07 12:40";
//    _catalogTime.backgroundColor =[UIColor blueColor];
//    [AdjustFontSizeView adjustTextFontSize:WIDTH WithView:_catalogTime];
       _catalogTime.font = [UIFont systemFontOfSize:12];
    CGSize timeSize =[ AdjustFontSizeView labelAdjustString:  _catalogName.text WithWidth:WIDTH-70-40 WithHeight:100 withFont:_catalogTime.font];
 
    [self addSubview:_catalogTime];
    [_catalogTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_catalogName.mas_bottom);
        make.width.equalTo(_catalogName.mas_width);
        make.left.equalTo(_catalogImageView.mas_right).offset(10);
        //        make.bottom.offset(-5);
        make.height.offset(timeSize.height);
    }];
    
    _fileManagerButton = [[FileManagerButton alloc]init];
    
    [self addSubview:_fileManagerButton ];
    [_fileManagerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(_catalogImageView.mas_centerY);
              make.width.and.height.offset(30);
        
    }];
    
      //    [_catalogButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(-15);
//        make.centerY.equalTo(_catalogImageView.mas_centerY);
//        make.width.and.height.offset(20);
//    }];
    
}


-(void)clickCatalogButton:(UIButton*)sender
{
    
    _totalModel.selectedButton=!_totalModel.selectedButton;
    sender.selected = _totalModel.selectedButton;
    
    if ( sender.selected ==YES) {
        
        self.insertBlock(_totalModel.selectedRow);
    }else
    {
       
        self.closeCellBlock(_totalModel.selectedRow);
    }
    
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    [super setFrame:frame];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
