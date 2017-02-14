//
//  Money.h
//  Exchange
//
//  Created by Константин on 14.02.17.
//  Copyright © 2017 KYurichev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Money : NSObject

@property (readonly, nonatomic, copy) NSString *currencyID;
@property (readonly, nonatomic, copy) NSNumber *amount;

- (instancetype)initWithCurrencyID:(NSString *)currencyID andAmount:(NSNumber *)amount;

@end
