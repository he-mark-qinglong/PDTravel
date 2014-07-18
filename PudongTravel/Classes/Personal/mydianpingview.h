//
//  mydianpingview.h
//  pudongapp
//
//  Created by jiangjunli on 14-3-1.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mydianpingview : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabelview;

@end
