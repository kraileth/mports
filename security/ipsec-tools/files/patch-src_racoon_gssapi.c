--- src/racoon/gssapi.c.orig	2015-05-19 16:38:06 UTC
+++ src/racoon/gssapi.c
@@ -192,6 +192,11 @@ gssapi_init(struct ph1handle *iph1)
 	gss_name_t princ, canon_princ;
 	OM_uint32 maj_stat, min_stat;
 
+	if (iph1->rmconf == NULL) {
+		plog(LLV_ERROR, LOCATION, NULL, "no remote config\n");
+		return -1;
+	}
+
 	gps = racoon_calloc(1, sizeof (struct gssapi_ph1_state));
 	if (gps == NULL) {
 		plog(LLV_ERROR, LOCATION, NULL, "racoon_calloc failed\n");
