//
//  SingleBookDetail.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/30.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "SingleBookDetail.h"

@implementation SingleBookDetail

-(nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"ID" : @"ID",
             @"ISBN" :@"ISBN",
             @"SecondTitle" :@"SecondTitle",
             @"Pub" :@"Pub",
             @"Tilte" :@"Tilte",
             @"Form" :@"Form",
             @"Author" :@"Author",
             @"Sort" :@"Sort",
             @"Subject" :@"Subject",
             @"RentTimes" :@"RentTimes",
             @"FavTimes" :@"FavTimes",
             @"BrowseTimes" :@"BrowseTimes",
             @"Total" :@"Total",
             @"Avaliable" :@"Avaliable",
             @"CirculationInfo" :SingleCirculationInfo.class,
             @"ReferBooks" :SingleReferBooks.class,
             @"DoubanInfo" :SingleDoubanInfo.class
             };
}

@end
