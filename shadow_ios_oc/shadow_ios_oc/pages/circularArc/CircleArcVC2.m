//
//  CircleArcVC2.m
//  shadow_ios_oc
//
//  Created by shadowplus Thank on 2023/8/13.
//

#import "CircleArcVC2.h"
#import <QuartzCore/QuartzCore.h>

@interface CircleArcVC2 ()

@property (nonatomic, strong) CAShapeLayer *circleArcLayer;

@end

@implementation CircleArcVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat radius = 100.0;
    CGPoint center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    
    // 创建 CAShapeLayer 并设置其路径和样式
    self.circleArcLayer = [CAShapeLayer layer];
    self.circleArcLayer.strokeColor = [UIColor.blueColor CGColor]; // 圆弧的颜色
    self.circleArcLayer.fillColor = nil;
    self.circleArcLayer.lineWidth = 10.0; // 圆弧的线宽
    self.circleArcLayer.lineCap = kCALineCapRound; // 圆弧两端的样式
    
    // 创建圆弧的路径，以便设置CAShapeLayer的path属性
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    self.circleArcLayer.path = circlePath.CGPath;
    
    // 将CAShapeLayer添加到视图的Layer中
    [self.view.layer addSublayer:self.circleArcLayer];
    
    // 创建圆弧自转动画
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.fromValue = @(0); // 从0度开始旋转
    rotationAnimation.toValue = @(2 * M_PI); // 旋转一周
    rotationAnimation.duration = 3.0; // 动画时长
    rotationAnimation.repeatCount = HUGE_VALF; // 使动画无限循环
    [self.circleArcLayer addAnimation:rotationAnimation forKey:@"circleRotationAnimation"];
    
    // 移动CAShapeLayer的位置到视图中心，以实现在原地自转
    self.circleArcLayer.position = center;
    
    // 创建圆弧移动动画
    CABasicAnimation *arcAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    arcAnimation.fromValue = @(0); // 从圆弧的起点开始
    arcAnimation.toValue = @(1);   // 移动到圆弧的终点
    arcAnimation.duration = 3.0;   // 动画时长
    arcAnimation.repeatCount = HUGE_VALF; // 使动画无限循环
    [self.circleArcLayer addAnimation:arcAnimation forKey:@"circleArcAnimation"];


    // 设置圆弧起点随着终点移动的动画
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @(-0.6); // 圆弧起点从0开始
    startAnimation.toValue = @(1);   // 圆弧起点移动到1
    startAnimation.duration = 3.0;   // 动画时长
    startAnimation.repeatCount = HUGE_VALF; // 使动画无限循环
    [self.circleArcLayer addAnimation:startAnimation forKey:@"circleStartAnimation"];
}

@end

