//
//  CircularArcViewController.m
//  shadow_ios_oc
//
//  Created by shadowplus Thank on 2023/8/13.
//

#import "CircularArcViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CircularArcViewController ()

@property (nonatomic, strong) CAShapeLayer *arcLayer;
@property (nonatomic, assign) CGFloat arcLength;

@end

@implementation CircularArcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置圆弧的初始长度
    self.arcLength = 0.5; // 0.5 表示半圆
    
    // 创建圆弧的路径
    CGPoint center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    CGFloat radius = 100;
    CGFloat startAngle = -M_PI_2; // 从垂直方向开始
    CGFloat endAngle = startAngle + 2 * M_PI * self.arcLength;
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius
                                                        startAngle:startAngle
                                                          endAngle:endAngle
                                                         clockwise:YES];
    
    // 创建 CAShapeLayer 并设置路径
    self.arcLayer = [CAShapeLayer layer];
    self.arcLayer.path = arcPath.CGPath;
    self.arcLayer.fillColor = [UIColor clearColor].CGColor;
    self.arcLayer.strokeColor = [UIColor blueColor].CGColor;
    self.arcLayer.lineWidth = 10;
    self.arcLayer.lineCap = kCALineCapRound; // 圆形线帽
    
    // 将 CAShapeLayer 添加到视图的 Layer 上
    [self.view.layer addSublayer:self.arcLayer];
    
    // 创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0); // 从 0 开始
    animation.toValue = @(1); // 完整圆弧
    animation.duration = 2.0; // 动画时长
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // 将动画添加到 CAShapeLayer
    [self.arcLayer addAnimation:animation forKey:@"arcAnimation"];
}

- (IBAction)updateArcLength:(UISlider *)sender {
    // 更新圆弧长度
    self.arcLength = sender.value;
    
    // 更新圆弧路径
    CGPoint center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    CGFloat radius = 100;
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = startAngle + 2 * M_PI * self.arcLength;
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius
                                                        startAngle:startAngle
                                                          endAngle:endAngle
                                                         clockwise:YES];
    self.arcLayer.path = arcPath.CGPath;
}
@end

