#import "Wallet.h"

@interface Wallet (Private)

@property (readwrite, nonatomic, strong) NSArray<Money *> *moneys;

- (NSUInteger)indexOfCurrency:(NSString *)currencyID;

@end
