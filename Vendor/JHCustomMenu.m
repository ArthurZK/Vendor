//
//  SecondMenuView.m
//  LoveBB
//
//  Created by Arthur on 15/10/22.
//  Copyright © 2015年 Arthur. All rights reserved.
//

#import "JHCustomMenu.h"

#define TopToView 10.0f
#define CellLineEdgeInsets UIEdgeInsetsMake(0, 10, 0, 10)
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight        [UIScreen mainScreen].bounds.size.height
#define LeftToView kScreenWidth-10

@interface JHCustomMenu()
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, copy) NSString *key;
@end
@implementation JHCustomMenu

- (instancetype)initWithDataArr:(NSArray *)dataArr origin:(CGPoint)origin width:(CGFloat)width rowHeight:(CGFloat)rowHeight keyString:(NSString *)key
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        if (rowHeight <= 0) {
            rowHeight = 44;
        }
        self.backgroundColor = [UIColor colorWithRed:0.37 green:0.36 blue:0.36 alpha:0.5];
        self.origin = origin;
        self.key = key;
        self.rowHeight = rowHeight;
        self.width = width;
        self.arrData = [dataArr copy];
        
        CGFloat height = dataArr.count > 5 ? 5 * rowHeight *1.0 : rowHeight*dataArr.count;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x + LeftToView, origin.y + TopToView, width, height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        _tableView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithWhite:0.8 alpha:1];
        _tableView.layer.cornerRadius = 5;
        _tableView.bounces = NO;
        
//        _tableView.separatorColor = [UIColor colorWithWhite:0.8 alpha:1];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"JHCustomMenu"];
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [self.tableView setSeparatorInset:CellLineEdgeInsets];
            
        }
        
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [self.tableView setLayoutMargins:CellLineEdgeInsets];
            
        }

    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JHCustomMenu"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JHCustomMenu"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.textLabel.textColor = [UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:245.0/255.0 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    NSDictionary *dic = self.arrData [indexPath.row];
    cell.textLabel.text = dic[self.key];
 
    if (self.arrImgName.count > indexPath.row) {
        cell.imageView.image = [UIImage imageNamed:self.arrImgName[indexPath.row]];
//        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
//    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15, _rowHeight, _width - 30, 1)];
//    lineView.backgroundColor =  [UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:245.0/255.0 alpha:1];
//    if (indexPath.row ==_arrData.count-1) {
//        lineView.hidden = YES;
//    }
//    [cell.contentView addSubview:lineView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(jhCustomMenu:didSelectRowAtIndexPath:)]){
        [self.delegate jhCustomMenu:tableView didSelectRowAtIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissWithCompletion:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:CellLineEdgeInsets];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:CellLineEdgeInsets];
        
    }
    
}

- (void)dismissWithCompletion:(void (^)(JHCustomMenu *object))completion
{
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.alpha = 0;
        weakSelf.tableView.frame = CGRectMake(weakSelf.origin.x + LeftToView, weakSelf.origin.y + TopToView, 0, 0);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
        if (completion) {
            completion(weakSelf);
        }
        if (weakSelf.dismiss) {
            weakSelf.dismiss();
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.tableView]) {
        [self dismissWithCompletion:nil];
    }
}

//- (void)drawRect:(CGRect)rect
//
//{
////    [colors[serie] setFill];
//    
//    //拿到当前视图准备好的画板
//    
//    CGContextRef
//    context = UIGraphicsGetCurrentContext();
//    
//    //利用path进行绘制三角形
//    
//    CGContextBeginPath(context);//标记
//    
//    CGContextMoveToPoint(context,
//                         LeftToView * 2.5, TopToView * 0.5);//设置起点
//    
//    CGContextAddLineToPoint(context,
//                            LeftToView * 2, TopToView);
//    
//    CGContextAddLineToPoint(context,
//                            LeftToView * 3, TopToView);
//    
//    CGContextClosePath(context);//路径结束标志，不写默认封闭
//    
//    [[UIColor whiteColor]setFill]; //设置填充色
//    
//    [[UIColor whiteColor] setStroke]; //设置边框颜色
//    
//    CGContextDrawPath(context,
//                      kCGPathFillStroke);//绘制路径path
//}

@end
