//
//  SwipeViewController.m
//  iosGestures
//
//  Created by Frank Chen on 2019-05-09.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "SwipeViewController.h"

@interface SwipeViewController ()

@property (nonatomic,assign)BOOL Open;

@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectZero];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor brownColor];
    [self.view addSubview:view];
    
    UIView* whiteView = [[UIView alloc]initWithFrame:CGRectZero];
    whiteView.translatesAutoresizingMaskIntoConstraints = NO;
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.clipsToBounds = YES;
    [view addSubview:whiteView];
    
    UISwipeGestureRecognizer* swipeLeftRecog = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    swipeLeftRecog.direction = UISwipeGestureRecognizerDirectionLeft;
    [whiteView addGestureRecognizer:swipeLeftRecog];
    
    UISwipeGestureRecognizer* swipeRightRecog = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    swipeRightRecog.direction = UISwipeGestureRecognizerDirectionRight;
    [whiteView addGestureRecognizer:swipeRightRecog];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [view.widthAnchor constraintEqualToConstant:300],
                                              [view.heightAnchor constraintEqualToConstant:50],
                                              [view.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0],
                                              [view.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:0],
                                              [whiteView.centerXAnchor constraintEqualToAnchor:view.centerXAnchor constant:0],
                                              [whiteView.centerYAnchor constraintEqualToAnchor:view.centerYAnchor constant:0],
                                              [whiteView.heightAnchor constraintEqualToConstant:50 ],
                                              [whiteView.widthAnchor constraintEqualToConstant:300],
                                              ]
     ];
    
}

-(void)handleSwipe:(UISwipeGestureRecognizer*)sender{
    CGPoint originalCenter = sender.view.center;
    if (self.Open && sender.direction == UISwipeGestureRecognizerDirectionRight) {
        sender.view.center = CGPointMake(originalCenter.x + 100, originalCenter.y);
        self.Open = NO;
    } else if (!self.Open && sender.direction  == UISwipeGestureRecognizerDirectionLeft){
        sender.view.center = CGPointMake(originalCenter.x - 100, originalCenter.y);
        self.Open = YES;
    }
}


@end
