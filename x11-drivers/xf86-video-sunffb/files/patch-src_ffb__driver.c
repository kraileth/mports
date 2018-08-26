From 181b60190c1f81fc9b9b5deb07d536b78f2536ab Mon Sep 17 00:00:00 2001
From: Matthieu Herrb <matthieu.herrb@laas.fr>
Date: Mon, 10 Jun 2013 21:51:08 +0200
Subject: Unbreak when XAA is not present.

Turn accel off if loading XAA fails.

Signed-off-by: Matthieu Herrb <matthieu.herrb@laas.fr>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/src/ffb_driver.c b/src/ffb_driver.c
index af13484..7f17d64 100644
--- src/ffb_driver.c
+++ src/ffb_driver.c
@@ -413,9 +413,12 @@ FFBPreInit(ScrnInfoPtr pScrn, int flags)
 	return FALSE;
     }
 
-    if (xf86LoadSubModule(pScrn, "xaa") == NULL) {
-	FFBFreeRec(pScrn);
-	return FALSE;
+    if (!pFfb->NoAccel) {
+        if (xf86LoadSubModule(pScrn, "xaa") == NULL) {
+            xf86DrvMsg(pScrn->scrnIndex, X_INFO,
+                       "Loading XAA failed, acceleration disabled\n");
+            pFfb->NoAccel = TRUE;
+        }
     }
 
     if (pFfb->HWCursor && xf86LoadSubModule(pScrn, "ramdac") == NULL) {
-- 
cgit v0.10.2

