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

- (id)copyWithZone:(NSZone *)zone {
    Money *copy = [[[self class] alloc] init];
    
    if (copy) {
        copy.currencyID = self.currencyID;
        copy.amount = self.amount;
    }
    
    return copy;
}

@end

#import "MoneyConverter.h"

@implementation Money (Comparison)

- (BOOL)isGreaterThanOther:(Money *)money {
    let mine = self;
    let theirs = money;
    
    if (mine == nil) { return NO; }
    //NSAssert(![mine.currencyID isEqualToString:theirs.currencyID], @"`isGreaterThanOther` can only compare money of same currency; Use `crossCurrencyRates` variant");
    
    return mine.amount.doubleValue >= theirs.amount.doubleValue;
}

- (BOOL)isGreaterThanOther:(Money *)money crossCurrencyRates:(NSArray<CurrencyRate *> *)rates {
    let converter = [MoneyConverter.alloc initWithRates:rates
                                      andTargetCurrency:self.currencyID];
    let theirs = [converter moneyConvertedFrom:money];
    
    return [self isGreaterThanOther:theirs];
}

- (Money *)moneyBySubstractingOther:(Money *)money {
    
    let remaining = self.amount.doubleValue - money.amount.doubleValue;
    let amount = [NSNumber numberWithDouble:remaining];
    return [Money.alloc initWithCurrencyID:self.currencyID andAmount:amount];
}

@end

@implementation Money (Textual)

- (NSString *)text {
    
    let formatter = NSNumberFormatter.new;
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.currencyCode = self.currencyID;
    let result = [formatter stringFromNumber:self.amount];
    
    return result;
}

@end

