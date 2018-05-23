//
//  ViewRequisitionViewController.m
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "ViewRequisitionViewController.h"
#import "ViewRequistionTableViewCell.h"
#import "ViewRequistion.h"
#import "Constant.h"
@interface ViewRequisitionViewController ()

@end

@implementation ViewRequisitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _viewReqArr=[[NSMutableArray alloc]init];
     _statusArr=[[NSMutableArray alloc]init];
     _requistionDateArr=[[NSMutableArray alloc]init];
    _requisitionTypeArr=[[NSMutableArray alloc]init];
    _requisitionDetailsArr=[[NSMutableArray alloc]init];
    
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self parsingViewRequisition];
}

-(void)parsingViewRequisition
{
    
    [_viewReqArr removeAllObjects];
    [_statusArr removeAllObjects];
    [_requistionDateArr removeAllObjects];
    [_requisitionTypeArr removeAllObjects];
    [_requisitionDetailsArr removeAllObjects];
    
    //  NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:keynote1]];
    
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in view req==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"view req username ==%@",username);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"view req password ==%@",password);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"view req branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"view req cyear ==%@",cyear);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"view req orgid ==%@",orgid);
    
    
    NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/empRequisition.php";
    
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"dbname":@"erpeshik_esh_slave_edemo_new",
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url": @"http://shop.eshiksa.com/appAPI_v2_edemo/empRequisition.php",
                                    @"tag": @"view_emprequisition"
                                    };
    NSLog(@"parameter%@",parameterDict);

    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"response  view requistion data:%@",maindic);
            
            NSArray *reqarr=[maindic objectForKey:@"requisit_deatil"];
            
            
            NSLog(@"requistion arr:%@",reqarr);
            
            for(NSDictionary *temp in reqarr)
            {
//                ViewRequistion *k1=[[ViewRequistion alloc]init];
//                k1.requistionDate=temp[@"req_date"];
//                k1.requisitionType=temp[@"req_type"];
//                k1.requisitionDetails=temp[@"req_details"];
//                k1.status=temp[@"status"];
//                
//                [_viewReqArr addObject:k1];
//                
//                [_tableview reloadData];
                
                NSString *str1=[[temp objectForKey:@"req_date"]description];
                NSString *str2=[[temp objectForKey:@"req_type"]description];
                NSString *str3=[temp objectForKey:@"req_details"];
                NSString *str4=[temp objectForKey:@"status"];
                
                
                NSLog(@"req_date=%@  req_type=%@ req_details=%@ status=%@",str1,str2,str3,str4);
                
                
                ViewRequistion *k1=[[ViewRequistion alloc]init];
                k1.requistionDate=str1;
                k1.requisitionType=str2;
                k1.requisitionDetails=str3;
                k1.status=str4;
                
                
                [_viewReqArr addObject:k1];
                
                [_tableview reloadData];
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
    return _viewReqArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewRequistionTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ViewRequistion *ktemp=[_viewReqArr objectAtIndex:indexPath.row];
    
    cell.status.text=ktemp.status;
    cell.requistionDate.text=ktemp.requistionDate;
    cell.requisitionType.text=ktemp.requisitionType;
    cell.requisitionDetails.text=ktemp.requisitionDetails;
    
    NSLog(@"requisition type==%@",ktemp.requisitionType);
    
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
