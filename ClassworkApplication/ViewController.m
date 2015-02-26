//
//  ViewController.m
//  ClassworkApplication
//
//  Created by Gena on 26.02.15.
//  Copyright (c) 2015 Gena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CGPoint startPan;
    CGPoint touchLocation;
}

@property (weak, nonatomic) IBOutlet UIView *hiddenView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintToLeft;
@property (weak, nonatomic) IBOutlet UIView *menuView;
- (IBAction)buttonPressed:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)animateToRight
{
    [UIView animateWithDuration:1.0 animations:^{
        CGRect frame = CGRectMake(0, self.hiddenView.frame.origin.y, self.hiddenView.frame.size.width, self.hiddenView.frame.size.height);
        [self.hiddenView setFrame:frame];
        self.constraintToLeft.constant = 0;
    }];
}

- (void)animateToLeft
{
    [UIView animateWithDuration:1.0 animations:^{
        CGRect frame = CGRectMake(self.menuView.frame.size.width * (-1), self.hiddenView.frame.origin.y, self.hiddenView.frame.size.width, self.hiddenView.frame.size.height);
        [self.hiddenView setFrame:frame];
        self.constraintToLeft.constant = self.menuView.frame.size.width * (-1);
    }];
}

- (IBAction)handlePanFromButton:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        startPan = [pan locationInView:pan.view];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        touchLocation = [pan locationInView:pan.view];
        CGFloat x = touchLocation.x - startPan.x + self.hiddenView.frame.origin.x;
        if (x > 0) x = 0;
        if (x < -self.menuView.frame.size.width) x = -self.menuView.frame.size.width;
        CGFloat y = self.hiddenView.frame.origin.y;
        [self.hiddenView setFrame:CGRectMake(x, y, self.hiddenView.frame.size.width, self.hiddenView.frame.size.height)];
        self.constraintToLeft.constant = x;
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (touchLocation.x > startPan.x) {
            [self animateToRight];
        } else if (startPan.x > touchLocation.x) {
            [self animateToLeft];
        }
    }
}

- (IBAction)handlePanFromMenue:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        startPan = [pan locationInView:pan.view];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        touchLocation = [pan locationInView:pan.view];
        CGFloat x = touchLocation.x - startPan.x + self.hiddenView.frame.origin.x;
        if (x > 0) x = 0;
        if (x < -self.menuView.frame.size.width) x = -self.menuView.frame.size.width;
        CGFloat y = self.hiddenView.frame.origin.y;
        [self.hiddenView setFrame:CGRectMake(x, y, self.hiddenView.frame.size.width, self.hiddenView.frame.size.height)];
        self.constraintToLeft.constant = x;
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (touchLocation.x > startPan.x) {
            [self animateToRight];
        } else if (startPan.x > touchLocation.x) {
            [self animateToLeft];
        }
    }
}

- (IBAction)buttonPressed:(UIButton *)sender {
    if (self.constraintToLeft.constant < 0) {
        [self animateToRight];
    } else {
        [self animateToLeft];
    }
}
@end
