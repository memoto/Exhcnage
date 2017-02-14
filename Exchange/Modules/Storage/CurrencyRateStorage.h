#import <Foundation/Foundation.h>
#import "DataSource.h"

@interface CurrencyRateStorage : NSObject<Storage>

@property (nonatomic) BOOL shouldCache;

- (AnyPromise *)items;

@end

@interface CurrencyRateTestStorage : NSObject<Storage>

- (AnyPromise *)items;

@end
