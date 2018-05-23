                                                                //
//  GatepassViewRequest.m
//  Eshiksa
//
//  Created by Punit on 28/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "GatepassViewRequest.h"
#import "GatepassTableViewCell.h"
#import "Gatepass.h"
#import "Constant.h"
#import "BaseViewController.h"
#import "Base.h"
@interface GatepassViewRequest ()

@end

@implementation GatepassViewRequest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    
    _fromDateArr=[[NSMutableArray alloc]init];
    _toDateArr=[[NSMutableArray alloc]init];
    _createdDateArr=[[NSMutableArray alloc]init];
    _gatepassArr=[[NSMutableArray alloc]init];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self parsingGatepass];
}

-(void)parsingGatepass{
    
    
    [_fromDateArr removeAllObjects];
    [_toDateArr removeAllObjects];
    [_createdDateArr removeAllObjects];
    [_gatepassArr removeAllObjects];
    
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in circular==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular username ==%@",username);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"circular cyear ==%@",cyear);

    
    
    //NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/leave.php";
    
     NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:leave]];
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"cyear":cyear,
                                    @"tag":@"gatepass"
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  gatepass data:%@",maindic);
            
            _tag=[maindic objectForKey:@"tag"];
            _success=[[maindic objectForKey:@"success"]stringValue];
            _error=[[maindic objectForKey:@"error"]stringValue];
            _studentId=[maindic objectForKey:@"studentId"];
            
            NSLog(@"Tag===%@",_tag);
            
          
            NSArray *ciculararr=[maindic objectForKey:@"gatepass"];
            NSLog(@"ciculararr:%@",ciculararr);
            
            if(ciculararr.count==0)
            {
                _noSchedule = [[UITextView alloc]initWithFrame:
                               CGRectMake(50,200,400,300)];
                [_noSchedule setText:@"No gatepass data available.."];
                [_noSchedule setTextColor:[UIColor grayColor]];
                [_noSchedule setFont:[UIFont fontWithName:@"ArialMT" size:14]];
                _noSchedule.delegate =self;
                [self.view addSubview:_noSchedule];
                
            }
            else {

            
            for(NSDictionary *temp in ciculararr)
            {
                NSString *str1=[[temp objectForKey:@"from_date"]description];
                NSString *str2=[[temp objectForKey:@"to_date"]description];
                NSString *str3=[temp objectForKey:@"created_date"];
                NSString *str4=[temp objectForKey:@"status"];
                
                
                NSLog(@"from_date=%@  to_date=%@ created_date=%@ status=%@",str1,str2,str3,str4);
                
                
                Gatepass *k1=[[Gatepass alloc]init];
                k1.fromDatestr=str1;
                k1.toDateStr=str2;
                k1.createdDateStr=str3;
                k1.statusStr=str4;
                
                
                [_gatepassArr addObject:k1];
                
                [_tableview reloadData];
            }
          }
        }
        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _gatepassArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GatepassTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Gatepass *ktemp=[_gatepassArr objectAtIndex:indexPath.row];
    
    cell.fromDate.text=ktemp.fromDatestr;
    cell.toDate.text=ktemp.toDateStr;
    cell.createdDate.text=ktemp.createdDateStr;
    cell.status.text=ktemp.statusStr;
    
        return cell;
}

- (void)viewDidLayoutSubviews{
    NSString *language = [@"" currentLanguage];
    if ([language isEqualToString:@"hi"])
    {
        [self setBackButtonLocalize];
    }
}

- (void)setBackButtonLocalize{
    self.navigationItem.title = [@"GATEPASS" localize];
}

@end
