//
//  PublicCloudCatalogTableViewCell.m
//  CloudDisk
//
//  Created by suorui on 16/9/5.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "PublicCloudCatalogTableViewCell.h"

@implementation PublicCloudCatalogTableViewCell

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
    _catalogName = [YYLabel new];
    NSMutableAttributedString * attribteText =[[NSMutableAttributedString alloc]initWithString:@"省公司发文"];
    _catalogName.backgroundColor =[UIColor redColor];
    [AdjustFontSizeView adjustTextFontSize:self.frame.size.width WithAttributedString:attribteText];
    _catalogName.attributedText=attribteText;
    [self addSubview:_catalogName];
   
    [_catalogName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_catalogImageView.mas_right).offset(10);
        make.top.offset (5);
        make.height.offset(30);
        make.right.offset(-40);

    }];
    
    _catalogTime = [YYLabel new];
    _catalogTime.text = @"2016-06-07 12:40";
    _catalogTime.backgroundColor =[UIColor blueColor];
    _catalogTime.font = [UIFont systemFontOfSize:12];
    [self addSubview:_catalogTime];
    [_catalogTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_catalogName.mas_bottom);
        make.width.equalTo(_catalogName.mas_width);
        make.left.equalTo(_catalogImageView.mas_right).offset(10);
//        make.bottom.offset(-5);
        make.height.offset(20);
    }];
    
    _catalogButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_catalogButton];
    _catalogButton.backgroundColor =[UIColor yellowColor];
    [_catalogButton addTarget:self action:@selector(clickCatalogButton:) forControlEvents:UIControlEventTouchUpInside];
    [_catalogButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(_catalogImageView.mas_centerY);
        make.width.and.height.offset(20);
    }];
    
    
    
}


-(void)clickCatalogButton:(UIButton*)sender
{
    
    
    if ( _totalModel.selectedButton==NO) {
        _totalModel.selectedButton=YES;
        _totalModel.isFromToolCell=YES;
         self.insertBlock(_totalModel.selectedRow);
    }else
    {
        NSLog(@"cell按钮");
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
