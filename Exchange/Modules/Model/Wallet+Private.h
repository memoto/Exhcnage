#import "Wallet.h"

@interface Wallet ()

@property (readwrite, nonatomic, copy) NSArray<Money *> *moneys;

@end

@interface Wallet (Private)

- (NSUInteger)indexOfCurrency:(NSString *)currencyID;

@end
