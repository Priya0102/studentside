//
//  StudentProfileViewController.m
//  Eshiksa
//
//  Created by Punit on 24/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.


#import "StudentProfileViewController.h"
#import <Foundation/Foundation.h>
#import "Constant.h"
#import "BaseViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Base.h"
@interface StudentProfileViewController ()
{
//    BOOL highlighted;
//    BOOL selected;
//    BOOL enabled;
}

@end

@implementation StudentProfileViewController
@synthesize studentIdtext;
@synthesize sectiontxt;
@synthesize coursetxt;
@synthesize dateofbirthtxt;
@synthesize addresstxt;
@synthesize emailtxt;
@synthesize batchtxt;
@synthesize mobiletxt;
@synthesize aboutTxt;
@synthesize contactTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.profilepicImg.layer.cornerRadius = self.profilepicImg.frame.size.width / 2;
    self.profilepicImg.clipsToBounds = YES;
    self.profilepicImg.layer.borderWidth = 1.0f;
    self.profilepicImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.profileview.layer.cornerRadius = self.profilepicImg.frame.size.width / 2;
    self.profileview.clipsToBounds = YES;
    self.profileview.layer.borderWidth = 1.0f;
    self.profileview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //self.upBtn.layer.cornerRadius=6.0f;
    //self.downBtn.layer.cornerRadius=6.0f;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = _downBtn.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:(18.0/225.0) green:(132.0/225.0) blue:(204.0/255.0)alpha:1.0].CGColor, (id)[UIColor colorWithRed:(185.0/225.0) green:(156.0/225.0) blue:(231.0/255.0)alpha:1.0].CGColor,(id)[UIColor colorWithRed:(202.0/225.0) green:(99.0/225.0) blue:(210.0/255.0)alpha:1.0].CGColor];
    
    [_downBtn.layer insertSublayer:gradient atIndex:0];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_downBtn.bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                                         cornerRadii:CGSizeMake(6.0, 6.0)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _downBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    // Set the newly created shapelayer as the mask for the image view's layer
    _downBtn.layer.mask = maskLayer;
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:_upBtn.bounds
                                                    byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                          cornerRadii:CGSizeMake(6.0, 6.0)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer1 = [CAShapeLayer layer];
    maskLayer1.frame = _upBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    // Set the newly created shapelayer as the mask for the image view's layer
    _upBtn.layer.mask = maskLayer1;
    
    [self getProfile];
    
//    UIImage *unselectedImage = [UIImage imageNamed:@"unselected.png"];
//    UIImage *selectedImage = [UIImage imageNamed:@"selected.png"];
//    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
//    [b setBackgroundImage:unselectedImage forState:UIControlStateNormal];
//    [b setBackgroundImage:selectedImage forState:UIControlStateSelected];
  //  [ addTarget:self action:@selector(downBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [b setFrame:CGRectMake(0, 0, 40, 40)];
//    [self.contactView addSubview:b];
}
//-(void) buttonPressed:(UIButton *)sender
//{
//    if([sender isSelected]){
//        //...
//        [sender setSelected:NO];
//    } else {
//        //...
//        [sender setSelected:YES];
//    }
//    
//}
-(void)getProfile{
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    
   // NSString *mainstr1=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/profile.php"];
    
    NSString *mainstr1=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:profile]];
   
    
    NSDictionary *parameterDict =
    @{ @"groupname": groupname,
       @"username": username,
       @"dbname":dbname,
       @"Branch_id": branchid,
       @"org_id": orgid,
       @"cyear": cyear,
       @"url": mainstr1,
       @"tag": @"user_detail",
       @"password": password};
    
    
    [Constant executequery:mainstr1 strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response student profile data:%@",maindic);
            
            self.studentId.text=[maindic objectForKey:@"studentId"];
            self.groupname.text=[maindic objectForKey:@"groupname"];
            self.mobile.text=[maindic objectForKey:@"mobile"];
            self.email.text=[maindic objectForKey:@"email"];
            self.dob.text=[maindic objectForKey:@"dob"];
            self.address.text=[maindic objectForKey:@"address"];
            self.firstName.text=[maindic objectForKey:@"first_name"];
            self.lastName.text=[maindic objectForKey:@"last_name"];
            self.instUrl.text=[maindic objectForKey:@"instUrl"];
            self.course.text=[maindic objectForKey:@"course_name"];
            self.batch.text=[maindic objectForKey:@"batch_name"];
            self.semestername.text=[maindic objectForKey:@"semester_name"];
            self.section.text=[maindic objectForKey:@"section_name"];
            self.username.text=[maindic objectForKey:@"username"];
            
            //self.profilepicImg.image=[maindic objectForKey:@"pic_id"];
            //self.empid.text=[maindic objectForKey:@"tag"];
            //self.empid.text=[maindic objectForKey:@"success"];
            //self.empid.text=[maindic objectForKey:@"error"];
            NSString *str4=[maindic objectForKey:@"pic_id"];
            
            
            if(self.section.text==(NSString *) [NSNull null])
            {
                self.section.text=@"not given";
            }
            if(self.semestername.text==(NSString *) [NSNull null])
            {
             self.semestername.text=@"not given";
            }
            if(self.instUrl.text==(NSString *) [NSNull null])
            {
                self.instUrl.text=@"not given";
            }
            
            NSString *tempimgstr=str4;
           [_profilepicImg sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
                              placeholderImage:[UIImage imageNamed:@"default.png"]];
            
            self.studentName.text = [NSString stringWithFormat: @"%@ %@", self.firstName.text,self.lastName.text];
            
            NSLog(@"studentId====%@ mobile num==%@",self.studentId.text,self.mobile.text);
            
            [[NSUserDefaults standardUserDefaults] setObject:_studentId.text forKey:@"studentId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];

}



- (IBAction)downBtnClicked:(UIButton *)sender {
    

    if (sender.highlighted == NO)
    {
        sender.selected = YES;
        sender.highlighted = NO;
        sender.enabled = YES;
        
        //_aboutView.hidden=NO;
        _contactView.hidden=YES;
        _downBtnLbl.text=@"About";
        _upBtnLbl.text=@"Contact";
    }
    
    
   else {
        
        sender.selected = YES;
        sender.highlighted = NO;
        sender.enabled = YES;
                _aboutView.hidden=YES;
                //_contactView.hidden=NO;
                _downBtnLbl.text=@"About";
                _upBtnLbl.text=@"Contact";
        
    }
    
    
    
}

- (IBAction)upBtnClicked:(UIButton *)sender {
    
    if (sender.highlighted == NO)
    {
        sender.selected = YES;
        sender.highlighted = NO;
        sender.enabled = YES;
        
       // _aboutView.hidden=NO;
        _contactView.hidden=YES;
        _upBtnLbl.text=@"About";
        _downBtnLbl.text=@"Contact";
    }
    
    //Toggle off implementation.
    
    else {
        
        sender.selected = NO;
        sender.highlighted = YES;
        sender.enabled = NO;
        _aboutView.hidden=YES;
        //_contactView.hidden=NO;
        _upBtnLbl.text=@"Contact";
        _downBtnLbl.text=@"About";
        
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    

    studentIdtext.text = [@"STUDENT_ID" localize];
    sectiontxt.text=[@"SECTION" localize];
    coursetxt.text = [@"COURSE" localize];
    dateofbirthtxt.text=[@"DOB" localize];
    addresstxt.text=[@"HOME_ADDRESS" localize];
    emailtxt.text=[@"HOME_EMAIL" localize];
    batchtxt.text=[@"BATCH" localize];
    mobiletxt.text=[@"HOME_MOBILE" localize];
    aboutTxt.text=[@"ABOUT" localize];
    contactTxt.text=[@"CONTACT" localize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    studentIdtext.text = [@"STUDENT_ID" localize];
    sectiontxt.text=[@"SECTION" localize];
    coursetxt.text = [@"COURSE" localize];
    dateofbirthtxt.text=[@"DOB" localize];
    addresstxt.text=[@"HOME_ADDRESS" localize];
    emailtxt.text=[@"HOME_EMAIL" localize];
    batchtxt.text=[@"BATCH" localize];
    mobiletxt.text=[@"HOME_MOBILE" localize];
    aboutTxt.text=[@"ABOUT" localize];
    contactTxt.text=[@"CONTACT" localize];
}

- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"MY_PROFILE" localize];
}

@end
