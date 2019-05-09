//
//  PanViewController.m
//  iosGestures
//
//  Created by Frank Chen on 2019-05-09.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "PanViewController.h"

@interface PanViewController ()

@end

@implementation PanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
- (IBAction)redViewPanned:(UIPanGestureRecognizer *)sender {
//    CGPoint locationInView = [sender locationInView:self.view];
//    sender.view.center = locationInView;
    CGPoint translationInView = [sender translationInView: self.view];
    CGPoint oldCenter = sender.view.center;
    CGPoint newCenter =  CGPointMake(oldCenter.x + translationInView.x, oldCenter.y + translationInView.y);
    sender.view.center = newCenter;
    [sender setTranslation:CGPointZero inView:self.view];
}



@end
