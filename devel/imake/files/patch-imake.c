--- imake.c.orig	2006-05-15 16:28:14 -0400
+++ imake.c	2009-05-25 20:45:58 -0400
@@ -1161,34 +1161,7 @@
 static void
 get_binary_format(FILE *inFile)
 {
-  int mib[2];
-  size_t len;
-  int osrel = 0;
-  FILE *objprog = NULL;
-  int iself = 0;
-  char buf[10];
-  char cmd[PATH_MAX];
-
-  mib[0] = CTL_KERN;
-  mib[1] = KERN_OSRELDATE;
-  len = sizeof(osrel);
-  sysctl(mib, 2, &osrel, &len, NULL, 0);
-  if (CrossCompiling) {
-      strcpy (cmd, CrossCompileDir);
-      strcat (cmd, "/");
-      strcat (cmd,"objformat");
-  } else
-      strcpy (cmd, "objformat");
-
-  if (osrel >= 300004 &&
-      (objprog = popen(cmd, "r")) != NULL &&
-      fgets(buf, sizeof(buf), objprog) != NULL &&
-      strncmp(buf, "elf", 3) == 0)
-    iself = 1;
-  if (objprog)
-    pclose(objprog);
-
-  fprintf(inFile, "#define DefaultToElfFormat %s\n", iself ? "YES" : "NO");
+  fprintf(inFile, "#define DefaultToElfFormat %s\n", "YES");
 }
 #endif
 
