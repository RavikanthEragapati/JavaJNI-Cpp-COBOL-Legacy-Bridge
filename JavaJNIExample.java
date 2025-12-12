public class JavaJNIExample {

    // 1. Declare the native method signature
    public native int processAccount(int currentCounter);

    // 2. Load the shared library containing the C++ JNI code
    static {
        /*
          NOTE: The library name depends on your OS: 
           Windows: JavaPOC.dll
          Linux/macOS: libJavaPOC.so or libJavaPOC.dylib
          Make sure the library is in your java.library.path
         */
         System.loadLibrary("JavaJNIExample");
    }

    public void startProcessing() {

        System.out.println("--- Starting Java Processing Loop ---");
        int j = -1;
        for (int i = 0; i < 100; i++) {
            System.out.println("\n[JAVA] Calling JNI for loop iteration: " + i);
            
             j = processAccount(i);
            
            System.out.println("[JAVA] JNI call returned: " + j);
        }
        
        System.out.println("--- Processing Finished. ---");
    }

    public static void main(String[] args) {
        new JavaJNIExample().startProcessing();
    }
}