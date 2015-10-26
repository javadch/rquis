# RQt
R Package that enables access to the XQt APIs


1. Install JRE 8
2. Install JDK 8  
  2.1. Set the JAVA_HOME environement variable to point to the JDK root folder  
3. Check JDK 8 is the latest version recognized by the OS
4. Install R 3.2.2 or upper
5. Install RStuido 0.99.484 or upper
6. Install dev.tools (may need installing its prerequisites.)
7. Install rJava
8. From RStudio issue: devtools::install_github("JavadCh/RQt", ref="develop")
9. To test the installation:  
  9.1. Issue this command: demo(package ="RQt", RQtTest2)  
  9.2. Press Enter  
  9.3. Check your RStudio Global Enrvironment, it should contain var3 (5 obs. 7 vars.) and var4 (4 obs. 2 vars.)
10. In case of issues, consult the log file in the logs folder of the package. Contact us if not fixed.

