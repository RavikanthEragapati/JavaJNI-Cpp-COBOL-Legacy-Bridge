#include <jni.h>
#include <iostream>
#include "JavaJNIExample.h" 
#include <libcob.h>
// ----------------------------------------------------
// COBOL Function Prototype
// ----------------------------------------------------
// We declare the function that COBOL will be compiled as.
// COBOL will receive an integer pointer, which it modifies.
extern "C" void COBOL__BUSINESS__LOGIC(int* counter);

// ----------------------------------------------------
// JNI Implementation
// ----------------------------------------------------
extern "C" JNIEXPORT jint JNICALL Java_JavaJNIExample_processAccount(
    JNIEnv *env, 
    jobject obj, 
    jint currentCounter) {

    // Check if COBOL runtime is initialized. We call this only once.
    static int initialized = 0;
    if (initialized == 0) {
        // Initializes the COBOL runtime environment.
        cob_init(0, NULL);
        initialized = 1;
        std::cout << "[C++] COBOL Runtime Initialized." << std::endl;
    }

    // 1. Convert Java jint to C++ int for passing to COBOL
    int cppCounter = (int)currentCounter;

    std::cout << "[C++] Received counter from Java: " << cppCounter << std::endl;
    
    std::cout << "[C++] Pointer address: " << &cppCounter << std::endl; 
    std::cout << "[C++] Alignment test (address % 4): " << (long long)&cppCounter % 4 << std::endl;

    // 2. Call the COBOL program, passing the counter by reference (pointer)
    // The COBOL program will increment the value at this memory address.
    COBOL__BUSINESS__LOGIC(&cppCounter);
    
    std::cout << "[C++] Received counter back from COBOL: " << cppCounter << std::endl;
    
    // 3. Return the modified C++ int back to Java as a jint
    return (jint)cppCounter;
}