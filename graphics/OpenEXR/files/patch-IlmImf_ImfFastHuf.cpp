--- IlmImf/ImfFastHuf.cpp.orig	2014-08-10 08:23:56.000000000 +0400
+++ IlmImf/ImfFastHuf.cpp	2015-04-08 00:10:07.536640000 +0300
@@ -107,7 +107,7 @@
     for (int i = 0; i <= MAX_CODE_LEN; ++i)
     {
         codeCount[i] = 0;
-        base[i]      = 0xffffffffffffffffL;
+        base[i]      = 0xffffffffffffffffULL;
         offset[i]    = 0;
     }
 
@@ -352,7 +352,7 @@
 
     for (int i = 0; i <= MAX_CODE_LEN; ++i)
     {
-        if (base[i] != 0xffffffffffffffffL)
+        if (base[i] != 0xffffffffffffffffULL)
         {
             _ljBase[i] = base[i] << (64 - i);
         }
@@ -362,7 +362,7 @@
             // Unused code length - insert dummy values
             //
 
-            _ljBase[i] = 0xffffffffffffffffL;
+            _ljBase[i] = 0xffffffffffffffffULL;
         }
     }
 
@@ -417,7 +417,7 @@
 
     int minIdx = TABLE_LOOKUP_BITS;
 
-    while (minIdx > 0 && _ljBase[minIdx] == 0xffffffffffffffffL)
+    while (minIdx > 0 && _ljBase[minIdx] == 0xffffffffffffffffULL)
         minIdx--;
 
     if (minIdx < 0)
@@ -427,7 +427,7 @@
         // Set the min value such that the table is never tested.
         //
 
-        _tableMin = 0xffffffffffffffffL;
+        _tableMin = 0xffffffffffffffffULL;
     }
     else
     {
