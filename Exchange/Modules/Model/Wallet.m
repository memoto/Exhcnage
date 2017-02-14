//
//  Wallet.m
//  Exchange
//
//  Created by Константин on 14.02.17.
//  Copyright © 2017 KYurichev. All rights reserved.
//

#import "Wallet.h"
#import "Money.h"
#import "Wallet+Private.h"

@implementation Wallet

- (instancetype)initWithMoneys:(NSArray<Money *> *)moneys {
    if (self) {
        self.moneys = moneys;
    }
    return self;
}

- (Money *)moneyForCurrency:(NSString *)currencyID {
    let currencyIndex = [self indexOfCurrency:currencyID];
    let money = self.moneys[currencyIndex];
    
    return money;
}

- (BOOL)hasMoney:(Money *)requiredMoney {
    
    let money = [self moneyForCurrency:requiredMoney.currencyID];
    if (money == nil) { return NO; }
    
    return money.amount.doubleValue >= requiredMoney.amount.doubleValue;
}

@end
