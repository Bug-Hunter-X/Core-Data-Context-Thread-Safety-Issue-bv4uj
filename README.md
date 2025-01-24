# Objective-C Core Data Thread Safety Bug

This repository demonstrates a common error in Objective-C when using Core Data's `NSManagedObjectContext`.  The bug involves attempting to access and modify a context from a thread other than the one it was created on. This leads to crashes or data corruption due to Core Data's lack of thread safety for context operations.

The `bug.m` file shows the problematic code. The solution, demonstrated in `bugSolution.m`, properly utilizes Core Data's concurrency features to handle data operations on separate threads safely.