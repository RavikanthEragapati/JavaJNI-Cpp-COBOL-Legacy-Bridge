# Java-Cpp-COBOL-Legacy-Bridge
Bridging Legacy Systems using Java JNI + C/Cpp + COBOL

# Install JDK, COBOL (C/C++ compiler is already avaialbe in Mac)

```cmd
brew install openjdk@17
brew install gnu-cobol
```
# set JAVA_HOME and add jdk17 location to PATH variable 

__File:__ `.zshrc`

```text
export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
```
# Add the following paths to c/C++ config in VSCode

So VSCode IntelliSense knows the files exist and wont show red squiggles. 

* `jni.h` is located here -> `/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home/include`
* `jni-md.h` is located here -> `/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home/include/darwin` 
* `libcob.h` is located here -> `/opt/homebrew/Cellar/gnucobol/3.2_1/include`

To figure out the location where gnu-cobol is installed execute the following command 

```cmd
brew info gnu-cobol | grep 'Cellar'
```

# Compile the Java class

```cmd
javac JavaJNIExample.java
```
# Generate the C/C++ header file (JavaPOC.h)

```cmd
javac -h . JavaJNIExample.java
```

# Compile COBOL code

```cmd
cobc -c cobol_logic.cob
```

# To read the global entrypoint (T) name from a compiled COBOL program

```cmd
nm cobol_logic.o | grep COBOL
```

## Output:
```text
0000000000000028 T _COBOL__BUSINESS__LOGIC
00000000000000a8 t _COBOL__BUSINESS__LOGIC_
0000000000000798 b _COBOL__BUSINESS__LOGIC_.b_10
00000000000007a0 b _COBOL__BUSINESS__LOGIC_.b_11
00000000000007a8 b _COBOL__BUSINESS__LOGIC_.b_12
00000000000007b0 b _COBOL__BUSINESS__LOGIC_.b_13
00000000000007b8 b _COBOL__BUSINESS__LOGIC_.b_14
00000000000007c0 b _COBOL__BUSINESS__LOGIC_.b_18
00000000000007d0 b _COBOL__BUSINESS__LOGIC_.b_2
0000000000000790 b _COBOL__BUSINESS__LOGIC_.b_9
0000000000000678 d _COBOL__BUSINESS__LOGIC_.f_19
0000000000000784 b _COBOL__BUSINESS__LOGIC_.initialized
00000000000007c8 b _COBOL__BUSINESS__LOGIC_.last_b_17
0000000000000788 b _COBOL__BUSINESS__LOGIC_.module
000000000000047c t _COBOL__BUSINESS__LOGIC_module_init
```

# Example for Linux/macOS (adjust include paths for your JDK)

```cmd
g++ -dynamiclib -o libJavaJNIExample.dylib JniCppBridge.cpp cobol_logic.o  -I$JAVA_HOME/include -I$JAVA_HOME/include/darwin -I/opt/homebrew/Cellar/gnucobol/3.2_1/include -L/opt/homebrew/Cellar/gnucobol/3.2_1/lib -lcob
```


# Run Java 

```cmd
java -Djava.library.path=. JavaJNIExample
```


# Console Output 

```cmd

ravieragapati@Mac Java-Cpp-COBOL-Legacy-Bridge % javac JavaJNIExample.java       
ravieragapati@Mac Java-Cpp-COBOL-Legacy-Bridge % javac -h . JavaJNIExample.java
ravieragapati@Mac Java-Cpp-COBOL-Legacy-Bridge % cobc -c cobol_logic.cob
ravieragapati@Mac Java-Cpp-COBOL-Legacy-Bridge % g++ -dynamiclib -o libJavaJNIExample.dylib JniCppBridge.cpp cobol_logic.o  -I$JAVA_HOME/include -I$JAVA_HOME/include/darwin -I/opt/homebrew/Cellar/gnucobol/3.2_1/include -L/opt/homebrew/Cellar/gnucobol/3.2_1/lib -lcob
ravieragapati@Mac Java-Cpp-COBOL-Legacy-Bridge % java -Djava.library.path=. JavaJNIExample
--- Starting Java Processing Loop ---

[JAVA] Calling JNI for loop iteration: 0
[C++] COBOL Runtime Initialized.
[C++] Received counter from Java: 0
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000001 (ODD)
[C++] Received counter back from COBOL: 0
[JAVA] JNI call returned: 0

[JAVA] Calling JNI for loop iteration: 1
[C++] Received counter from Java: 1
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000002 (EVEN)
[C++] Received counter back from COBOL: 1
[JAVA] JNI call returned: 1

[JAVA] Calling JNI for loop iteration: 2
[C++] Received counter from Java: 2
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000003 (ODD)
[C++] Received counter back from COBOL: 2
[JAVA] JNI call returned: 2

[JAVA] Calling JNI for loop iteration: 3
[C++] Received counter from Java: 3
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000004 (EVEN)
[C++] Received counter back from COBOL: 3
[JAVA] JNI call returned: 3

[JAVA] Calling JNI for loop iteration: 4
[C++] Received counter from Java: 4
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000005 (ODD)
[C++] Received counter back from COBOL: 4
[JAVA] JNI call returned: 4

[JAVA] Calling JNI for loop iteration: 5
[C++] Received counter from Java: 5
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000006 (EVEN)
[C++] Received counter back from COBOL: 5
[JAVA] JNI call returned: 5

[JAVA] Calling JNI for loop iteration: 6
[C++] Received counter from Java: 6
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000007 (ODD)
[C++] Received counter back from COBOL: 6
[JAVA] JNI call returned: 6

[JAVA] Calling JNI for loop iteration: 7
[C++] Received counter from Java: 7
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000008 (EVEN)
[C++] Received counter back from COBOL: 7
[JAVA] JNI call returned: 7

[JAVA] Calling JNI for loop iteration: 8
[C++] Received counter from Java: 8
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000009 (ODD)
[C++] Received counter back from COBOL: 8
[JAVA] JNI call returned: 8

[JAVA] Calling JNI for loop iteration: 9
[C++] Received counter from Java: 9
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000010 (EVEN)
---------------------------------------------------
--- STATS REPORT @ LOOP +0000000010 ---
---------------------------------------------------
Total COBOL Calls: +0000000010
Total EVEN Counts: +0000000005
Total ODD Counts:  +0000000005
---------------------------------------------------
[C++] Received counter back from COBOL: 9
[JAVA] JNI call returned: 9

[JAVA] Calling JNI for loop iteration: 10
[C++] Received counter from Java: 10
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000011 (ODD)
[C++] Received counter back from COBOL: 10
[JAVA] JNI call returned: 10

[JAVA] Calling JNI for loop iteration: 11
[C++] Received counter from Java: 11
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000012 (EVEN)
[C++] Received counter back from COBOL: 11
[JAVA] JNI call returned: 11

[JAVA] Calling JNI for loop iteration: 12
[C++] Received counter from Java: 12
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000013 (ODD)
[C++] Received counter back from COBOL: 12
[JAVA] JNI call returned: 12

[JAVA] Calling JNI for loop iteration: 13
[C++] Received counter from Java: 13
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000014 (EVEN)
[C++] Received counter back from COBOL: 13
[JAVA] JNI call returned: 13

[JAVA] Calling JNI for loop iteration: 14
[C++] Received counter from Java: 14
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000015 (ODD)
[C++] Received counter back from COBOL: 14
[JAVA] JNI call returned: 14

[JAVA] Calling JNI for loop iteration: 15
[C++] Received counter from Java: 15
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000016 (EVEN)
[C++] Received counter back from COBOL: 15
[JAVA] JNI call returned: 15

[JAVA] Calling JNI for loop iteration: 16
[C++] Received counter from Java: 16
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000017 (ODD)
[C++] Received counter back from COBOL: 16
[JAVA] JNI call returned: 16

[JAVA] Calling JNI for loop iteration: 17
[C++] Received counter from Java: 17
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000018 (EVEN)
[C++] Received counter back from COBOL: 17
[JAVA] JNI call returned: 17

[JAVA] Calling JNI for loop iteration: 18
[C++] Received counter from Java: 18
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000019 (ODD)
[C++] Received counter back from COBOL: 18
[JAVA] JNI call returned: 18

[JAVA] Calling JNI for loop iteration: 19
[C++] Received counter from Java: 19
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000020 (EVEN)
---------------------------------------------------
--- STATS REPORT @ LOOP +0000000020 ---
---------------------------------------------------
Total COBOL Calls: +0000000020
Total EVEN Counts: +0000000010
Total ODD Counts:  +0000000010
---------------------------------------------------
[C++] Received counter back from COBOL: 19
[JAVA] JNI call returned: 19

[JAVA] Calling JNI for loop iteration: 20
[C++] Received counter from Java: 20
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000021 (ODD)
[C++] Received counter back from COBOL: 20
[JAVA] JNI call returned: 20

[JAVA] Calling JNI for loop iteration: 21
[C++] Received counter from Java: 21
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000022 (EVEN)
[C++] Received counter back from COBOL: 21
[JAVA] JNI call returned: 21

[JAVA] Calling JNI for loop iteration: 22
[C++] Received counter from Java: 22
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000023 (ODD)
[C++] Received counter back from COBOL: 22
[JAVA] JNI call returned: 22

[JAVA] Calling JNI for loop iteration: 23
[C++] Received counter from Java: 23
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000024 (EVEN)
[C++] Received counter back from COBOL: 23
[JAVA] JNI call returned: 23

[JAVA] Calling JNI for loop iteration: 24
[C++] Received counter from Java: 24
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000025 (ODD)
[C++] Received counter back from COBOL: 24
[JAVA] JNI call returned: 24

[JAVA] Calling JNI for loop iteration: 25
[C++] Received counter from Java: 25
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000026 (EVEN)
[C++] Received counter back from COBOL: 25
[JAVA] JNI call returned: 25

[JAVA] Calling JNI for loop iteration: 26
[C++] Received counter from Java: 26
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000027 (ODD)
[C++] Received counter back from COBOL: 26
[JAVA] JNI call returned: 26

[JAVA] Calling JNI for loop iteration: 27
[C++] Received counter from Java: 27
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000028 (EVEN)
[C++] Received counter back from COBOL: 27
[JAVA] JNI call returned: 27

[JAVA] Calling JNI for loop iteration: 28
[C++] Received counter from Java: 28
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000029 (ODD)
[C++] Received counter back from COBOL: 28
[JAVA] JNI call returned: 28

[JAVA] Calling JNI for loop iteration: 29
[C++] Received counter from Java: 29
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000030 (EVEN)
---------------------------------------------------
--- STATS REPORT @ LOOP +0000000030 ---
---------------------------------------------------
Total COBOL Calls: +0000000030
Total EVEN Counts: +0000000015
Total ODD Counts:  +0000000015
---------------------------------------------------
[C++] Received counter back from COBOL: 29
[JAVA] JNI call returned: 29

[JAVA] Calling JNI for loop iteration: 30
[C++] Received counter from Java: 30
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000031 (ODD)
[C++] Received counter back from COBOL: 30
[JAVA] JNI call returned: 30

[JAVA] Calling JNI for loop iteration: 31
[C++] Received counter from Java: 31
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000032 (EVEN)
[C++] Received counter back from COBOL: 31
[JAVA] JNI call returned: 31

[JAVA] Calling JNI for loop iteration: 32
[C++] Received counter from Java: 32
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000033 (ODD)
[C++] Received counter back from COBOL: 32
[JAVA] JNI call returned: 32

[JAVA] Calling JNI for loop iteration: 33
[C++] Received counter from Java: 33
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000034 (EVEN)
[C++] Received counter back from COBOL: 33
[JAVA] JNI call returned: 33

[JAVA] Calling JNI for loop iteration: 34
[C++] Received counter from Java: 34
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000035 (ODD)
[C++] Received counter back from COBOL: 34
[JAVA] JNI call returned: 34

[JAVA] Calling JNI for loop iteration: 35
[C++] Received counter from Java: 35
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000036 (EVEN)
[C++] Received counter back from COBOL: 35
[JAVA] JNI call returned: 35

[JAVA] Calling JNI for loop iteration: 36
[C++] Received counter from Java: 36
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000037 (ODD)
[C++] Received counter back from COBOL: 36
[JAVA] JNI call returned: 36

[JAVA] Calling JNI for loop iteration: 37
[C++] Received counter from Java: 37
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000038 (EVEN)
[C++] Received counter back from COBOL: 37
[JAVA] JNI call returned: 37

[JAVA] Calling JNI for loop iteration: 38
[C++] Received counter from Java: 38
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000039 (ODD)
[C++] Received counter back from COBOL: 38
[JAVA] JNI call returned: 38

[JAVA] Calling JNI for loop iteration: 39
[C++] Received counter from Java: 39
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000040 (EVEN)
---------------------------------------------------
--- STATS REPORT @ LOOP +0000000040 ---
---------------------------------------------------
Total COBOL Calls: +0000000040
Total EVEN Counts: +0000000020
Total ODD Counts:  +0000000020
---------------------------------------------------
[C++] Received counter back from COBOL: 39
[JAVA] JNI call returned: 39

[JAVA] Calling JNI for loop iteration: 40
[C++] Received counter from Java: 40
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000041 (ODD)
[C++] Received counter back from COBOL: 40
[JAVA] JNI call returned: 40

[JAVA] Calling JNI for loop iteration: 41
[C++] Received counter from Java: 41
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000042 (EVEN)
[C++] Received counter back from COBOL: 41
[JAVA] JNI call returned: 41

[JAVA] Calling JNI for loop iteration: 42
[C++] Received counter from Java: 42
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000043 (ODD)
[C++] Received counter back from COBOL: 42
[JAVA] JNI call returned: 42

[JAVA] Calling JNI for loop iteration: 43
[C++] Received counter from Java: 43
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000044 (EVEN)
[C++] Received counter back from COBOL: 43
[JAVA] JNI call returned: 43

[JAVA] Calling JNI for loop iteration: 44
[C++] Received counter from Java: 44
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000045 (ODD)
[C++] Received counter back from COBOL: 44
[JAVA] JNI call returned: 44

[JAVA] Calling JNI for loop iteration: 45
[C++] Received counter from Java: 45
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000046 (EVEN)
[C++] Received counter back from COBOL: 45
[JAVA] JNI call returned: 45

[JAVA] Calling JNI for loop iteration: 46
[C++] Received counter from Java: 46
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000047 (ODD)
[C++] Received counter back from COBOL: 46
[JAVA] JNI call returned: 46

[JAVA] Calling JNI for loop iteration: 47
[C++] Received counter from Java: 47
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000048 (EVEN)
[C++] Received counter back from COBOL: 47
[JAVA] JNI call returned: 47

[JAVA] Calling JNI for loop iteration: 48
[C++] Received counter from Java: 48
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000049 (ODD)
[C++] Received counter back from COBOL: 48
[JAVA] JNI call returned: 48

[JAVA] Calling JNI for loop iteration: 49
[C++] Received counter from Java: 49
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000050 (EVEN)
---------------------------------------------------
--- STATS REPORT @ LOOP +0000000050 ---
---------------------------------------------------
Total COBOL Calls: +0000000050
Total EVEN Counts: +0000000025
Total ODD Counts:  +0000000025
---------------------------------------------------
[C++] Received counter back from COBOL: 49
[JAVA] JNI call returned: 49

[JAVA] Calling JNI for loop iteration: 50
[C++] Received counter from Java: 50
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000051 (ODD)
[C++] Received counter back from COBOL: 50
[JAVA] JNI call returned: 50

[JAVA] Calling JNI for loop iteration: 51
[C++] Received counter from Java: 51
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000052 (EVEN)
[C++] Received counter back from COBOL: 51
[JAVA] JNI call returned: 51

[JAVA] Calling JNI for loop iteration: 52
[C++] Received counter from Java: 52
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000053 (ODD)
[C++] Received counter back from COBOL: 52
[JAVA] JNI call returned: 52

[JAVA] Calling JNI for loop iteration: 53
[C++] Received counter from Java: 53
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000054 (EVEN)
[C++] Received counter back from COBOL: 53
[JAVA] JNI call returned: 53

[JAVA] Calling JNI for loop iteration: 54
[C++] Received counter from Java: 54
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000055 (ODD)
[C++] Received counter back from COBOL: 54
[JAVA] JNI call returned: 54

[JAVA] Calling JNI for loop iteration: 55
[C++] Received counter from Java: 55
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000056 (EVEN)
[C++] Received counter back from COBOL: 55
[JAVA] JNI call returned: 55

[JAVA] Calling JNI for loop iteration: 56
[C++] Received counter from Java: 56
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000057 (ODD)
[C++] Received counter back from COBOL: 56
[JAVA] JNI call returned: 56

[JAVA] Calling JNI for loop iteration: 57
[C++] Received counter from Java: 57
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000058 (EVEN)
[C++] Received counter back from COBOL: 57
[JAVA] JNI call returned: 57

[JAVA] Calling JNI for loop iteration: 58
[C++] Received counter from Java: 58
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000059 (ODD)
[C++] Received counter back from COBOL: 58
[JAVA] JNI call returned: 58

[JAVA] Calling JNI for loop iteration: 59
[C++] Received counter from Java: 59
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000060 (EVEN)
---------------------------------------------------
--- STATS REPORT @ LOOP +0000000060 ---
---------------------------------------------------
Total COBOL Calls: +0000000060
Total EVEN Counts: +0000000030
Total ODD Counts:  +0000000030
---------------------------------------------------
[C++] Received counter back from COBOL: 59
[JAVA] JNI call returned: 59

[JAVA] Calling JNI for loop iteration: 60
[C++] Received counter from Java: 60
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000061 (ODD)
[C++] Received counter back from COBOL: 60
[JAVA] JNI call returned: 60

[JAVA] Calling JNI for loop iteration: 61
[C++] Received counter from Java: 61
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000062 (EVEN)
[C++] Received counter back from COBOL: 61
[JAVA] JNI call returned: 61

[JAVA] Calling JNI for loop iteration: 62
[C++] Received counter from Java: 62
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000063 (ODD)
[C++] Received counter back from COBOL: 62
[JAVA] JNI call returned: 62

[JAVA] Calling JNI for loop iteration: 63
[C++] Received counter from Java: 63
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000064 (EVEN)
[C++] Received counter back from COBOL: 63
[JAVA] JNI call returned: 63

[JAVA] Calling JNI for loop iteration: 64
[C++] Received counter from Java: 64
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000065 (ODD)
[C++] Received counter back from COBOL: 64
[JAVA] JNI call returned: 64

[JAVA] Calling JNI for loop iteration: 65
[C++] Received counter from Java: 65
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000066 (EVEN)
[C++] Received counter back from COBOL: 65
[JAVA] JNI call returned: 65

[JAVA] Calling JNI for loop iteration: 66
[C++] Received counter from Java: 66
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000067 (ODD)
[C++] Received counter back from COBOL: 66
[JAVA] JNI call returned: 66

[JAVA] Calling JNI for loop iteration: 67
[C++] Received counter from Java: 67
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000068 (EVEN)
[C++] Received counter back from COBOL: 67
[JAVA] JNI call returned: 67

[JAVA] Calling JNI for loop iteration: 68
[C++] Received counter from Java: 68
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000069 (ODD)
[C++] Received counter back from COBOL: 68
[JAVA] JNI call returned: 68

[JAVA] Calling JNI for loop iteration: 69
[C++] Received counter from Java: 69
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000070 (EVEN)
---------------------------------------------------
--- STATS REPORT @ LOOP +0000000070 ---
---------------------------------------------------
Total COBOL Calls: +0000000070
Total EVEN Counts: +0000000035
Total ODD Counts:  +0000000035
---------------------------------------------------
[C++] Received counter back from COBOL: 69
[JAVA] JNI call returned: 69

[JAVA] Calling JNI for loop iteration: 70
[C++] Received counter from Java: 70
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000071 (ODD)
[C++] Received counter back from COBOL: 70
[JAVA] JNI call returned: 70

[JAVA] Calling JNI for loop iteration: 71
[C++] Received counter from Java: 71
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000072 (EVEN)
[C++] Received counter back from COBOL: 71
[JAVA] JNI call returned: 71

[JAVA] Calling JNI for loop iteration: 72
[C++] Received counter from Java: 72
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000073 (ODD)
[C++] Received counter back from COBOL: 72
[JAVA] JNI call returned: 72

[JAVA] Calling JNI for loop iteration: 73
[C++] Received counter from Java: 73
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000074 (EVEN)
[C++] Received counter back from COBOL: 73
[JAVA] JNI call returned: 73

[JAVA] Calling JNI for loop iteration: 74
[C++] Received counter from Java: 74
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000075 (ODD)
[C++] Received counter back from COBOL: 74
[JAVA] JNI call returned: 74

[JAVA] Calling JNI for loop iteration: 75
[C++] Received counter from Java: 75
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000076 (EVEN)
[C++] Received counter back from COBOL: 75
[JAVA] JNI call returned: 75

[JAVA] Calling JNI for loop iteration: 76
[C++] Received counter from Java: 76
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000077 (ODD)
[C++] Received counter back from COBOL: 76
[JAVA] JNI call returned: 76

[JAVA] Calling JNI for loop iteration: 77
[C++] Received counter from Java: 77
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000078 (EVEN)
[C++] Received counter back from COBOL: 77
[JAVA] JNI call returned: 77

[JAVA] Calling JNI for loop iteration: 78
[C++] Received counter from Java: 78
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000079 (ODD)
[C++] Received counter back from COBOL: 78
[JAVA] JNI call returned: 78

[JAVA] Calling JNI for loop iteration: 79
[C++] Received counter from Java: 79
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000080 (EVEN)
---------------------------------------------------
--- STATS REPORT @ LOOP +0000000080 ---
---------------------------------------------------
Total COBOL Calls: +0000000080
Total EVEN Counts: +0000000040
Total ODD Counts:  +0000000040
---------------------------------------------------
[C++] Received counter back from COBOL: 79
[JAVA] JNI call returned: 79

[JAVA] Calling JNI for loop iteration: 80
[C++] Received counter from Java: 80
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000081 (ODD)
[C++] Received counter back from COBOL: 80
[JAVA] JNI call returned: 80

[JAVA] Calling JNI for loop iteration: 81
[C++] Received counter from Java: 81
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000082 (EVEN)
[C++] Received counter back from COBOL: 81
[JAVA] JNI call returned: 81

[JAVA] Calling JNI for loop iteration: 82
[C++] Received counter from Java: 82
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000083 (ODD)
[C++] Received counter back from COBOL: 82
[JAVA] JNI call returned: 82

[JAVA] Calling JNI for loop iteration: 83
[C++] Received counter from Java: 83
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000084 (EVEN)
[C++] Received counter back from COBOL: 83
[JAVA] JNI call returned: 83

[JAVA] Calling JNI for loop iteration: 84
[C++] Received counter from Java: 84
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000085 (ODD)
[C++] Received counter back from COBOL: 84
[JAVA] JNI call returned: 84

[JAVA] Calling JNI for loop iteration: 85
[C++] Received counter from Java: 85
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000086 (EVEN)
[C++] Received counter back from COBOL: 85
[JAVA] JNI call returned: 85

[JAVA] Calling JNI for loop iteration: 86
[C++] Received counter from Java: 86
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000087 (ODD)
[C++] Received counter back from COBOL: 86
[JAVA] JNI call returned: 86

[JAVA] Calling JNI for loop iteration: 87
[C++] Received counter from Java: 87
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000088 (EVEN)
[C++] Received counter back from COBOL: 87
[JAVA] JNI call returned: 87

[JAVA] Calling JNI for loop iteration: 88
[C++] Received counter from Java: 88
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000089 (ODD)
[C++] Received counter back from COBOL: 88
[JAVA] JNI call returned: 88

[JAVA] Calling JNI for loop iteration: 89
[C++] Received counter from Java: 89
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000090 (EVEN)
---------------------------------------------------
--- STATS REPORT @ LOOP +0000000090 ---
---------------------------------------------------
Total COBOL Calls: +0000000090
Total EVEN Counts: +0000000045
Total ODD Counts:  +0000000045
---------------------------------------------------
[C++] Received counter back from COBOL: 89
[JAVA] JNI call returned: 89

[JAVA] Calling JNI for loop iteration: 90
[C++] Received counter from Java: 90
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000091 (ODD)
[C++] Received counter back from COBOL: 90
[JAVA] JNI call returned: 90

[JAVA] Calling JNI for loop iteration: 91
[C++] Received counter from Java: 91
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000092 (EVEN)
[C++] Received counter back from COBOL: 91
[JAVA] JNI call returned: 91

[JAVA] Calling JNI for loop iteration: 92
[C++] Received counter from Java: 92
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000093 (ODD)
[C++] Received counter back from COBOL: 92
[JAVA] JNI call returned: 92

[JAVA] Calling JNI for loop iteration: 93
[C++] Received counter from Java: 93
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000094 (EVEN)
[C++] Received counter back from COBOL: 93
[JAVA] JNI call returned: 93

[JAVA] Calling JNI for loop iteration: 94
[C++] Received counter from Java: 94
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000095 (ODD)
[C++] Received counter back from COBOL: 94
[JAVA] JNI call returned: 94

[JAVA] Calling JNI for loop iteration: 95
[C++] Received counter from Java: 95
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000096 (EVEN)
[C++] Received counter back from COBOL: 95
[JAVA] JNI call returned: 95

[JAVA] Calling JNI for loop iteration: 96
[C++] Received counter from Java: 96
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000097 (ODD)
[C++] Received counter back from COBOL: 96
[JAVA] JNI call returned: 96

[JAVA] Calling JNI for loop iteration: 97
[C++] Received counter from Java: 97
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000098 (EVEN)
[C++] Received counter back from COBOL: 97
[JAVA] JNI call returned: 97

[JAVA] Calling JNI for loop iteration: 98
[C++] Received counter from Java: 98
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000099 (ODD)
[C++] Received counter back from COBOL: 98
[JAVA] JNI call returned: 98

[JAVA] Calling JNI for loop iteration: 99
[C++] Received counter from Java: 99
[C++] Pointer address: 0x16f4ae9e8
[C++] Alignment test (address % 4): 0
[COBOL] Entered COBOL logic.
[COBOL] Execution:+0000000100 (EVEN)
---------------------------------------------------
--- STATS REPORT @ LOOP +0000000100 ---
---------------------------------------------------
Total COBOL Calls: +0000000100
Total EVEN Counts: +0000000050
Total ODD Counts:  +0000000050
---------------------------------------------------
[C++] Received counter back from COBOL: 99
[JAVA] JNI call returned: 99
--- Processing Finished. ---

```
