//
//  RotationViewController.m
//  iosGestures
//
//  Created by Frank Chen on 2019-05-09.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "RotationViewController.h"

@interface RotationViewController ()

@end

@implementation RotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* redBox = [[UIView alloc]initWithFrame:CGRectZero];
    redBox.translatesAutoresizingMaskIntoConstraints = NO;
    redBox.backgroundColor = [UIColor redColor];
    [self.view addSubview:redBox];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [redBox.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [redBox.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
                                              [redBox.heightAnchor constraintEqualToConstant:100],
                                              [redBox.widthAnchor constraintEqualToConstant:100],
                                              ]];
    
    UIRotationGestureRecognizer* rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotation:)];
    
    [redBox addGestureRecognizer:rotationGesture];
}

-(void)handleRotation:(UIRotationGestureRecognizer*)sender{
    CGFloat originalRotation = 0;
    CGFloat lastRotation = 0;
    if (sender.state == UIGestureRecognizerStateBegan) {
        sender.rotation = lastRotation;
        originalRotation = sender.rotation;
    }else if (sender.state == UIGestureRecognizerStateChanged){
        CGFloat newRotation = sender.rotation + originalRotation;
        sender.view.transform = CGAffineTransformMakeRotation(newRotation);
    }else if (sender.state == UIGestureRecognizerStateEnded){
        lastRotation = sender.rotation;
    }
}

@end
