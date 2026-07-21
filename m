Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C2644BC87;
	Tue, 21 Jul 2026 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621959; cv=fail; b=VhtKNROMgnONAp1Oz5zu7384ck+gosaFYnEbytkAIUDcD9/poeWPrKhVrtX89+Nql7PvARVOmLr0U2wdwcXIFwI/OfCvePz2y+duZ957v9zNan50OuUhRlSXSsIC0cLGD1NnuTFBWZpULRYGpolGcmxjALbGYuzPlKz/RsDHro0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621959; c=relaxed/simple;
	bh=XajB2KXsSJRqIXjKCHNq7Z0j6iSN4tMOpiEnJ2o8urw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kc5FO/TmxYsPj9BPAU1Oj/qmwznU2ltpgxxZ4VOvfNk6ZncUqSB/5M1p0AdU0d0KwSejvp4zx4oBbxfKaiDrTfzgsV92j3nu41mCAsZFhaYkKcoPB/erWPv3HSCQ8zhO0dFsfzvT5iwNe6c/Q9G7ugH5uKoLxK4uWZWyPHuz0Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=VY26Z76V; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="VY26Z76V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNS+Plli+DKbe2o6Bg/RISksecjLWGFxfI25/SgR6XLbIGn4DEkowtzFHTavWW76Ym8ofaV3O+lDDHcn2OeUPmDfJEq4/XLB2w43vtGDeco87P3qxZHoLJ0UPhJFxzvJom7Y5YADUhYMnCXLv1psjO+PvOFtTwOxXj68cZQiTXk7kERpaCgALI2sOb4On4ksaEgBDj62YeBzYGubOy/hjFgYhF9tmrfuzmmt0L2PDvNutW7FqBP2OFtlOwoAa6SZKKb0fCGYRVUbOSh95NsuPa5/khJovS0oyjbk10+mGu1f/rkCsFpQV+q6L0vySS/dxr6p/RROPJ2/WhhCu7YLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLbpv5wd6takm/ZK8zru7LUrJG/OEQHA1N5xFdE+0hI=;
 b=IacBYDC61T4rhSQlyzZTJarZLJsEcYbo3bQWF0Uaiop+Ikj9+BRI5N9prjZpInte5sjO7pRsZH94p8lxm9ZO1Tus2KujKLv13Wsbtm1aFhoCIRhmMuPAVdPFkESIqUJFCQoCjIrXfbwKZ1U9nEj8tmP9C86i+5RERk+FE6E9izX4Vods3IM3zvrQAlPOPW6QvDhxnj2mlsrMmGFmsDAu19LD56DYcYSc7LvCyIf4cR/Ba6qwdHsjDmZuMIJZV28cpsZceedzpa9VhV92Yx09e3+fy8q3nk/mMGNYEt+jQs2DxXjRHrHySXwHvGCtHM6tG85TKeV1EoNV4sPCw4Rwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLbpv5wd6takm/ZK8zru7LUrJG/OEQHA1N5xFdE+0hI=;
 b=VY26Z76V/mcI70nFTXL4eNack8a8Qll9y8FQBWGUOGrHJwd2wmf0BjzE/GkVsrPuEoCxytW6VsmUAMkE3xADH+PV6aGjh0EnHHAIMAqoYR86Ci7Oy7w2DQRDmFALlbIOoaC+w2WCe6sP1rg1tGZ7rnzriQWxJQRDOESLvo6rxk0=
Received: from DU2PR04CA0190.eurprd04.prod.outlook.com (2603:10a6:10:28d::15)
 by VI1PR06MB6509.eurprd06.prod.outlook.com (2603:10a6:800:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 08:19:11 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::1c) by DU2PR04CA0190.outlook.office365.com
 (2603:10a6:10:28d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Tue,
 21 Jul 2026 08:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.99) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 08:19:10 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.61.228.61]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Tue, 21 Jul 2026 10:19:10 +0200
From: Robert Leussler <robert.leussler@leica-geosystems.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Robert Leussler <robert.leussler@leica-geosystems.com>
Subject: [PATCH] rtc: ds1307: fix RX8130 wakeup alarm WADA bit for day-of-month mode
Date: Tue, 21 Jul 2026 08:19:07 +0000
Message-ID: <20260721081907.3518648-1-robert.leussler@leica-geosystems.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Jul 2026 08:19:10.0368 (UTC) FILETIME=[9B583A00:01DD18E9]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DE:EE_|VI1PR06MB6509:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf37933c-d0a8-4464-c686-08dee700be14
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	p2zH27tmGr/zicYRAWoTh7fP7sy+mjoSS5hxqwyshls4n1cTFR+aSB3XE8trWulaeoQBA+kweLfPSxXeAy0J1RgoqTyRk0FI3twurqQ0+KucJCmyVCJSPnp5LswPablnOsiNTwqv8L6cQSAyRiv1UbDvoz0MFCYi+u9SB1MENF1mNkftvec1At2QUM+LmfN1GVZuVv09SbV9wBUorBXlbE3lEG6WPAoXvZJhAcZmwaX4Rkk6lFfT60VxuXkvXseeNoV6LU8Xpjucq2Z3rZnIq0gD5a1wvSOPHGPSrrseZ2qjp77I4fgYpwkoRO7tzahDvrljKcfLg6CULVtWXw+UbBup7ussC9TJ23fIz2Aq819Cj5feS0GeE3kDQprmZoJkfL2ou3tTFb69zMr2xy5Ycpnz9PUw2MrnrfJZ3hNTpFfltZWn7HtKqbOXsFeLIZZyGumsAb03EpsgTgzOGj2DM/ftyNRxKAXo8AiE58Al8MvH18n3tsm0tO8+NccsfhBRvGyfgFMj0bLf17WAIBy7tyx1qQSnn3sX1EcNb0TpGMWZgtjdy0qiE+2uh+D49vnN2j+hEx5PVea+RbUBGk6lYpWs1UX1Oat0A1h0S7DOZ3GRncZ8tJ6T0v2u6Ho1lorKuYyedKtMiY199SC+dIiY7c1N8jRlvHpGoLmDs5fo3bPLMUbulqSnd5VL4/ZZdhUqW3u2HWOUg7us+ZhGJBLyyg==
X-Forefront-Antispam-Report:
	CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lAScvBrSEFtgNydpLGiB7G1JLaFEvw85W9UCrnBxAewkskl4kBINq969IKwGT54rFQrOLMqoBFgj7DFD3YDtlstomoz6yKlaxYcAN8zVrExBXBWtt7ZZtK3Bp/beXEM8GpAOPKKap+o8lGMcyP2TLou2nfI1bNbf//+agSvvOCn8K+XUC5H6gw9IySfjQpLSoND7fceD9sYUaf6uJ2QYKZ3BTU3iQsMP2t/2VFlOgcLa6bu52wu/OcY2QBnGZmsJCs+a8/UEH7UW6plmrr/cPypCk1oND+mWlSBwea9EJWPLXviNZnxYydG3pPDFUP30r8g0AORZsMqVMbbPhWICwuTcUCTrFBKzgO39tOApzjaowqdgTQQSVOE/oUvRlRlyvJhkdaTG234S3M76ExS4v7FfiSGQdoW5rB4D3mYOvug+bQoP4CS5sSDzNh0ry7t3
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:19:10.6735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf37933c-d0a8-4464-c686-08dee700be14
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6509

The RX8130 wakeup alarm never fired when set via
/sys/class/rtc/rtc0/wakealarm. The root cause is that the WADA bit
(bit 3) in the Extension register (0x1c) was never set before
programming the alarm registers.

Per the RX8130 datasheet:
WADA=0 - Week alarm: register 0x19 is compared against day-of-week
WADA=1 - Day alarm:  register 0x19 is compared against day-of-month

rx8130_set_alarm() always writes a BCD day-of-month value to alarm
register 0x19, so WADA must be 1. With WADA=0 the hardware matched the
day-of-month value (e.g. 15) as a day-of-week index, which is always
out of range (valid weekdays are 0-6), so the alarm interrupt was never
asserted.

Fix by setting the WADA bit in rx8130_set_alarm() before writing the
Extension register back to the device.

This is consistent with rx8130_read_alarm(), which decodes the same
register under the same assumption (24-hour and day-of-month mode).


Signed-off-by: Robert Leussler <robert.leussler@leica-geosystems.com>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 1960d1bd851c..3631f0894d55 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -656,7 +656,7 @@ static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	if (ret < 0)
 		return ret;
 
-	ctl[0] &= RX8130_REG_EXTENSION_WADA;
+	ctl[0] |= RX8130_REG_EXTENSION_WADA;
 	ctl[1] &= ~RX8130_REG_FLAG_AF;
 	ctl[2] &= ~RX8130_REG_CONTROL0_AIE;
 
-- 
2.43.0

