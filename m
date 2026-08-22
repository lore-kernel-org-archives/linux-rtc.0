Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021103.outbound.protection.outlook.com [40.107.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96D37F327;
	Sat, 22 Aug 2026 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787390984; cv=fail; b=pbGGjkc2lAtF61PqFGYpB2ixxABwQNQCQjgD9WX6W8Usu9e3EWHqc3R7BEBPOA9HAlj0cIC+GdEX5CT86cGj0ZcqfIzltoAPY97T/z2etwbRudSbJOAUGLJgkSf5FMCwveTL5PI12GEwrkGzqzhUd4fVuZ8YFyb5W4Twc+7Jjc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787390984; c=relaxed/simple;
	bh=rjuUP+iUfiIvFrPNjsRg9/inomoOMzzo1jAStJQRrCw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=niiGSSkK8mvd1DFI+Ea4N2q2F9r0Nbm5FFpSFret59Wxo2emsbClKVwKisNc4kL4c0Njy8aSiZHuMKi/U32wgvOsTbjoRnYslBcAEdMt2saJz5yVEsUDJ8Ic+FaQDVNhj3RyXNjNEi6Z4h9+P3fNCFO3e+M7RSukCLnYA5EsuHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; dkim=fail (0-bit key) header.d=siliconsignals.io header.i=@siliconsignals.io header.b=HHY4k6Xr reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=siliconsignals.io header.i=@siliconsignals.io header.b="HHY4k6Xr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmJGDMx4sEK4l7sSCqRb1192WkQkKvKOsvLCXKrJwTzsdjShKVSLqd6YPApKH4MzuMi6Lo5ytHwhsx5Ysb4aij5OZWXicy/90yFwk+bOFfLN66zaKpxTqRWIU/mtbu8mc1JtpwfIrv6h328VkaI1wcHIzsukXbtTr/Kv+Yun45Rll/oVwdwDjpzpX/dP+zHnEZ15x99wvvnwmLvVWxt6IB7lXp8XDwFHOe0wbYwZe50YXv3GPaEsyR2R9EIs6ZUk9Hb8kNGr7R7ZATxwXgDG+PAyX+zy7dZo2pbYUdl+FUlUVP0DLx0JQl+wRjaEEdvglKupt+4IbK7Ouhe1/SOvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZcd3ThUORRfubpjfFiewt0p0IwkUAG6qlB2TrYJOc4=;
 b=TKRSgW3S3JuORTmJAs6gnpcar36k++EiT2JTz5qz+dTQsM9mWmBrAr6NK9W1aafdW3PaBO443yZMqHLQ1aoQZvcUO6H+UFEE6A8ST4eFODw/RSRml3qYbo7j9DbijQKHwx5wnBLEirwZHlB3lzfxnyHXOYci0/3WRLQ7OWnRcHfC3v5bZUorKSnlgw7F3yZn6dlHVL7T85BneOUcrmY1giKWME8HnDVOpkBah0W9vLRmxQQZJpBgAA46dB9cwMraWxt5FtooWKaXUN4ZValdiZL74r7T8RjVSu5wtIMTFOQLyLtZsyO75Db0/DXcgb/o+rEsGcyulppG9C1NXaJGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siliconsignals.io;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZcd3ThUORRfubpjfFiewt0p0IwkUAG6qlB2TrYJOc4=;
 b=HHY4k6XrUzrmMMH5wrtkqtdnd+w3NNrYiIMzkb5lCP13YiRsa9VZda1Bm4MxPs6aXqAOsE9moEsvwR/5JU+iD8VlIEhZA5dXGvzP4C3jE93rllX4oOm2uEUfqhAZCBJGDHblItX6rCgR3C9u2rYDRFpb8QqtuOrmwJRhdUjzBPrX3h0H5WiaGYyRU8Efcehgli4LrreszfRMqkeW7U+cS8B+6W5uraYT9xa1/cFymNvck0jxvYT+VPDBCnixaXNSpDZ1sngW8RMfz76XVcusWPGsrFGMljPu4xDnlBSBuWlUdoLej2pOzPgVyR4ofEII8eh4H62vHOESex+BDh47ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2P287MB2892.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:237::12)
 by PN0P287MB1747.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:18e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 09:29:38 +0000
Received: from PN2P287MB2892.INDP287.PROD.OUTLOOK.COM
 ([fe80::8964:b393:996e:e8c2]) by PN2P287MB2892.INDP287.PROD.OUTLOOK.COM
 ([fe80::8964:b393:996e:e8c2%3]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 09:29:38 +0000
From: Dhaval Shiroya <dhaval.shiroya@siliconsignals.io>
To: alexandre.belloni@bootlin.com
Cc: Dhaval Shiroya <dhaval.shiroya@siliconsignals.io>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: rv3028: configure backup switch mode from device tree
Date: Sat, 22 Aug 2026 14:59:11 +0530
Message-Id: <20260822092911.318342-1-dhaval.shiroya@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5P287CA0040.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25f::11) To PN2P287MB2892.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:237::12)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2P287MB2892:EE_|PN0P287MB1747:EE_
X-MS-Office365-Filtering-Correlation-Id: 4704d96c-40e5-49a8-c78c-08df002fe2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|10067099003|56012099006|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info:
	1ooC1cN2UDS9Sb+8t6ecjm3UmKYTel6sGli5DR/qxHm+jTmt3bT1IXIETBJH+s7jADHmRB33j7egDMPR+GVMPcLF6C6rwr+CzIRA/tUoyegjHIksIClMlFLLVCep/qt1z0A2+GtOYmlJ87QUmxcJHlC0lJWpggOIcjFaZn8TCCoC0ivOF55vVh+h3Gaxr2FC1lFLVEWJMbl6kjwbLVyTXBeDVery6NKpQUMp86aYVIYZERWJJIIuVNSekRu/7pZQGXZlpjVTEhLD7cVzh6AuVWiMqGSCfClsUuOHu9oouLYxAOlxynMFapdPjfD4zA8hFWQepTI1Y8IsGHkhybN7Dqsd1d5biYasABz0EoSdobc2sOrBtXpB4vO3lYv7xnlrOvlfBqYWqOrXlFBGsyZpOkjzeeTPXhmcIYD6dmUsaXMQJMq0iI3DNIc/ZqhUrRuO4R5PJYkahP3YZSQ1z0wPTBWlprNR4AmMXPQv4mxiMSHfsg7xCYxvzoEqgg/InCmpk2qAmC+5v8/eUVCtIX+O/UnxQl9Ih5/e3xpG4W7ZUyLb/rEF4ojCI4N0k0lM6MPMFS58VhMbFziK+doKgDkq3Ct673FZ3S047YpxB/zqjRB6pE5Pu3fBEK4KS0ihrBTNC6Y7osOh1D4vw4zMiIt+h4Mbx82a2CHzQJA1gtfqETWqlG8S2oCaTNJFob/AYlm4XpHtPYfXmuoFc7BNPVguMEKdFrnBs0xvhV2tERgDGP8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2P287MB2892.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(38350700014)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gTm5mjorFHqyN3YM/Tph7QVw9E0nb3YU/RhNh2nISnGFAGXssZ2yOvegFZTc?=
 =?us-ascii?Q?+RZtw4kVs5Cx3C/78pNDnTTubLxbyxztIDTjo1c4fqvGlegANhhuTSCAapte?=
 =?us-ascii?Q?DjKUvV/hO4xvfjPv0sGDIeEihdiFWEVaob1d0KeIwrlnLTXSgnB/ZRio1O2e?=
 =?us-ascii?Q?Zlaq/iaSEcUly3VUusHbYEQwR27uJJ4gvuNHjn+tGlsZQU3KO04Vt5sHk2wK?=
 =?us-ascii?Q?ejLacmv8BV3tjEoekp3sG3MI6NppGQuO/HfNzx6u23kORPPSJBuAbqWHE+4m?=
 =?us-ascii?Q?BrZoSNFSsCYcTjEi5z1cwm4XBl1Qw5BIqEx9gtWajxFlNT6jCJOFZYzUP0Ot?=
 =?us-ascii?Q?5Wp2jDVOjNPNMJh6y71hnCI4IfT1OFdeuHeBhzwmfC0GH3NyoXTa8joWWXYo?=
 =?us-ascii?Q?1Mk2xKwYGlgN4w7GzbghSV0Q4/hIgn/wPiMhtKJMly8DjklBTvSohiKg/MzB?=
 =?us-ascii?Q?Vgm0+dKcoZBQvwcwtEQXsVZUbndNhExWxUZGmd73Casj3zbtcPfJIBzXn6Js?=
 =?us-ascii?Q?NZzK7jMqT9L2TbzyNZoCeLIoqSN1qG2Qx8mVDhjBIwILjis4iG3NFXKuJknW?=
 =?us-ascii?Q?I6XvxI29jMquU0QfGphZDEtam/BuN4Cs7cxCWpBHCj9towwqkz8cdRAOqAaf?=
 =?us-ascii?Q?f/YizMSQQysH1cHNWd+xYczPp1qmX22iqGOZvFHx+CCD02gY42C9eIo9ZDef?=
 =?us-ascii?Q?GXKf7lCBu9wJsVDrRUrI1g8MsAyRlrj/mVCMaIRY156n+tHjBi7XsQUgvvz6?=
 =?us-ascii?Q?DA7xcTnAAr3NNobdGUwHcS4bgWRw/ID9b+n65rcG0g4n95Rh5zzhU3U0rweB?=
 =?us-ascii?Q?7Sf9fUnIJMhXdbvDE5pGrcYq1GkeEUiCBFM34muoQNweOLdtTSCde9JkwFI0?=
 =?us-ascii?Q?cu/tTiovm0kMh5KJ7LBm/W1ah9Nq5bceshc767QTo4LC5A3/VXLnqL7X96Ow?=
 =?us-ascii?Q?NiGsjVmvBX+lQKAthru+fFoxdIUB83X0RpN7mi26dhHoVbitnWvObGYSfiCv?=
 =?us-ascii?Q?PKShNH8K4HrDE46PxGyjaKuuJ2l/ZrpbZSXDPBYQdXu+gsTDJTYOG7m+kqSg?=
 =?us-ascii?Q?socnpxBvSeXvxOz9usWS/rz1xsnBcNQ/AdhFlfzpPcI0mUyxZfVaJQKH7UmR?=
 =?us-ascii?Q?vY+0qKqKPUnQeim79bafFxonTb2ihsVcOVJZzTp80sV8Z49Oy1I+K0AiY192?=
 =?us-ascii?Q?l87e8U+qw92FBCmI+s2VKKeX26QxQBhztNT+AUwWgx0/zJ8NU+9zOTjg2NiE?=
 =?us-ascii?Q?ISqeMEyiT6umiF4pBj/QNRFH1jVu3zy31O2fh0FcYgXfcNQiqXC68Pb/nkML?=
 =?us-ascii?Q?tXEEYrtEDV8fQz86Fc94487nMpTQ/k8LbPNOndvRYSLe4t6WENwsON/2XEbF?=
 =?us-ascii?Q?2HzMqRutSDm+orvE0pO/HRtzJVxjV/SSd6a6fUVzPFdoGc6G9KgNzkAlQGTI?=
 =?us-ascii?Q?una1toCfOXl6ddgQv/ToiCYTA5Eth8pcgg2L3euomH+nPN8RCDXkOxD324OQ?=
 =?us-ascii?Q?chhR9Dq9yZQ8rnXy5HvdjfLmTjozfY9Rn132+g1zEia7rkqjF6yzlHbfObMi?=
 =?us-ascii?Q?gp1gbylsydnkpPeSYdG4sy8ItzaMjv+sPd5tf37JkIoCF/szp3WS0VabfrCa?=
 =?us-ascii?Q?o9s0RT0dO95jFByTWeFSkqmnoLYcaf1m3wTgcVMWcAIDADHYDbSsXrC6RCPs?=
 =?us-ascii?Q?AnuUiNI+MjHeSJJ3pVOaud7eOyysQiRNsfbNcYEdnMOBFt3V5idwcknoHdsN?=
 =?us-ascii?Q?5pfWiogn/WzFFRSDXnTXYmrAaiH+JFc/GruydLk7hx/7PM5HTw0O?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 4704d96c-40e5-49a8-c78c-08df002fe2c9
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB2892.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 09:29:38.3863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efDIU33WeNF38Ly/SHsV5HvW0iOAnqkJyuJJWhLkG3t/bHTbhMa/tSNawdfN/VqHwNNeR8MHxrl6oPtkwCvqE27XGhEgwnnJhs0GE2dzIJZgicFMtpu8tqKE1AbGdGfq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1747

Enable and set the backup switch mode directly from the device tree at
probe, instead of requiring a userspace RTC_PARAM_BACKUP_SWITCH_MODE
ioctl on every unit.

Signed-off-by: Dhaval Shiroya <dhaval.shiroya@siliconsignals.io>

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index d96f6bb68850..5dde1aed76dd 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -80,6 +80,7 @@
 #define RV3028_EEBUSY_TIMEOUT		100000
 
 #define RV3028_BACKUP_TCE		BIT(5)
+#define RV3028_BACKUP_FEDE		BIT(4)
 #define RV3028_BACKUP_TCR_MASK		GENMASK(1,0)
 #define RV3028_BACKUP_BSM		GENMASK(3,2)
 
@@ -519,70 +520,6 @@ static int rv3028_set_offset(struct device *dev, long offset)
 
 }
 
-static int rv3028_param_get(struct device *dev, struct rtc_param *param)
-{
-	struct rv3028_data *rv3028 = dev_get_drvdata(dev);
-	int ret;
-	u32 value;
-
-	switch(param->param) {
-	case RTC_PARAM_BACKUP_SWITCH_MODE:
-		ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &value);
-		if (ret < 0)
-			return ret;
-
-		value = FIELD_GET(RV3028_BACKUP_BSM, value);
-
-		switch(value) {
-		case RV3028_BACKUP_BSM_DSM:
-			param->uvalue = RTC_BSM_DIRECT;
-			break;
-		case RV3028_BACKUP_BSM_LSM:
-			param->uvalue = RTC_BSM_LEVEL;
-			break;
-		default:
-			param->uvalue = RTC_BSM_DISABLED;
-		}
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int rv3028_param_set(struct device *dev, struct rtc_param *param)
-{
-	struct rv3028_data *rv3028 = dev_get_drvdata(dev);
-	u8 mode;
-
-	switch(param->param) {
-	case RTC_PARAM_BACKUP_SWITCH_MODE:
-		switch (param->uvalue) {
-		case RTC_BSM_DISABLED:
-			mode = 0;
-			break;
-		case RTC_BSM_DIRECT:
-			mode = RV3028_BACKUP_BSM_DSM;
-			break;
-		case RTC_BSM_LEVEL:
-			mode = RV3028_BACKUP_BSM_LSM;
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		return rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_BSM,
-					 FIELD_PREP(RV3028_BACKUP_BSM, mode));
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int rv3028_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 {
 	struct rv3028_data *rv3028 = dev_get_drvdata(dev);
@@ -852,8 +789,6 @@ static const struct rtc_class_ops rv3028_rtc_ops = {
 	.read_offset = rv3028_read_offset,
 	.set_offset = rv3028_set_offset,
 	.ioctl = rv3028_ioctl,
-	.param_get = rv3028_param_get,
-	.param_set = rv3028_param_set,
 };
 
 static const struct regmap_config regmap_config = {
@@ -920,6 +855,65 @@ static u8 rv3028_set_trickle_charger(struct rv3028_data *rv3028,
 	return ret;
 }
 
+/*
+ * Configure backup switchover mode from device tree.
+ *   0 = disabled
+ *   1 = DSM (Direct Switching Mode)  - switch when VDD < VBACKUP
+ *   3 = LSM (Level Switching Mode)   - switch when VDD < 2.0V
+ */
+static int rv3028_set_bsm_from_dt(struct rv3028_data *rv3028,
+				  struct i2c_client *client)
+{
+	u32 val_old, bsm_dt, bsm_bits;
+	int ret;
+
+	if (device_property_read_u32(&client->dev, "backup-switch-mode",
+				     &bsm_dt))
+		return 0;
+
+	/* Validate and convert DT value to register bits */
+	switch (bsm_dt) {
+	case 0:
+		bsm_bits = 0;
+		break;
+	case 1:
+		bsm_bits = FIELD_PREP(RV3028_BACKUP_BSM, RV3028_BACKUP_BSM_DSM);
+		break;
+	case 3:
+		bsm_bits = FIELD_PREP(RV3028_BACKUP_BSM, RV3028_BACKUP_BSM_LSM);
+		break;
+	default:
+		dev_warn(&client->dev,
+			 "invalid backup-switch-mode %u (use 0, 1, or 3)\n",
+			 bsm_dt);
+		return 0;
+	}
+
+	/* Read current BACKUP register */
+	ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &val_old);
+	if (ret < 0)
+		return ret;
+
+	/* Check if BSM and FEDE already match desired values */
+	if ((val_old & (RV3028_BACKUP_BSM | RV3028_BACKUP_FEDE)) ==
+	    (bsm_bits | RV3028_BACKUP_FEDE)) {
+		dev_dbg(&client->dev,
+			"backup switch mode already set to %u\n", bsm_dt);
+		return 0;
+	}
+
+	dev_info(&client->dev,
+		 "setting backup switch mode to %u (reg 0x37: 0x%02x -> 0x%02x)\n",
+		 bsm_dt, val_old,
+		 (val_old & ~(RV3028_BACKUP_BSM | RV3028_BACKUP_FEDE)) |
+		 bsm_bits | RV3028_BACKUP_FEDE);
+
+	/* Set BSM and always enable FEDE as recommended by datasheet */
+	return rv3028_update_cfg(rv3028, RV3028_BACKUP,
+				 RV3028_BACKUP_BSM | RV3028_BACKUP_FEDE,
+				 bsm_bits | RV3028_BACKUP_FEDE);
+}
+
 static int rv3028_probe(struct i2c_client *client)
 {
 	struct rv3028_data *rv3028;
@@ -1005,11 +999,14 @@ static int rv3028_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = rtc_add_group(rv3028->rtc, &rv3028_attr_group);
+	/* Configure backup switchover mode from device tree */
+	ret = rv3028_set_bsm_from_dt(rv3028, client);
 	if (ret)
 		return ret;
 
-	set_bit(RTC_FEATURE_BACKUP_SWITCH_MODE, rv3028->rtc->features);
+	ret = rtc_add_group(rv3028->rtc, &rv3028_attr_group);
+	if (ret)
+		return ret;
 
 	rv3028->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	rv3028->rtc->range_max = RTC_TIMESTAMP_END_2099;
-- 
2.34.1

