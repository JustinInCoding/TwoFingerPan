//
//  ViewController.m
//  TwoFingerScroll
//
//  Created by Justin on 2019/12/4.
//  Copyright © 2019 Justin. All rights reserved.
//

#import "ViewController.h"

#import "ABCLeftViewController.h"
#import "ABCCenterViewController.h"
#import "ABCRightViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *centerView;

@property (nonatomic, assign) CGPoint centerViewCenter;
@property (nonatomic, assign) CGSize leftViewSize;
@property (nonatomic, assign) CGSize rightViewSize;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /* add pan gesture */
    UIPanGestureRecognizer *twoFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    twoFingerPanRecognizer.minimumNumberOfTouches = 2;
    twoFingerPanRecognizer.maximumNumberOfTouches = 2;
    [self.view addGestureRecognizer:twoFingerPanRecognizer];
    
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.centerView];
    [self.view addSubview:self.rightView];
    [self.view bringSubviewToFront:self.centerView];
    
//    NSLog(@"right view center x = %.f, y = %.f", self.rightView.center.x, self.rightView.center.y);
    
    
}

- (void)pan:(UIPanGestureRecognizer *)pan {
//    NSLog(@"two finger touched screen");
    
    CGPoint speed = [pan velocityInView:self.view];
//    NSLog(@"speedX = %.f, sppdY = %.f", speed.x, speed.y);
    
    CGPoint transition = [pan translationInView:self.view];
//    NSLog(@"tranzitionX = %.f", transition.x);
    
    if (CGRectGetMinX(self.centerView.frame) <= 0.0f
        && transition.x < -self.view.bounds.size.width / 3.0f) {
        transition.x = -self.view.bounds.size.width / 3.0f;
        [pan setTranslation:transition inView:self.view];
    }

    if (CGRectGetMaxX(self.centerView.frame) >= self.view.bounds.size.width
        && transition.x > 0) {
        transition.x = 0;
        [pan setTranslation:transition inView:self.view];
    }
    transition = [pan translationInView:self.view];
    
    self.centerView.center = CGPointMake(self.centerViewCenter.x + transition.x,
                                         self.centerViewCenter.y);
    
    /* left view */
    CGSize leftViewOriginSize = self.leftViewSize;
//    CGFloat scale = (leftViewOriginSize.width + transition.x) / leftViewOriginSize.width;
    CGFloat widthHeightScale = leftViewOriginSize.width / leftViewOriginSize.height;
    CGSize leftViewSize = CGSizeMake(leftViewOriginSize.width + transition.x,
                                     (leftViewOriginSize.width + transition.x) / widthHeightScale);
    CGPoint center = self.leftView.center;
    self.leftView.frame = CGRectMake(0.0f,
                                     0.0f,
                                     leftViewSize.width,
                                     leftViewSize.height);
    self.leftView.center = center;
//    if (leftViewSize.width <= 0) {
//        self.leftView.hidden = YES;
//    } else {
//        self.leftView.hidden = NO;
//    }
    
    
    /* right view */
    CGSize rightViewOriginSize = self.rightViewSize;
    CGSize rightViewSize = CGSizeMake(rightViewOriginSize.width - transition.x,
                                      (rightViewOriginSize.width - transition.x) / widthHeightScale);
    CGPoint rightViewCenter = self.rightView.center;
    self.rightView.frame = CGRectMake(0.0f,
                                      0.0f,
                                      rightViewSize.width,
                                      rightViewSize.height);
    self.rightView.center = rightViewCenter;
    
    // pan left
    if (speed.x < 0) {
        
//        NSLog(@"finger scroll to left");
    
//        if (CGRectGetMinX(self.centerView.frame) > 0.0f) {
//            self.centerView.center = CGPointMake(self.centerViewCenter.x + transition.x, self.centerViewCenter.y);
//        } else {
//            self.centerViewCenter = self.centerView.center;
//        }
        
        
        
        
    } else if (speed.x > 0) { // pan right
        
//        NSLog(@"finger scroll to right");
        
        
//        if (CGRectGetMaxX(self.centerView.frame) < self.view.bounds.size.width) {
//            self.centerView.center = CGPointMake(self.centerViewCenter.x + transition.x, self.centerViewCenter.y);
//        } else {
//            self.centerViewCenter = self.centerView.center;
//        }
        
        
    }
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - view
- (UIView *)leftView {
    if (!_leftView) {
        /* add left view controller */
        ABCLeftViewController *leftVC = [[ABCLeftViewController alloc] init];
        [self addChildViewController:leftVC];
        UIView *leftView = leftVC.view;
        leftView.frame = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width / 3.0f, self.view.bounds.size.height);
        _leftViewSize = leftView.frame.size;
        _leftView = leftView;
    }
    return _leftView;
}

- (UIView *)centerView {
    if (!_centerView) {
        /* add middle view controller */
        ABCCenterViewController *centerVC = [[ABCCenterViewController alloc] init];
        [self addChildViewController:centerVC];
        UIView *centerView = centerVC.view;
        centerView.frame = CGRectMake(self.view.bounds.size.width / 3.0f, 0.0f, self.view.bounds.size.width / 3.0f * 2.0f, self.view.bounds.size.height);
        _centerViewCenter = centerView.center;
        _centerView = centerView;
    }
    return _centerView;
}

- (UIView *)rightView {
    if (!_rightView) {
        /* add right view controller */
        ABCRightViewController *rightVC = [[ABCRightViewController alloc] init];
        [self addChildViewController:rightVC];
        UIView *rightView = rightVC.view;
        rightView.frame = CGRectZero;
        rightView.center = CGPointMake(self.view.bounds.size.width / 6.0f * 5.f,
                                       self.view.bounds.size.height / 2.0f);
//        rightView.hidden = YES;
        _rightViewSize = rightView.frame.size;
        _rightView = rightView;
    }
    return _rightView;
}


@end
