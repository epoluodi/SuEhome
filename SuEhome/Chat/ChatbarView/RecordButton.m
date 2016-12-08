//
//  RecordButton.m
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "RecordButton.h"

@implementation RecordButton
@synthesize delegate;
-(instancetype)init
{
    self = [super init];
    self.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];
    self.layer.borderWidth=0.3;
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds =YES;
    self.userInteractionEnabled=YES;
    self.font = [UIFont systemFontOfSize:18];
    self.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"按住录音" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];


    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    [self setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.15]];
    NSLog(@"开始移动 %@",    NSStringFromCGPoint(point));
    [delegate BeginTap];
}

//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [super touchesMoved:touches withEvent:event];
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch  locationInView:self];
//     [self setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.15]];
//    NSLog(@"移动 %@",    NSStringFromCGPoint(point));
//    
//}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    [self setBackgroundColor:[UIColor whiteColor]];
    NSLog(@"完成移动 %@",    NSStringFromCGPoint(point));
    if (point.y<0  || point.y > self.frame.size.height || point.x <0 || point.x>self.frame.size.width)
        [delegate Finish:YES];
    else
        [delegate Finish:NO];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
