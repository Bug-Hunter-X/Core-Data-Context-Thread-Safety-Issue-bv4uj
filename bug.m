In Objective-C, a common yet subtle error arises when dealing with `NSManagedObjectContext` and its interaction with threads.  Specifically, attempting to perform operations on an `NSManagedObjectContext` from a thread other than the one it was created on can lead to unexpected crashes or data corruption. This is because Core Data's internal structures are not thread-safe.

Consider the following example:

```objectivec
NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
    // Attempting to save the context from a background thread
    NSError *error = nil;
    [context save:&error]; // This is incorrect!
    if (error) {
        NSLog("Error saving context: %@
", error);
    }
});
```

This code snippet demonstrates a common pitfall.  Saving the context is done on a background thread, even though the context was created with `NSMainQueueConcurrencyType`, which explicitly ties it to the main thread.