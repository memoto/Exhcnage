//
//  Money.m
//  Exchange
//
//  Created by Константин on 14.02.17.
//  Copyright © 2017 KYurichev. All rights reserved.
//

#import "Money.h"

@interface Money ()

@property (readwrite, nonatomic, copy) NSString *currencyID;
@property (readwrite, nonatomic, copy) NSNumber *amount;

@end

@implementation Money

- (instancetype)initWithCurrencyID:(NSString *)currencyID andAmount:(NSNumber *)amount {
    self = [super init];
    if (self) {
        self.currencyID = currencyID;
        self.amount = amount;
    }
    return self;
}

@end
