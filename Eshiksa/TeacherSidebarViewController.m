//
//  TeacherSidebarViewController.m
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "TeacherSidebarViewController.h"
#import "Constant.h"
//#import <SDWebImage/UIImageView+WebCache.h>
@interface TeacherSidebarViewController ()

@end

@implementation TeacherSidebarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *email = [[NSUserDefaults standardUserDefaults]
//                          stringForKey:@"email"];
//    NSLog(@"profile email ==%@",email);
//    self.gmail.text=email;
//    
//    NSString *teachername = [[NSUserDefaults standardUserDefaults]
//                          stringForKey:@"teachername"];
//    NSLog(@"teachername ==%@",teachername);
//    self.teachername.text=teachername;
    
    [self getProfile];
    
}
-(void)getProfile{
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in profile==%@",groupname);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"profile password ==%@",password);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"profile orgid ==%@",orgid);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"profile branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"profile cyear ==%@",cyear);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);
    
    
    NSString *mainstr1=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/profile.php"];
    
    NSDictionary *parameterDict =
    @{ @"groupname":groupname,
       @"username":username,
       @"dbname":@"erpeshik_esh_slave_edemo_new",
       @"Branch_id":branchid,
       @"org_id":orgid,
       @"cyear":cyear,
       @"url":@"http://shop.eshiksa.com/appAPI_v2_edemo/profile.php",
       @"tag": @"user_detail",
       @"password":password };
    
    NSLog(@"parameter dict%@",parameterDict);
    
    [Constant executequery:mainstr1 strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response teacher profile data:%@",maindic);
            
           
        
            self.gmail.text=[maindic objectForKey:@"email"];
        
            self.firstname.text=[maindic objectForKey:@"first_name"];
            self.lastname.text=[maindic objectForKey:@"last_name"];
            //self.profilepicImg.image=[maindic objectForKey:@"pic_id"];
            //self.empid.text=[maindic objectForKey:@"tag"];
            //self.empid.text=[maindic objectForKey:@"success"];
            //self.empid.text=[maindic objectForKey:@"error"];
            NSString *str4=[maindic objectForKey:@"pic_id"];
            
            NSString *tempimgstr=str4;
           // [_profileImg sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
                              //placeholderImage:[UIImage imageNamed:@"default.png"]];
            
            self.teachername.text = [NSString stringWithFormat: @"%@ %@", self.firstname.text,self.lastname.text];
            
            
          
            
            NSLog(@"Email====%@ teachername==%@",self.gmail.text,self.teachername.text);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
