//
//  RequestLeaveViewController.m
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "RequestLeaveViewController.h"
#import "Constant.h"
#import "Base.h"
@interface RequestLeaveViewController ()

@end

@implementation RequestLeaveViewController
@synthesize  datepicker;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.requestLeaveBtn.layer.masksToBounds=YES;
    self.requestLeaveBtn.layer.cornerRadius=8;

    
}
-(void)requestLeave{
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in requisition==%@",groupname);
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"requisition branchid ==%@",branchid);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"requisition orgid ==%@",orgid);
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"requisition cyear ==%@",cyear);
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"requisition password ==%@",password);
    
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"profile username ==%@",username);
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"userId"];
    NSLog(@"profile userId ==%@",userId);
    
    
   // NSString *str=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/leave.php"];
    
    NSString *str=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:leave]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id": orgid,
                                    @"cyear": cyear,
                                    @"url":str,
                                    @"tag": @"leave_request",
                                    @"password": password,
                                    @"userId":userId,
                                    @"from":self.fromDateTxtFld.text,
                                    @"to": self.toDateTxtFld.text,
                                    @"reason":self.reasonTxtFld.text
                                    };
    
    NSLog(@"parameter dict==%@",parameterDict);
    
    [Constant executequery:str  strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[[maindic objectForKey:@"error"]stringValue];
            _successMsg=[maindic objectForKey:@"success_msg"];
            
            NSLog(@"tag==%@& success=%@  success msg=%@",_tag,_success,_successMsg);
            
            //  dispatch_async(dispatch_get_main_queue(), ^{
            
            //NSString *codeR = [[object objectForKey:@"success"] stringValue];
            // mysterious missing code
            //if ([coreR isEqualToString:@"200"])
            
            if([self.success isEqualToString:@"1"])
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:_successMsg preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                
                [alertView addAction:ok];
                self.toDateTxtFld.text=@"";
                self.fromDateTxtFld.text=@"";
                self.reasonTxtFld.text=@"";
           
                
                
                [self presentViewController:alertView animated:YES completion:nil];
                
            }
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Osps!" message:_successMsg preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertView dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                
                [alertView addAction:ok];
                
                [self presentViewController:alertView animated:YES completion:nil];
                
            }
            
            
        }
    }];
    
    

    
}
- (IBAction)fromDateBtnClicked:(id)sender {
    
    NSLog(@"FROM DATE Btn clicked.....");
    datepicker=[[UIDatePicker alloc] init];
    datepicker.datePickerMode = UIDatePickerModeDate;
    datepicker.hidden = NO;
    datepicker.date = [NSDate date];
    
    [datepicker addTarget:self
                   action:@selector(LabelChange:)
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datepicker]; //this can set value of selected date to your label change according to your condition
    
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M-d-yyyy"]; // from here u can change format..
    _fromDateTxtFld.text=[df stringFromDate:datepicker.date];
}
- (void)LabelChange:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M-d-yyyy"];
    _fromDateTxtFld.text = [NSString stringWithFormat:@"%@",
                          [df stringFromDate:datepicker.date]];
    
    [datepicker removeFromSuperview];
}
- (IBAction)requestLeaveBtnClicked:(id)sender {
    
    NSLog(@"REQUEST BTN CLICKED.......");
    [self requestLeave];
}


@end
