//
//  StudentViewController.m
//  Eshiksa
//
//  Created by Punit on 18/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "StudentViewController.h"
#import "BaseViewController.h"
@interface StudentViewController ()

@end

@implementation StudentViewController
@synthesize profiletxt;
@synthesize circulartext;
@synthesize gallerytxt;
@synthesize payfeestxt;
@synthesize paidfeestxt;
@synthesize settingstxt;
@synthesize poweredBy;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width / 2;
    self.profileImg.clipsToBounds = YES;
    self.profileBtn.layer.cornerRadius=6.0f;
    
    self.galleryImg.layer.cornerRadius = self.galleryImg.frame.size.width / 2;
    self.galleryImg.clipsToBounds = YES;
    self.galleryBtn.layer.cornerRadius=6.0f;

    
    self.paidImg.layer.cornerRadius = self.paidImg.frame.size.width / 2;
    self.paidImg.clipsToBounds = YES;
    self.paidBtn.layer.cornerRadius=6.0f;

    
    self.circularImg.layer.cornerRadius = self.circularImg.frame.size.width / 2;
    self.circularImg.clipsToBounds = YES;
    self.circularBtn.layer.cornerRadius=6.0f;

    
    self.payfeeImg.layer.cornerRadius = self.payfeeImg.frame.size.width / 2;
    self.payfeeImg.clipsToBounds =YES;
    self.payfeeBtn.layer.cornerRadius=6.0f;

    
    self.settingImg.layer.cornerRadius = self.settingImg.frame.size.width / 2;
    self.settingImg.clipsToBounds = YES;
    self.settingBtn.layer.cornerRadius=6.0f;

    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    profiletxt.text = [@"MY_PROFILE" localize];
    circulartext.text=[@"CIRCULAR" localize];
    payfeestxt.text = [@"PAY_FEES" localize];
    paidfeestxt.text=[@"PAID_FEES" localize];
    gallerytxt.text=[@"GALLERY" localize];
    settingstxt.text=[@"SETTINGS" localize];
    poweredBy.text=[@"POWERED_BY" localize];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    profiletxt.text = [@"MY_PROFILE" localize];
    circulartext.text=[@"CIRCULAR" localize];
    payfeestxt.text = [@"PAY_FEES" localize];
    paidfeestxt.text=[@"PAID_FEES" localize];
    gallerytxt.text=[@"GALLERY" localize];
    settingstxt.text=[@"SETTINGS" localize];
    poweredBy.text=[@"POWERED_BY" localize];
}


@end
