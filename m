Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB93430CE4;
	Tue,  4 Aug 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854887; cv=fail; b=Pu6gd+H8tPKc/j/6EY/Zrt6tqlBsXHlH5eZNVx9yaaJgN4I16e0TqGBQpTxaia1l6maw0ekv2G0NAt1Yw71bASP62vZLZ6PWm9k2Xt++SXVwOOVU95c7XSm0iW3/WUujFPn6DzD/4x6qBAMalZUxUScRyJ0PIQR6MemIJW4ChIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854887; c=relaxed/simple;
	bh=Cgv9be7kdHtGiWWVBxKv+Ua5u8GPtZwuUQkzVhR0A8I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NkxQF8BZZXuyWSLo8K0CNlghpChogbEBkcXe2UQfaDITYne2Es7FLAuOYbzIWorYuvbjO69vBJ9R9exMlspnm+y3ov0HaWpoB6sCuXp11H3X8vysrc8lQ/Sc2HFH/sn/owI99WFqSrofFtLZIjmw0tsI3z2cCfLm07rUz1enNDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lzXDGNaW; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lzXDGNaW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miROngjo4TZK25+VlIauvUvY/w8XmUZoVaVuH+RFHvQpXIsGVJx6RXuNZqIVIOPJbaInF15LFE5MzzfMZJLZvTyVXG1sA3EAsxqwPwS9aapSeVtBHOK75isx8vMnDtAb53X+ABI/ZNV+uF4wqz5NQvThdy8WFJ+zvPWgEtVntCr/mzAqaVRoBLbuagAo0cLAU04t8/aqEe5GpnFTongppGs7wMOnL6OAySH9U1rClVCqSoddcapDItld4M718crjqk4nEhgbt6JXmha9uBoUFi4P2qY7FNjtqepM2r7RJbhvMR54ls7rsH0YFIe+OioUTl98BjTKbd7afMXcu+ue4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YqgQ/eR9GpMVIxE7khoRZK7EUTxLCwJp8x1zhdwjaM=;
 b=jAw29+8GZn/D9TfMzEU98FzYEQza8yQtroVe7seDhX6Z+1Bul853BEDxutVvg1+y6z8BkTAHfvKuTnZfkjEsEn1dKBee0o+wX3JFyFvwOnSIh0PWhE9xhM7y5ijpvgqYAeRXSlLbZLOHyRq/qV+ja8qxkXdwaaCOmgR/igD23PGpaLovB1RRwOSyKdvyioVKvVtgGAkVSl3CUFvYfl0/8eqXJg182gHkZOztxj/un9NRGOqN8KLINzcxUd6PXs1NtZ/h2iLsN2fEaanzdLA5giFOgaaHowBVRuT7DW+6sCPDPBV+sfIPQuzZDaiIE841juvVGp1E/6Zyy/8klWuiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YqgQ/eR9GpMVIxE7khoRZK7EUTxLCwJp8x1zhdwjaM=;
 b=lzXDGNaW7keguA58uVasX3in9GIB0QiuFsGyjoexOu7bGCzyg+z/RhOwr//Lp5ctkoDwDBf0FXzX4hMlHGPXSSVllzbb3lPLCoxjNsfTxmh4Bnb2l7bGL0v/1CK1TDVlvqT3G7N5OCVynIbqmKhP65FVBLkgFPdZ6u+GbFLEfTIK7RxY62uMMz9O4ICazklwof/1uR/w9n9GygY6LsFAQBDCqmDYaPnqGCWzfyppx0W2OFIBY2hwNapVuvfUlzFuqXiCLWslkrnZuHlntYKktbKhqrsneJHx8+dS4Ycx4qxbJvKyLlLL3rrjpR+HLlDQew31EIxFC3X5SPeb6aPxzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB8980.eurprd04.prod.outlook.com (2603:10a6:20b:42f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 14:47:59 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 14:47:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	rzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul@crapouillou.net,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: rtc: ingenic,rtc: Use generic power-controller schema
Date: Tue,  4 Aug 2026 22:45:53 +0800
Message-ID: <20260804144553.2518722-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb98224-2fc1-47b3-8e83-08def23760bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|23010399003|11063799006|3023799007|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	j5cVxTwwom3nvj7OV9hrlIewQOKRRvIFBlceMtSAXPQahfbLBRrq1WvMreTxqXJzm2aLjIQLdAlMHnndmB+Lv84jB/fl8F4XK4ugRsEyUEkZ/iklNTEcE7uCgqLP02iHH+g1OoGC9q4AyejElEBm30hbZulIz0rKEakV4qj6kdR9kVzssaj2cayHqfBmCd5ZkUTUOofotvzg+gwDOWXP+0/OkHCgkCjM616lVgW6gZqqIEIavc+Jg6cA3PqybCfPl/qOK3+7jYuLxbDhDKolUKAvmsv/GiiET7PTQ4smV9mj0L4VMe6xOv8fsZG3P8k5p1lRvAHYDXa4bcw/A1Qa/YmviryMyPfYlVaWlcV44JLMWyvakogXU/GcZGNzr/Zz46z4KyidVjDRf7zyY9Pkop2Ha839FgM1XJ6Np/jyabQ9MxM3wJrIfM9LYIDK7t25SEOLoxa8PzlS6+zGIzzcbi2KLdmAQRz2ZmIWXlUQo0qrTNfsc91vkXIrOM66BrKjYj18cRdLFLJKidS7mx6p8R951MPZsj8ibtjGgZdACFHETDa/Lfb/dtFf7754qUOwvaVvyLzX2zVxVBUNUszv3/R6b4oANvCaft1wioIlmSLxBERuVN8SjJNr/8M+sFGOHXTaLgCqPMYUdDs7yUy+al4v0Bt6MX6wDMB9kFKrHfA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(23010399003)(11063799006)(3023799007)(56012099006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i/JmO+JOlQNMPy/PSkVsqMhD2YHI04xW8ZDykk7O0fl83gJOKfgcPvjbLERa?=
 =?us-ascii?Q?9SJDFx8QHnBjzAYuNP0sPnZvzFEkOGJjdrKHr1opVrrMReXhjFhJJVRkXlEm?=
 =?us-ascii?Q?A0QHllvomWTJ+pHpBnqNk86VuLGO0guGU/Z0qixcYp/EOsN3tw7ta9wpwb0S?=
 =?us-ascii?Q?K+TFnU3paqcPQtO0+QaB3G4l8F0EwPcAqNNKHFtSBhkGxVYy9S6KqaX3cufe?=
 =?us-ascii?Q?QJat2BcpSGdNPWmwjowvLS1lPI3tfw0pU+M0u88jvUfqdwoo2+ljLeYy6a30?=
 =?us-ascii?Q?1VEOfkOGGYe0eJIQdOhmHOES7kyc35wKmrsoCss9AYU96RM2gYqiOvJvHLUz?=
 =?us-ascii?Q?eWcJNmVBsOnNrqshHq0yiyVlsYP6s3A+GQh+IMwXAP0EFpEIPO4z2eKRHkiR?=
 =?us-ascii?Q?qCMdVdwrJpCvN/MKgyipbgnyHrRVStEbrMvRzpJV8QgxRwdMa/Wcef8IR1Oa?=
 =?us-ascii?Q?dIZE7vbn3aAZhQVkuITHvkMEGUy5HC99WKo7fh4gTWH58A3GaybqsgEhSCZK?=
 =?us-ascii?Q?jGdIrywPxrKBFMVipPCgI+w/ndUXohhzljRIeK7dkKraNrEVH+9uqe5b/oCf?=
 =?us-ascii?Q?KxSLTqldAVskXgK3ULfPHb1UGnE8j10dxDeQKlBHxQSJTALcZSIQFv+qMAfJ?=
 =?us-ascii?Q?g+XILUVQAM5LCqqgRX+lGD1bImHO+dh0d1l/UfzVG+DddYTY/iozdfWyUHpd?=
 =?us-ascii?Q?vZRU1vUvOBbhWwCK1qoNwYVwR1cciA6mwumyAN+hsZqKOEr+NvueGBe2fxeU?=
 =?us-ascii?Q?XDKKrFsyYJPGklbyBQZaI9jiSD41/9rz5p/mtF/LYMfhVcdSeDR3BBFljvdi?=
 =?us-ascii?Q?pQp0/TlqRIMyv1uU33kR+xhl9O+dX7odXHHdUHloOP7yjX5jFF3nXkjS9PIu?=
 =?us-ascii?Q?sivPSMlwelzVa5rNTFph+Su6/AswyTSDuvimGXQSp8nGhcSU6Ky7y+MdEPru?=
 =?us-ascii?Q?qOF2xt5GWJRzF9fkEP9n0szegE2IKqu5MC8busnKiVMcdr1FIztNTNlFCaMZ?=
 =?us-ascii?Q?bp+09bFED3H6jQYWp0MKHGG43uyR1L5n4E1FQhQQSU9g3cz94PnAytjMytgB?=
 =?us-ascii?Q?dtTAKrDrjIKeQFFvgVzvEgwk8Tt5vRA45X7X45QozSJTFefRS7xSroSXcgWA?=
 =?us-ascii?Q?S6Gfn9gIVh8N3fOP3uVw/lX6aSvVhqnmDvFvnL61+nn6H6eF2vN2tCyblrWl?=
 =?us-ascii?Q?UdMs41+bZNoOkmpHyHiG8N9UkTYsJ/YcRFNDt9NCWB3mDYTTgUgTqTvOfY85?=
 =?us-ascii?Q?qtHbflJ25znY3u3TbMUIldKJpevOSu+Xiaoecp1SZbGhvpmGgGHzkjr2sPqA?=
 =?us-ascii?Q?VXErNMSj/VixNhlCH5O7Tm+0/EdLBsKl10WGi7SJL4ZYZJhNcjCtzZ3x0Th0?=
 =?us-ascii?Q?QI3IBaVES8eI1wnuu2q9sj8HERdqwnYVkjzZmS8gqAzi6x0DPAZ3xjGLMQ9v?=
 =?us-ascii?Q?PZhS8S5rIjKEpTlhqcMBqGiqB7BDFaBkwAa1HeSj6FJry7JdaVpIxazKokZL?=
 =?us-ascii?Q?FvUGre/rWq8g+IUElwy+4rO8lxTsBxb6i4cs3hOSRI5V3vyuxgHn4hr2dEWj?=
 =?us-ascii?Q?XmjBEHKtni/kTFoLQabnqLw5P5DoJz2+55eUjUY1dHhGfe+bm5J3NbKQMN+q?=
 =?us-ascii?Q?KESYJPfceeh93h6G+EbQIOh6yOfdY283XLwn6nmA/+8egBzjQI6h5dA7N1Rs?=
 =?us-ascii?Q?qkmfEP/DwAqXjz69TCXXua7f/AHrw9DVzqFH9F5gEX+YqZgkpZtn5/aBl+6i?=
 =?us-ascii?Q?RTxhLMNyUuUiBx9vPWBR2uJfY/lSfvTG6weJrn4XO8hHMs5g+T3K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb98224-2fc1-47b3-8e83-08def23760bc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:47:59.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQeHrUl4HKBh76yFHbTX8jwTIEff6dmSBNY24qsW3VNoTIDYMfMuLdzZUhl5SH9GYCLV9H82geZJx1l7Qd0IvcbmBzozI2QHLQeGupg1ZGi5nTfIOgmb8SrY35uub2iI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8980

From: Peng Fan <peng.fan@nxp.com>

Convert the binding to use the generic power-controller schema instead by
referencing power-controller.yaml and removing the local
`system-power-controller` property definition.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 The power-controller.yaml has been merged in dt-schema, so
 resend this patch picked from link [1]. A-b tag is kept, since
 no changes.
 [1] https://lore.kernel.org/all/20260316-power-controller-v1-5-92c80e5e1744@nxp.com/

 Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml b/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
index de9879bdb317..415566d8dba5 100644
--- a/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: rtc.yaml#
+  - $ref: /schemas/power/power-controller.yaml#
   - if:
       not:
         properties:
@@ -53,12 +54,6 @@ properties:
   "#clock-cells":
     const: 0
 
-  system-power-controller:
-    description: |
-      Indicates that the RTC is responsible for powering OFF
-      the system.
-    type: boolean
-
   ingenic,reset-pin-assert-time-ms:
     minimum: 0
     maximum: 125
-- 
2.51.0

