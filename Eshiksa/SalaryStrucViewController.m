//
//  SalaryStrucViewController.m
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "SalaryStrucViewController.h"
#import "Constant.h"
@interface SalaryStrucViewController ()

@end

@implementation SalaryStrucViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self salaryStructure];
}

-(void)salaryStructure{
    
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
    
    
    NSString *urlstr=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/teacherSalaryStructure.php"];
    
    NSDictionary *parameterDict =
    @{ @"groupname":groupname,
       @"username": username,
       @"dbname": @"erpeshik_esh_slave_edemo_new",
       @"instUrl":@"http://erp.eshiksa.net/eps",
       @"Branch_id":branchid,
       @"org_id":orgid,
       @"cyear":cyear,
       @"url": @"http://shop.eshiksa.com/appAPI_v2_edemo/teacherSalaryStructure.php",
       @"tag": @"salaryStructure",
       @"password": password };
    
    NSLog(@"parameter dict%@",parameterDict);
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response salary data:%@",maindic);
            
            self.empNmae.text=[maindic objectForKey:@"emp_name"];
            self.department.text=[maindic objectForKey:@"department"];
            self.empSalary.text=[maindic objectForKey:@"emp_salary"];
            
            NSArray *payablesArr=[maindic objectForKey:@"Payables"];
            
            NSLog(@"payablesArr:%@",payablesArr);
            
            for(NSDictionary *temp in payablesArr)
            {
                NSString *str1=[[temp objectForKey:@"payable_name"]description];
                NSString *str2=[[temp objectForKey:@"payable_amount"]description];
                
                 NSLog(@"payable_name=%@  payable_amount=%@ ",str1,str2);
            }
      NSArray *deductablesArr=[maindic objectForKey:@"Deductables"];
            
            for(NSDictionary *temp1 in deductablesArr)
            {
                NSString *str1=[[temp1 objectForKey:@"deductable_name"]description];
                NSString *str2=[[temp1 objectForKey:@"deductable_amount"]description];
                
                NSLog(@"deductable_name=%@  deductable_amount=%@ ",str1,str2);
            }
           
            
            NSLog(@"empNmae====%@ basicPayAmount==%@",self.empNmae.text,self.basicPayAmount.text);
        }
    }];
}


@end
