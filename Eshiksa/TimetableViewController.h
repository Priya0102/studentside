//
//  TimetableViewController.h
//  Eshiksa
//
//  Created by Punit on 20/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimetableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UITextViewDelegate>
{
    NSString *day;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;

@property (nonatomic,strong) NSMutableArray *lectureTimingArr,*lectureNameArr,*subjectnameArr,*subjectIdArr,*timetableArr,*detailArr,*studentTimetableArr,*teacherNameArr,*breakArr;

@property(nonatomic,retain)NSString *indxp,*circularIdStr,*titleStr;
@property (nonatomic,strong) NSString *success,*email,*error,*tag,*user,*studenttimetable,*section,*count,*name,*detail;
@property (strong,nonatomic) NSMutableArray *timetable;
@property (strong, nonatomic) IBOutlet UITextView *noSchedule;


@end
