--- browser.c.orig	2016-10-08 19:35:50 UTC
+++ browser.c
@@ -80,6 +80,12 @@ static int browser_compare_subject (cons
   struct folder_file *pa = (struct folder_file *) a;
   struct folder_file *pb = (struct folder_file *) b;
 
+  /* Always keep '..' in first menu position */
+  if (!strncmp(pa->name, "..", 2))
+	  return(-1);
+  if (!strncmp(pb->name, "..", 2))
+	  return(1);
+
   int r = mutt_strcoll (pa->name, pb->name);
 
   return ((BrowserSort & SORT_REVERSE) ? -r : r);
@@ -90,6 +96,12 @@ static int browser_compare_date (const v
   struct folder_file *pa = (struct folder_file *) a;
   struct folder_file *pb = (struct folder_file *) b;
 
+  /* Always keep '..' in first menu position */
+  if (!strncmp(pa->name, "..", 2))
+	  return(-1);
+  if (!strncmp(pb->name, "..", 2))
+	  return(1);
+
   int r = pa->mtime - pb->mtime;
 
   return ((BrowserSort & SORT_REVERSE) ? -r : r);
@@ -100,6 +112,12 @@ static int browser_compare_size (const v
   struct folder_file *pa = (struct folder_file *) a;
   struct folder_file *pb = (struct folder_file *) b;
 
+  /* Always keep '..' in first menu position */
+  if (!strncmp(pa->name, "..", 2))
+	  return(-1);
+  if (!strncmp(pb->name, "..", 2))
+	  return(1);
+
   int r = pa->size - pb->size;
 
   return ((BrowserSort & SORT_REVERSE) ? -r : r);
