Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589521;
	b=N2x6h5xK9UizQlRvCB2oalW9PdjSFyei8Z4MYi0HW6xmwZ0A8S6fooqHrq46esH0FikZ
	 Vexee2+PIfmS/WoMDqb5Dh+6OWyndVdLrpwP1fD0wlnzOKcSvx4WTPakQagTHpWiz+i9P
	 QLb0nieP4e3RIGeX7VRh6qhMzZAdvRwL7F9qrEE73GnRaTRdhh8kunXslKTHgmPN+YyPi
	 BYfHZ4JmGg73/23yIsJ/C4154qPavKWPF1rLVg6GKqdD1KqEX1RjyZMtS1bgkITrb7Ywt
	 WQvdaMTPMCCPR0zp5K2s/xK5IqR7s2X4quLTFrAL0nS6lKYMpMgizhoOrgKV+MiS3KQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589521;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+4mING0Rex+jtkx55aNx+cqpDXz5klhmvjWXbUn/VKM=;
	b=FMvHF6e5+i2GE8CxAn9iWzKsf5+AAX/oNjwa6oo9tP08RevZNbDbfmxgCyXbE3UBtQ+b
	 nAN5qwdgdo2lixqhFeb/tJk0+K/k1a2Qn8wmjLR8yBHkFn1cB5Oknh3bQU8TRm7mLGIBx
	 yT/AKRQzgKj43mzI7phVvAAv8d3MWbjGc4W2m8deEj6cd8p078SH+HeFlmrDcj41Sj6cn
	 uSxJqAHUrPK71mV3LmgsPynInQqNhGyGPNdqkjCTvxaN4VV5YB5w90BdWEiEY5ru6o/Gh
	 LeijKhIDK6wrQ2+kXjLO8AJHPv+16QOUVTLJEvzG534NZBmXP3M0M4hkoGYIM2f7N/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=HpJ1SV1o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.5
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC2606A32E;
	Fri, 13 Nov 2026 17:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7EC2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=HpJ1SV1o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXwdT8ZsCKGH2vfZTuWVzWiNPv+XZxYns3s7waQSVLAlzSIQSbjTaH+I7RbInOmvtEZeIsd5crw3yRSCniAr/dljj3ehlBXcmYPHcOqvn4OstnCvgfB+mZeoVODxRzXiu1cHKDmBq2RJtAG5L+p9zZfP+m2svG3cWexnnGElmR6n2NrvHV8wRMu4xG05crLFxos0Z5C//HBPYYyD8+BLUvIWTloYMjvq44YahwjpNQcfxAHLz96cXHZApFkU4PttoZbXs/HobYPAqc3kYP0sHb5dxLuHsyQftNkgvZX2pbFhwihAH0I8EQzzAIpdI0FudS9zwDVIqbg0whSVU/J/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4mING0Rex+jtkx55aNx+cqpDXz5klhmvjWXbUn/VKM=;
 b=wf8rHCK60/8pFu4CifEYXqU4m/d9uTy5D3PhlhjEJGCFpP5cZUBQYh/Muc377/0P+xjGI0jjsIN03v8jHPILSXlplK94fmLZ9XA7QKowapTraNSzrtmL0fiVpiG41TIJOZpxzyoFoamuLJBsKkDuJFBZYOLBuwuhRx8rd7O9Ku2W8QRN6eqDP1si8r4aUouWwiy59DSQYFg/tV20TtTyK60w+VLAScbgctzK5mxt8O7ddq++VBQCsJ8pQxGSCpJe17zr6xzZiPJ26mpCDgn9lMltY0wDYCVCw1Frs4TtU3q2cKI3uXxQ/YagcSziZSOaarMhFlLBoSXF+X4LumUFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4mING0Rex+jtkx55aNx+cqpDXz5klhmvjWXbUn/VKM=;
 b=HpJ1SV1opH+W4CM6GMzW2yQXAr2wPX5rlPyXg2e73vPihgFY/OY1TEFGS+eTU12HsIb0shmkIxtY9/YqnxROYxdwCwP6iAgTNgMeFdHlqNmD+civH+inkn8xY38ILKjXzYcB7Ef9QSZrf8bz8On9VNLpbC0UCb2UV4WlPqwNUAA=
Received: from AS8P250CA0008.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::13)
 by AM7PR02MB6418.eurprd02.prod.outlook.com (2603:10a6:20b:1bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:05:16 +0000
Received: from ZR1PEPF0000E462.eurprd04.prod.outlook.com
 (2603:10a6:20b:330:cafe::36) by AS8P250CA0008.outlook.office365.com
 (2603:10a6:20b:330::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 17:05:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 ZR1PEPF0000E462.mail.protection.outlook.com (10.167.241.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 17:05:12 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 13 Nov
 2026 18:05:01 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add Epson RX8111 RTC driver
Message-ID: <9e4b67c34feb7a57ba2999b0600b4b44714aaa64.1794583440.git.waqar.hameed@axis.com>
Date: Fri, 13 Nov 2026 18:05:01 +0100
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E462:EE_|AM7PR02MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 5300f1c4-9988-420e-b3e6-08df41a847a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|261009223027099003|11063799006|261021135927099003|56012099006|10067099003|261102123227099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	eUR9b9j3Xk2uNG5TciCOnKHWy4Zds1DKYOMH0KmkdpXPIE14FKLIfZ8Zue6H9Uz8NYKcIlOS2Bwa06Y/ntzTvSlJHakjtqQcF7LED4qj9sWGZPlwoJ410FSWSvwwmNoUXPvMnumCScpFJ+EO0VGLyI7GpeXFwatQUaRfMh4IJME/EA340Th3Mcl4UUWgRO+dpSc+bLi21zI+emPyX+YtpB+GV5AVJrxNNErkBXjF4mbGT+5VdT3f48C6XC010tNN7T1P3lsm61gKC0EYiUz+ech1alGWw1dXKt2nExV4qEL8b+dZvDm9X7I4rCxT0krYjBtnlSDLgWDM3xe1d4ZUVhddTVozpCq8adbQzP9m0Ai6mdrofQlGNWOX0NPsUxZck9RnWAtPu3uGTD38cagMQhm8LsUzBKk8SXOYnc72AQlMu7nSh0VD48K0cBHr1lhLDlE2i0gCupeNLTZ5/WYaP47XjFmbnO08ft6tSrU4MK/dbjZTkrJldZkhW0IFDOyWyEiAgQJ/UKKY4b/wdrXl3rN4VXrPeXAnzoQpvSvsbCEQ19NFo+XTFmB4JIX9hXdWw0v16m3Tcx4BJNBC+RpoETQcyIIVERL9e+2mdLe2/GFBuxei6Fn1kGpmfzFZ9eglM6gW3hNTTG7aqlCZYbIOLWxlmggfX++xES3n4elB6LLewWVly/YP7MRjDBXFR3ZaFHinRjlD6uAM0hhRCMB9Yg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(261009223027099003)(11063799006)(261021135927099003)(56012099006)(10067099003)(261102123227099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uM4iCfoaw071x0dQN8SOKbk06ew8Q8Gv3x4URY5ZVmDox63o5lmgKkCUqJkKxOJhtOo4FVmSmyRB58Mm36QU8p9WBvr52KZ8KGy1jJktF+EdByhiX9YpnPxl85IjZiwLnfcW0tFuSvbnF1pJATIv/9Sl1xezH5pYSeweQpNx6tHmHeKjb8o1zQFWHVdaQXH9aMwwh0HlKfWzbJTLpj0hlfSsnra1cL1rffSYkMZp6qVvOFWicwGZCSvWNEkBcE09F9otG3uA+puWef3NSHgLmN0AVz3Wtrbo/XTn9aFtRRfKXrATiXhC3aYTmIH1/SAkN5GmPGs6oWyJo0o8FSeqfiU5I0BIGH6L9rIvacG1l3/69EVBELAemo51ZF1UtzDn+cIGqjQjTnp/ms2Gp6F8vmgEDsCg/ojFi5y9DUGTAbMIXn2Hf9CUCaRjHJ5+rf6s
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:05:12.1026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5300f1c4-9988-420e-b3e6-08df41a847a1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E462.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6418

Axis Communications has resources dedicated to maintain, test and review
this driver. Thus, add myself and the company kernel mailing list to
help out with this.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7070cf5dbfe98..520438faa8dbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9998,6 +9998,13 @@ L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/tty/ehv_bytechan.c
 
+EPSON RX8111 RTC DRIVER
+M:	Waqar Hameed <waqar.hameed@axis.com>
+L:	linux-rtc@vger.kernel.org
+L:	kernel@axis.com
+S:	Supported
+F:	drivers/rtc/rtc-rx8111.c
+
 EPSON S1D13XXX FRAMEBUFFER DRIVER
 M:	Kristoffer Ericson <kristoffer.ericson@gmail.com>
 S:	Maintained

base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
-- 
2.43.0

