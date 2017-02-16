#import "DataSource.h"

@interface DataSource ()

@property (nonatomic, strong) id<Storage> storage;

@end

@implementation DataSource

- (instancetype)initWithStorage:(id<Storage>)storage {
    self = [super init];
    if (self) {
        self.storage = storage;
    }
    return self;
}

//- (id)first {
//    let firstPromise = self.storage.items.then(^(id value){
//        return value;
//    });
//    return firstPromise;
//}

- (void)fetch {
    __weak let welf = self;
    self.storage.items.then(^(NSArray *items) {
        if (!welf.onNewData) return;
        
        welf.onNewData(items);
    });
}

- (void)setItems:(NSArray *)items {
    [self.storage setItems:items];
}

@end
