//
//  PersonalSegViewController.h
//  ZXProject
//
//  Created by Mr.X on 2017/1/22.
//  Copyright © 2017年 Mr.X. All rights reserved.
//

#import "BaseViewController.h"
#import "LLSegmentedControl.h"

@interface PersonalSegViewController : BaseViewController

@property(nonatomic, retain)LLSegmentedControl *seg;
@property(nonatomic, retain)TPKeyboardAvoidingScrollView *pageScrollView;
@property(nonatomic, retain)TPKeyboardAvoidingTableView *onetableView;
@property(nonatomic, retain)TPKeyboardAvoidingTableView *twoTableView;
@property(nonatomic, retain)TPKeyboardAvoidingTableView *threetableView;
@property(nonatomic, retain)TPKeyboardAvoidingTableView *fourTableView;


@end
