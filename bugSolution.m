To correctly handle multi-threaded operations with `NSManagedObjectContext`, you should use the appropriate concurrency type and perform operations on the correct thread.  Here's a corrected version:

```objectivec
NSManagedObjectContext *mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
[privateContext setParentContext:mainContext];

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
    // Perform operations on the private queue context
    // ... fetch, update, delete ...
    NSError *error = nil;
    if (![privateContext save:&error]) {
        NSLog("Error saving private context: %@
", error);
    }
    dispatch_async(dispatch_get_main_queue(), ^{       
      NSError *error = nil;    
        if (![mainContext save:&error]) {
            NSLog("Error saving main context: %@
", error);   
        }
    });
});
```

This solution uses a private queue context (`NSPrivateQueueConcurrencyType`) for background operations.  Changes are saved to this context first, then merged into the main context on the main thread using the parent-child relationship. This ensures thread safety and prevents data corruption.