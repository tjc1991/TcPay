//
//  TcHistoryCellTableViewCell.m
//  StockPay
//
//  Created by tjc1991 on 16/4/9.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcHistoryCellTableViewCell.h"

@implementation TcHistoryCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化
        self.backgroundColor = [UIColor clearColor];
        [self _initView];
    }
    return self;
    
}

//初始化视图

-(void)_initView{
    
    //初始化时间标签
    self.timeLb = [[UILabel alloc]initWithFrame:CGRectZero];
    self.timeLb.textColor = UIColorFromRGB(0x13eaa4);
    self.timeLb.font = [UIFont systemFontOfSize:20.0f];
    self.timeLb.backgroundColor = [UIColor clearColor];
    self.timeLb.textAlignment = NSTextAlignmentCenter;
    self.timeLb.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.timeLb];
    
    //初始化内容标签
    self.contentLb = [[UILabel alloc]initWithFrame:CGRectZero];
    self.contentLb.font = [UIFont systemFontOfSize:18.0f];
    self.contentLb.backgroundColor = [UIColor clearColor];
    self.contentLb.textColor = [UIColor blackColor];
    [self.contentLb setNumberOfLines:0];
    self.contentLb.lineBreakMode = NSLineBreakByWordWrapping;//换行方式
    //self.contentLb.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.contentLb];
    
}

//设置视图高度

-(void)layoutSubviews{
    [super layoutSubviews];
    self.timeLb.frame = CGRectMake(3,10,ScreenWidth-3, 20);
    self.timeLb.text = self.model.createtime;
    
    self.contentLb.frame = CGRectMake(15, self.timeLb.bottom+5, ScreenWidth-30, 30);
    self.contentLb.text = self.model.content;
    CGSize size = CGSizeMake(self.contentLb.width,1000);//LableWight标签宽度，固定的
    //计算实际frame大小，并将label的frame变成实际大小
    
    CGSize labelsize = [self.contentLb.text sizeWithFont:self.contentLb.font constrainedToSize:size lineBreakMode:self.contentLb.lineBreakMode];
    [self.contentLb setFrame:CGRectMake(15, self.timeLb.bottom+5, labelsize.width, labelsize.height)];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

//计算评论单元格的高度
+(float)getHistoryHeight:(TcHistoryModel*)historymodel
{
    UILabel *rtlabel = [[UILabel alloc]initWithFrame:CGRectZero];
    rtlabel.font = [UIFont systemFontOfSize:18.0f];
    rtlabel.width = ScreenWidth-30;
    rtlabel.text = historymodel.content;
    CGSize size = CGSizeMake(rtlabel.width,2000);//LableWight标签宽度，固定的
    //计算实际frame大小，并将label的frame变成实际大小
    
    CGSize labelsize = [rtlabel.text sizeWithFont:rtlabel.font constrainedToSize:size lineBreakMode:rtlabel.lineBreakMode];
    float h = labelsize.height;
    return h;
}


@end
