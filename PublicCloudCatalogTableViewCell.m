//
//  PublicCloudCatalogTableViewCell.m
//  CloudDisk
//
//  Created by suorui on 16/9/5.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "PublicCloudCatalogTableViewCell.h"
#define WIDTH self.frame.size.width
#define REB(R,E,D,A) ([UIColor  colorWithRed:R/255.0 green:E/255.0 blue:D/255.0 alpha:A])
@implementation PublicCloudCatalogTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createCellContent];
    }
    
    
    return self;
}


-(void)setTotalModel:(PublicListModel *)totalModel
{
    _totalModel = totalModel;
    _catalogName.text=_totalModel.name;
//    NSLog(@"==%@",_totalModel.name);
//    _catalogName.text=@"sadasas";
    [AdjustFontSizeView adjustTextFontSize:WIDTH WithView:_catalogName];
    textSize =[ AdjustFontSizeView labelAdjustString:  _catalogName.text WithWidth:WIDTH-70-40 WithHeight:100 withFont:_catalogName.font];
    [_catalogName mas_updateConstraints:^(MASConstraintMaker *make) {
       make.height.offset(textSize.height);
        
    }];

    _catalogTime.text = _totalModel.createdate;
    timeSize =[ AdjustFontSizeView labelAdjustString:  _catalogName.text WithWidth:WIDTH-70-40 WithHeight:100 withFont:_catalogTime.font];
    [_catalogTime mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(timeSize.height);
  
    }];
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
//      _catalogName.backgroundColor =[UIColor redColor];
  
    [self addSubview:_catalogName];
    [_catalogName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_catalogImageView.mas_right).offset(10);
        make.top.offset (10);
        make.height.offset(textSize.height);
        make.right.offset(-40);
        
    }];
    _catalogTime = [UILabel new];
//       _catalogTime.backgroundColor =[UIColor blueColor];
    _catalogTime.font = [UIFont systemFontOfSize:12];
   
    [self addSubview:_catalogTime];
    [_catalogTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_catalogName.mas_bottom);
        make.width.equalTo(_catalogName.mas_width);
        make.left.equalTo(_catalogImageView.mas_right).offset(10);
        make.height.offset(timeSize.height);
    }];

    _catalogButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_catalogButton];
    _catalogButton.backgroundColor =[UIColor yellowColor];
    [_catalogButton setBackgroundImage:[UIImage imageNamed:@"menuarrow"] forState:UIControlStateNormal];
    [_catalogButton addTarget:self action:@selector(clickCatalogButton:) forControlEvents:UIControlEventTouchUpInside];
    [_catalogButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(_catalogImageView.mas_centerY);

        make.width.and.height.offset(20);
    }];
    
    UIView*lineView =[UIView new];
    lineView.backgroundColor=REB(200, 199, 204, 1);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(-1);
        make.height.offset(1);
    }];
  
}


-(void)clickCatalogButton:(UIButton*)sender
{
    
    _totalModel.selectedButton=!_totalModel.selectedButton;
    sender.selected = _totalModel.selectedButton;
    
    if ( sender.selected ==YES) {
       

      _catalogButton.transform = CGAffineTransformMakeRotation(M_PI);
         self.insertBlock(_totalModel.selectedRow);
    }else
    {
         _catalogButton.transform = CGAffineTransformMakeRotation(0);
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
