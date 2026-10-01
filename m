Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CF343CE51;
	Thu,  1 Oct 2026 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833316; cv=fail; b=M55TLqSSPSHzk9YN4QcApNakg39sLhhCI5WVPHAVNKqh5WwBQ0IjuUe6IbGhygOiUZggJstKnmbyL/59lI9JGGHCIQkbz/SC8zvs8bh4pwBOF5NOOXviI+ou4sPPz1uY08f8V7wBDeBXuKUobQvL6cALIOs9CK+xsWglThVDAYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833316; c=relaxed/simple;
	bh=s9s/J4GFY3piGI5PjWQ0YiirNuSCxyZic2pFUOEzJl0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UKPZd3+q573g+LebejWV6ms+AuTrBr6NULlj236GGXuBea9e89/vspDd83ziWeaSuYWgK3tx5/1832eYjnh9K9VGSeOb7R2EiDgJm4kBLMtpASYZT0tRh3YcvlxUJAgpI8plLYxriIR3luafb8nhqrwyblqselzEj3v8PmbmBKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V2o0Utxy; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V2o0Utxy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCrjUZGagR0IXGzNh/wppGhOo9pKnb/h+6c3NnZCSXqjrlf/fj8B7h7+E0ILt2ybHIWE3tji96r7B7GuoB4e9MpuHpW6kb1729KFAEEq4Kqz04VcNRTDxT7ucVt+E2jPlMqgyXhJZ5QUvRzH4ajfTegaa3GhIIkd/UfEapctC+w7PT2Btc3nkMCBlUDCxvSNpwlWVKGXzpOH5R6harJdqDog6f3mGh2HdSBjzj8K/4mpVyBy+qw7t5L0qrrjivxC+jq3iYrUApskS7y8hpv7jHz5WxEqx5b9RaMU+ZfeloOTE768ZlqZdeoKN/vhTkOXLNCiYFt7duhmnho3jUvwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJX/IIDatUwDWbLL8lPXMIqB7re171eFJrVK5B7brD4=;
 b=Kts5wjUpIl7sHXHquMbQgQtSsJzGpuByTGBm2OQIXFcH08F5H0Sy2PtCIQ9W3W1Ahnru37QeXXnT58lyxfhB64ocp92y5gEv0LfOGenACYpE6zxOQd0rReNv812GG26A91EO97eB5QdTuMnh1frxWa7OPv4w38wWQ+25/6hQIvTn0L3tK2Fr62DQRT0Q4Kj//Bk82OpyXNDDqjWbYOBaglWWhRsziXms+EhkgxaRnvsequVq+S1zd4iBN11yRCTlCtotnU5Aya24UqlCuQ5JaH99LRMVvucZHZzA7jW4w+AsE5lt4FSJK0ipGce/yr3+MuzTLv5tKO1TtLseUJP2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=bootlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJX/IIDatUwDWbLL8lPXMIqB7re171eFJrVK5B7brD4=;
 b=V2o0UtxyXN6JEuzhx9fa83geSGhDtr1vv3DShmUzsttKsil9S0jRUp+FsriK+fiLCe/FxYR7HK0BWVzO3Z6LMsARkXilyhAMVHPclGYMYsTS7umPjo3U6s5tF6GZMQARn9l3sMc2Wy+HbS07ddHKlGrb761+rBLxfQfUPMxgqprBKgL9MZ4qCetkkjWmRmbfiaD+rF8kPvfjNTUhH5yQJDXTR+0DmytukuavMf8ovAYJ0YGN4tQEpqWXBKAzJVdh/48gjs6NpipNX3LqWHAC4gGzkX9ciYLQX0flQnpR2ld7l9m8f2LqqF1YcSaPEa2KljRfBVOnhc7avzNnzXIkvA==
Received: from BN9PR03CA0843.namprd03.prod.outlook.com (2603:10b6:408:13d::8)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 05:41:47 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::ab) by BN9PR03CA0843.outlook.office365.com
 (2603:10b6:408:13d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 05:41:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 05:41:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 22:41:29 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 22:41:26 -0700
From: Eric Liu <liuer@nvidia.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Andrew Jeffery <andrew@codeconstruct.com.au>, Avi Fishman
	<avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, Tali Perry
	<tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, Nancy Yuen
	<yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, Guenter Roeck
	<linux@roeck-us.net>, Mia Lin <mimi05633@gmail.com>, Medad CChien
	<ctcchien@nuvoton.com>, <linux-rtc@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] rtc: nct3018y: report chassis intrusion through hwmon
Date: Thu, 1 Oct 2026 14:41:08 +0900
Message-ID: <20261001054108.3346426-1-liuer@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 077bf834-b707-499b-01f8-08df1f7eae62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Mr34hananBsdYQSa7EsunekHG7xMXyfaVmmZ0cIew+VT+rNWtHpyDy7WXyI6SmVkuawDLzlRNtq8DUrRqQ1RU9SoXrkzWB6JFxa75NnTDFjNTJ9nzbJrTkrFMwPdvtmlWqWsdv3m0I+MQ4235xYij+f6ygBbbWBVYDpp4HQMvRGQ6e65BtyyzP/U3xqVq294TeqWqUc2eIlDALh7IQxz9ecGyz8HFiA2XKShPP2NlMBN7tKsJDsATVTfHM0Cl5ufnqTA2DnbaI+ReV7nl/EyFgbpF/1ex3qVzb+KOrZW2sLLZmw/rQYbJt58Bsnb78x28m6/XWUlkZoxVqJtVK9jk2bfHAP5s4ByBdPltGrgPECWEcWAJwNSbtNoiQFzucsWbfaMvRqijx+av+iOk8ekDZPVz0IxTnv/7P8pqldCACtUs9lP/rbyYnrNeNQULdgsdkxJIvcjqF6fx3BC6YZhRJdxdERLsQMttY/mtBV13KtpJdRnUwq0uYYyRvqBC41QwbxtQAb8fVZiXTvM3UItTDkSQEaZXizhUzt6YN6VNmqFzWtXbXEHXjMTMT8iSQ2/zDWJwB9Vr9U5ZrMiH3mX7MMwocRmMQpgqJ8adclsABgPuat/zYa1UY6AHf+BIAxOALuVmnUD5zAaW/scQpB7nrOn2+Mv1bXN2FKhp0TmUs1Pzv4cRCBR95xRxc9LgYrhZAIWUg6VUXD8gWfAGSXS8Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2R26rMh6KZVuNcMBximhYrcr/mcBkVLpRYstRJ9+8oyV2+BL2IxihIVxhJ19B1JDfzfGa5DaRrdC9MrILlxPcL2LDpEfpVkCxFq1dgk/eJUYj6Kl+yr/mFLdylRlwGM8PdtHcIAfQDW6TPyl8mrDEge09cDyh14RRuQrzofntI9aBB30+17EIWWEVvGM5r4n6cTTJ5F/kfP4+aOW2Q6mrWl1TRI187Yp0eTzb/oJ1cAP80D2yEPnckhCsPwux+kkWh0wJnxoINY/f5NtFbC16qshFMqLY5E3sM5M6YxNh/btzAp8ulAQus3NLEEvNaYxhtS7oo7BpStYb5UimSXb+N09uyNqIZBzWAiHsoAxVI8KPosDB/g2d/QEC2PiUZa1liwH0LVDW4j1R636ELhqb3t6qg8IKsoNtGeBS8sRWISOvPr43yN+hZqEKnE+0hDb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 05:41:45.9864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 077bf834-b707-499b-01f8-08df1f7eae62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999

Add an hwmon intrusion alarm for the chip's chassis intrusion latch.
Reading it says whether the chassis has been opened since the latch was
last cleared; writing 0 clears it and re-arms.

Signed-off-by: Eric Liu <liuer@nvidia.com>
---
Tested on an NVIDIA Vera Rubin NVL BMC (Aspeed AST2600, kernel 6.18.47)
with an NCT3018Y on i2c5 at 0x6f, opening and closing the chassis by hand.

  # cd /sys/class/hwmon/hwmon0
  # cat name
  nct3018y

lid open:

  # cat intrusion0_alarm
  1

a non-zero write is rejected:

  # echo 1 > intrusion0_alarm
  sh: echo: write error: Invalid argument
  # cat intrusion0_alarm
  1

lid closed -- the latch is held, closing the chassis does not clear it:

  # cat intrusion0_alarm
  1

cleared through the driver:

  # echo 0 > intrusion0_alarm
  # cat intrusion0_alarm
  0

lid opened again, re-armed:

  # cat intrusion0_alarm
  1

Note the latch can only be cleared while the chassis is closed: the flag is
set on "POR or INTRUDER# asserted", so with the lid open the hardware sets
it again immediately after the write.

Build-tested for arm with W=1 and no new warnings, for CONFIG_HWMON=y, =m
and =n.

 drivers/rtc/rtc-nct3018y.c | 94 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index 2f7ad57057a4..194ba077363a 100644
--- a/drivers/rtc/rtc-nct3018y.c
+++ b/drivers/rtc/rtc-nct3018y.c
@@ -4,6 +4,7 @@
 #include <linux/bcd.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/hwmon.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -23,6 +24,7 @@
 #define NCT3018Y_REG_CTRL	0x0A /* timer control */
 #define NCT3018Y_REG_ST		0x0B /* status */
 #define NCT3018Y_REG_CLKO	0x0C /* clock out */
+#define NCT3018Y_REG_INTR_CTRL	0x12 /* intrusion control */
 #define NCT3018Y_REG_PART	0x21 /* part info */
 
 #define NCT3018Y_BIT_AF		BIT(7)
@@ -34,6 +36,7 @@
 #define NCT3018Y_BIT_OFIE	BIT(2)
 #define NCT3018Y_BIT_CIE	BIT(1)
 #define NCT3018Y_BIT_TWO	BIT(0)
+#define NCT3018Y_BIT_INTRUSION	BIT(1) /* in NCT3018Y_REG_INTR_CTRL */
 
 #define NCT3018Y_REG_BAT_MASK		0x07
 #define NCT3018Y_REG_CLKO_F_MASK	0x03 /* frequenc mask */
@@ -491,6 +494,95 @@ static const struct rtc_class_ops nct3018y_rtc_ops = {
 	.ioctl		= nct3018y_ioctl,
 };
 
+#if IS_REACHABLE(CONFIG_HWMON)
+
+static umode_t nct3018y_hwmon_is_visible(const void *data,
+					 enum hwmon_sensor_types type,
+					 u32 attr, int channel)
+{
+	if (type == hwmon_intrusion && attr == hwmon_intrusion_alarm)
+		return 0644;
+
+	return 0;
+}
+
+static int nct3018y_hwmon_read(struct device *dev,
+			       enum hwmon_sensor_types type, u32 attr,
+			       int channel, long *val)
+{
+	struct nct3018y *nct3018y = dev_get_drvdata(dev);
+	int flags;
+
+	flags = i2c_smbus_read_byte_data(nct3018y->client,
+					 NCT3018Y_REG_INTR_CTRL);
+	if (flags < 0)
+		return flags;
+
+	*val = !!(flags & NCT3018Y_BIT_INTRUSION);
+
+	return 0;
+}
+
+static int nct3018y_hwmon_write(struct device *dev,
+				enum hwmon_sensor_types type, u32 attr,
+				int channel, long val)
+{
+	struct nct3018y *nct3018y = dev_get_drvdata(dev);
+	int flags;
+
+	/* The alarm latches until it is cleared, and only clearing is a
+	 * meaningful thing to ask for.
+	 */
+	if (val)
+		return -EINVAL;
+
+	flags = i2c_smbus_read_byte_data(nct3018y->client,
+					 NCT3018Y_REG_INTR_CTRL);
+	if (flags < 0)
+		return flags;
+
+	return i2c_smbus_write_byte_data(nct3018y->client,
+					 NCT3018Y_REG_INTR_CTRL,
+					 flags & ~NCT3018Y_BIT_INTRUSION);
+}
+
+static const struct hwmon_channel_info * const nct3018y_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(intrusion, HWMON_INTRUSION_ALARM),
+	NULL
+};
+
+static const struct hwmon_ops nct3018y_hwmon_ops = {
+	.is_visible = nct3018y_hwmon_is_visible,
+	.read = nct3018y_hwmon_read,
+	.write = nct3018y_hwmon_write,
+};
+
+static const struct hwmon_chip_info nct3018y_hwmon_chip_info = {
+	.ops = &nct3018y_hwmon_ops,
+	.info = nct3018y_hwmon_info,
+};
+
+static void nct3018y_hwmon_register(struct nct3018y *nct3018y)
+{
+	struct device *dev;
+
+	dev = devm_hwmon_device_register_with_info(&nct3018y->client->dev,
+						   "nct3018y", nct3018y,
+						   &nct3018y_hwmon_chip_info,
+						   NULL);
+	if (IS_ERR(dev))
+		dev_warn(&nct3018y->client->dev,
+			 "unable to register hwmon device %ld\n", PTR_ERR(dev));
+}
+
+#else
+
+static void nct3018y_hwmon_register(struct nct3018y *nct3018y)
+{
+}
+
+#endif /* IS_REACHABLE(CONFIG_HWMON) */
+
 static int nct3018y_probe(struct i2c_client *client)
 {
 	struct nct3018y *nct3018y;
@@ -568,6 +660,8 @@ static int nct3018y_probe(struct i2c_client *client)
 	nct3018y_clkout_register_clk(nct3018y);
 #endif
 
+	nct3018y_hwmon_register(nct3018y);
+
 	return devm_rtc_register_device(nct3018y->rtc);
 }
 
-- 
2.34.1

