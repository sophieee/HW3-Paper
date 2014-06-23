//
//  MainViewController.m
//  HW3 Paper
//
//  Created by Sophie Tang on 6/19/14.
//  Copyright (c) 2014 Sophie Tang. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *MainUIView;
@property (weak, nonatomic) IBOutlet UIImageView *MenuUIImage;
@property (weak, nonatomic) IBOutlet UIView *FeedUIView;
@property (weak, nonatomic) IBOutlet UIView *HeadlineUIView;
@property (weak, nonatomic) IBOutlet UIView *Card1View;
@property (weak, nonatomic) IBOutlet UIView *Card2View;
@property (weak, nonatomic) IBOutlet UIView *Card3View;

- (IBAction)OnDragMain:(UIPanGestureRecognizer *)sender;
- (IBAction)OnDragFeed:(UIPanGestureRecognizer *)sender;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //[self performSelector:@selector(ChangeHeadlines) withObject:nil afterDelay:0];

    timer = [NSTimer scheduledTimerWithTimeInterval:9 target:self selector:@selector(ChangeHeadlines) userInfo:nil repeats:YES];
    
    CGPoint center = self.FeedUIView.center;
    NSLog(@"feed center: %@", NSStringFromCGPoint(center));

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ChangeHeadlines{
    
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
        self.Card1View.alpha = 1;
        self.Card2View.alpha = 1;
        self.Card3View.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:3 options:0 animations:^{
            self.Card1View.alpha = 0;
            self.Card2View.alpha = 1;
            self.Card3View.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:3 options:0 animations:^{
                self.Card1View.alpha = 0;
                self.Card2View.alpha = 0;
                self.Card3View.alpha = 1;
            } completion:nil];
        }];
    }];
}

- (IBAction)OnDragMain:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.HeadlineUIView];
    CGPoint velocity = [sender velocityInView:self.HeadlineUIView];

    NSLog(@"translation of headline: %@", NSStringFromCGPoint(translation));
    NSLog(@"velocity of headline: %@", NSStringFromCGPoint(velocity));

    CGPoint center = self.MainUIView.center;
    
    if (self.MainUIView.center.y >= (self.MainUIView.frame.size.height / 2) && center.y < (self.MainUIView.frame.size.height * 1.5 - 47)) {
            
        center.y = (self.MainUIView.frame.size.height / 2) + translation.y;
        
    } else if (self.MainUIView.center.y >= (self.MainUIView.frame.size.height * 1.5 - 47)) {
            
        center.y = self.MainUIView.frame.size.height * 1.5 - 47;
    
    } else if (self.MainUIView.center.y < (self.MainUIView.frame.size.height / 2) && center.y > (self.MainUIView.frame.size.height / 2) - 25) {
            
        center.y = self.MainUIView.frame.size.height / 2 + translation.y * 0.2;

    } else {
        center.y = self.MainUIView.frame.size.height / 2 - 25;
    }
    self.MainUIView.center = center;
    
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (velocity.y > 0) {
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                CGPoint center = self.MainUIView.center;
                center.y = self.view.frame.size.height * 1.5 - 47;
                self.MainUIView.center = center;
            } completion:nil];

        } else {
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                CGPoint center = self.MainUIView.center;
                center.y = self.view.frame.size.height / 2;
                self.MainUIView.center = center;
            } completion:nil];
        }
    }
}

- (IBAction)OnDragFeed:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.FeedUIView];
    CGPoint velocity = [sender velocityInView:self.FeedUIView];
    
    NSLog(@"translation of feed: %@", NSStringFromCGPoint(translation));
    NSLog(@"velocity of feed: %@", NSStringFromCGPoint(velocity));
    
    
    CGPoint center = self.FeedUIView.center;
    
    if (center.x >= (self.FeedUIView.frame.size.width / 2) && center.x < (self.FeedUIView.frame.size.width / 2 + 100)) {
        
        center.x = (self.FeedUIView.frame.size.width / 2) + translation.x * 0.5;
        
    } else if (center.x >= (self.FeedUIView.frame.size.width / 2 + 100)) {
        
        center.x = (self.FeedUIView.frame.size.width / 2 + 100);
        
    } else if (center.x < (self.FeedUIView.frame.size.width / 2) && center.x > self.MainUIView.frame.size.width - self.FeedUIView.frame.size.width / 2) {
        
        center.x = center.x + translation.x * 0.1;
        
    } else if (center.x <= self.MainUIView.frame.size.width - self.FeedUIView.frame.size.width / 2 && center.x > self.MainUIView.frame.size.width - self.FeedUIView.frame.size.width / 2 - 100) {
        
        center.x = (self.MainUIView.frame.size.width - self.FeedUIView.frame.size.width / 2) + translation.x * 0.5;
        
    } else if (center.x <= self.MainUIView.frame.size.width - self.FeedUIView.frame.size.width / 2 - 100) {
        
        center.x = (self.MainUIView.frame.size.width - self.FeedUIView.frame.size.width / 2) - 100;
        
    }
    self.FeedUIView.center = center;
    
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (center.x >= (self.FeedUIView.frame.size.width / 2)) {
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                CGPoint center = self.FeedUIView.center;
                center.x = self.FeedUIView.frame.size.width / 2;
                self.FeedUIView.center = center;
            } completion:nil];
            
        } else if (center.x < self.FeedUIView.frame.size.width / 2 && center.x > self.MainUIView.frame.size.width - self.FeedUIView.frame.size.width / 2 && velocity.x > 0){
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                CGPoint center = self.FeedUIView.center;
                if (center.x + 100 <= (self.FeedUIView.frame.size.width / 2)) {
                    center.x = center.x + 100;
                } else {
                    center.x = self.FeedUIView.frame.size.width / 2;
                }
                self.FeedUIView.center = center;
            } completion:nil];
            
        } else if (center.x < self.FeedUIView.frame.size.width / 2 && center.x > self.MainUIView.frame.size.width - self.FeedUIView.frame.size.width / 2 && velocity.x < 0) {
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                CGPoint center = self.FeedUIView.center;
                if (center.x - 100 >= self.MainUIView.frame.size.width - self.FeedUIView.frame.size.width / 2) {
                    center.x = center.x - 100;
                } else {
                    center.x = self.MainUIView.frame.size.width - self.FeedUIView.frame.size.width / 2;
                }
                self.FeedUIView.center = center;
            } completion:nil];
            
        }else {
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                CGPoint center = self.FeedUIView.center;
                center.x = self.MainUIView.frame.size.width - self.FeedUIView.frame.size.width / 2;
                self.FeedUIView.center = center;
            } completion:nil];
            
        }
    }
    
}

@end
