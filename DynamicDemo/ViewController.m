//
//  ViewController.m
//  DynamicDemo
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 Liancheng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.greenView.transform = CGAffineTransformMakeRotation(M_PI_4);
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self gravityBehavior];
    [self gravityAndCollsion];
//    [self gravityAndCollisionAttribute];
//    [self gravityAndCollisionUseCircleAndLine];
}

#pragma mark - gravity
- (void)gravityBehavior{
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]init];
    [gravity addItem:self.greenView];
    [self.animator addBehavior:gravity];
    
}

#pragma mark - 重力行为+碰撞检测
- (void)gravityAndCollsion{
   //1.重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]init];
    [gravity addItem:self.greenView];

    
    //2.碰撞检测行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]init];
    [collision addItem:self.greenView];
    [collision addItem:self.progressView];
    [collision addItem:self.segmentedView];
    
    //让参照视图的边框成为碰撞检测的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    //3.执行仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

#pragma mark - 测试重力行为的属性
- (void)gravityAndCollisionAttribute{
    //1.重力行为
    UIGravityBehavior * gravity = [[UIGravityBehavior alloc]init];
    //重力方向是一个角度
    gravity.angle = (M_PI_2 -M_PI_4);
    //重力加速度，越大，碰撞就越明显
    gravity.magnitude = 100;
    //重力方向 是一个二维向量
//    gravity.gravityDirection = CGVectorMake(0, 1);
    [gravity addItem:self.greenView];
    
    //2.碰撞检测行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]init];
    [collision addItem:self.greenView];
    //加了这个就出现异常
//    [collision addItem:self.progressView];
    [collision addItem:self.segmentedView];
    
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    [self.animator addBehavior:gravity];
}

#pragma mark - 用圆作、线为边界
- (void)gravityAndCollisionUseCircleAndLine{
    UIGravityBehavior * gravity = [[UIGravityBehavior alloc]init];
//    gravity.magnitude = 50;
    [gravity addItem:self.greenView];
    
    UICollisionBehavior * collision = [[UICollisionBehavior alloc]init];
    [collision addItem:self.greenView];
    
//    //添加一个椭圆为碰撞边界
//    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 320, 320)];
//    [collision addBoundaryWithIdentifier:@"circel" forPath:path];
    
    //添加线
    CGPoint startPoint = CGPointMake(0, 260);
    CGPoint endPoint = CGPointMake(320, 500);
    [collision addBoundaryWithIdentifier:@"line1" fromPoint:startPoint toPoint:endPoint];
    
    
    
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

#pragma mark - 创建物理仿真器
- (UIDynamicAnimator *)animator{
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}

- (UIView *)greenView{
    if (_greenView == nil) {
        _greenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _greenView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_greenView];
    }
    return _greenView;
}

- (UIView *)progressView{
    if (_progressView == nil) {
        _progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 200, 50)];
        _progressView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

- (UIView *)segmentedView{
    if (_segmentedView == nil) {
        _segmentedView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, 200, 40)];
        _segmentedView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_segmentedView];
    }
    return _segmentedView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
