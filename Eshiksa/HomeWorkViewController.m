//
//  HomeWorkViewController.m
//  Eshiksa
//
//  Created by Punit on 21/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "HomeWorkViewController.h"
#import "HomeWorkTableViewCell.h"
#import "Homework.h"
#import "Constant.h"
@interface HomeWorkViewController ()

@end

@implementation HomeWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    _homeworkArr=[[NSMutableArray alloc]init];
    _homeworkNameArr=[[NSMutableArray alloc]init];
    _subjectNameArr=[[NSMutableArray alloc]init];
    _submissionDateArr=[[NSMutableArray alloc]init];
    _homeworkPathArr=[[NSMutableArray alloc]init];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self parsingHomeworkData];
}
-(void)parsingHomeworkData
{
    [_homeworkArr removeAllObjects];
    [_homeworkNameArr removeAllObjects];
    [_subjectNameArr removeAllObjects];
    [_submissionDateArr removeAllObjects];
    [_homeworkPathArr removeAllObjects];
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in circular==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular username ==%@",username);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"circular password ==%@",password);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"circular cyear ==%@",cyear);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"circular orgid ==%@",orgid);
    
    
    NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/teacher_homework_assign.php";
   // http://shop.eshiksa.com/appAPI_v2_edemo/teacher_homework_assign.php
   // http://shop.eshiksa.com/appAPI_v2_edemo/homework.php
//    { "groupname":"Student",
//        "username":"Om2591",
//        "instUrl":"http://erp.eshiksa.net/edemo_fees",
//        "dbname":"erpeshik_esh_slave_edemo",
//        "Branch_id":"259",
//        "tag":"paid"
//        
//    }
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"dbname":@"erpeshik_esh_slave_edemo_new",
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url": @"http://shop.eshiksa.com/appAPI_v2_edemo/teacher_homework_assign.php",
                                    @"tag": @"view_homework"
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  circular data:%@",maindic);
            NSArray *ciculararr=[maindic objectForKey:@"homework_list"];
            NSLog(@"ciculararr:%@",ciculararr);
            
            if(ciculararr.count==0)
            {
                _noSchedule = [[UITextView alloc]initWithFrame:
                               CGRectMake(80, 200, 400, 300)];
                [_noSchedule setText:@"No homework is given..."];
                [_noSchedule setTextColor:[UIColor grayColor]];
                [_noSchedule setFont:[UIFont fontWithName:@"ArialMT" size:16]];
                _noSchedule.delegate =self;
                [self.view addSubview:_noSchedule];
                
            }
            else {
            
       
            
            for(NSDictionary *temp in ciculararr)
            {
                NSString *str1=[[temp objectForKey:@"subject"]description];
                NSString *str2=[[temp objectForKey:@"submission_date"]description];
                NSString *str3=[temp objectForKey:@"hw_name"];
                NSString *str4=[temp objectForKey:@"hw_file"];
                
                
                NSLog(@"subject=%@  submission_date=%@ hw_name=%@ hw_file=%@",str1,str2,str3,str4);
                
                
                Homework *k1=[[Homework alloc]init];
                k1.subjectNameStr=str1;
                k1.submissionDateStr=str2;
                k1.homeworkStr=str3;
                k1.homeworkpathStr=str4;
                
                
                [_homeworkArr addObject:k1];
                
                [_tableview reloadData];
            }
            }
        }
        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
    //[task resume];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _homeworkArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeWorkTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Homework *ktemp=[_homeworkArr objectAtIndex:indexPath.row];
    
    cell.submissionDate.text=ktemp.submissionDateStr;
    cell.subject.text=ktemp.subjectNameStr;
    cell.homeworkName.text=ktemp.homeworkStr;
    cell.homeworkPath.text=ktemp.homeworkpathStr;
    
    return cell;
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
