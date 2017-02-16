#import <Foundation/Foundation.h>
#import "DataSource.h"

@class AnyPromise;

@interface WalletTestStorage : NSObject<Storage>

- (AnyPromise *)items;
- (void)setItems:(NSArray *)items;

@end
