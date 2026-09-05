Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012011.outbound.protection.outlook.com [52.103.32.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA104337688;
	Sat,  5 Sep 2026 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788641157; cv=fail; b=G4b0DCaM72LSK7H4Efzx98yx0y4TCo+QzCnHN3BVJuW4MRivOKZnQcoCTmIdfTjppWbbYQgjMPgpOTY3lqMM2hHtiBUidJwCtzdX5phAZsq+IDlp9sqbsbz3rcUWkndtqZ2pY3x1g2S3M+ubgG4M8cafB/cWZ3dteFcifcA277E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788641157; c=relaxed/simple;
	bh=Laa+Ra4X3+a/WDeK/QCOMom0dqiQTSYAsNcpoFSl8GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U6oZ6fpkya5uZuY0P6EwIWfRAjRQbNdmtT9vDan3lNdqrjHSTDjilEswEU9U/iATz9PhHzE3OdI9lVJtrvsGUQUPtkAiMSxRUffQ0nUvaIlYAMoSeS0PNQkUuxThQtZ7QQnutRouQ5TCIjnbQDYSdcPi5i8mZTVZ41yac6ncrTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=ot5NpHD9; arc=fail smtp.client-ip=52.103.32.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="ot5NpHD9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZtsdQjprVqOWu9raHksf8jJOWcep2/E5P3s5Ii16LMy7DA+K/HHBp8jyneSR1t0wBbvhtZAXa0iyHD2OvYCu6MIKKvCmwSXWM6BqQg3MVzENsMRZhr0cmZ7HGwDP8mpdjULTwpqJJeH6Bl+EedJPYm8Jg1Y3GRzaweaMR1AQryuJw+51ozMB0SVkIh1Bg8o4uldjIJ1UrXRWA7+o6jcNkKqNvQ1RM6HozOkGaDzsl5dXOrXTbDL9+joU/RQ/Rg7IlNIoAxerH/fS2GLLZ48245UDpZhfqTWMkrp0UrbmrDOWgAFb9JsJT5xPV5ydAiYvaAlnJ2IJEdbPvGp9UgTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY/9PRNTy9Dm2AjTa3+u5FRfTJ8l/mJxU4pWI2mJo9I=;
 b=wKayBf+YJhoEuIdlTzr8OI5z2JFlpfHtGdIX+6vz492ns86LvVkl8nsbIdhdqRT810mhOUToo2/xZrtjVhtYFCpAxC2Pv7YClt8YqX56D8Lq/UV9YkRs/xjHD6piLWSVPfxhisSsRp69c52xt9Phzj4CZrfDnFeNA8fv8W0GHFcyTw5dEqNPd9PQinzzSelVQEGH2L+ZWuK/ucUTaYLiLmEF3ycZTX5bBdZwg0iPOThFVAfhKCrtGf8Fwqkz0ViJcVXaraNORzCmLZyg4pknfoTGFA0YBUB5SRaNwhDo3e58srhq62oyxiQmvAvgyEoRSCWF3cuZgmYmBLT+5Q9o1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY/9PRNTy9Dm2AjTa3+u5FRfTJ8l/mJxU4pWI2mJo9I=;
 b=ot5NpHD9iRKXSwDTzTsTz7F0kwHPxyxJPMG9E4r2HTeOq19YNhfXJN9lcHQaW5ioeNuv3lBlTdnj+hpCcVI7Wm3EVWLevhvl6y1fIzJ69m+mpwz0VyeLgwIVgwYf1rxZdhq9mv+scrccaaFYuWq/RVNibjhldptFqylPf8M7SxFMLsM1/+qeaIHZ1m4LaNmx8zBExMAaev5IIgetCQmD7ZiQDK6HbiO/sgQbJS0l75O33kODBerQ/phK0rSZDRF15ImJG6wkdP7bMnUmHalP0h4By0IzUuhOnzhYk5KAqn6+RplKIaWDg/e4JKbS8wR4t1pdOiR+pGCucSTrfozCbQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PA1PPF75DB7739D.EURP251.PROD.OUTLOOK.COM (2603:10a6:108:1::21b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 20:45:53 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.012; Sat, 5 Sep 2026
 20:45:53 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: Re: [PATCH] rtc: ac100: Assign .num before accessing .hws
Date: Sat,  5 Sep 2026 21:45:49 +0100
Message-ID:
 <AS8P251MB0001C6F94AAB68CA1F311E3BC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905184936.155E11F00A3A@smtp.kernel.org>
References: <20260905184936.155E11F00A3A@smtp.kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::15) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260905204549.31100-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PA1PPF75DB7739D:EE_
X-MS-Office365-Filtering-Correlation-Id: 318f5006-66c9-4d3d-7f58-08df0b8ead1a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|51005399006|23021999003|5072599009|15080799012|25031999004|37011999003|8060799015|19110799012|25010399006|40105399003|12091999003|2607281247196008|3412199025|440099028|26104999009|19061999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?52TeJuysXB3rjaAmWvOXSwoP7e8piPAwVCZNUeCm2gZg67P9gIlWOovI7U9a?=
 =?us-ascii?Q?l9MmeuHd/AmKiZCM/ztRab/wg6zDQNed+FbRz7BaQ0hHXlVFF36eQf+hC4EN?=
 =?us-ascii?Q?qmE0AFeaUoLuAIKHyCZy9dXIEyjca88xFS3N7brwRINo3XL5qIWI5tdFVLbL?=
 =?us-ascii?Q?mEy1jErR+A8X7RlJvUCxlFIbQZmUtB35/dvVxe92Xsv/VO8LdwCTqYg4bP3r?=
 =?us-ascii?Q?LgZlNO/Q1F0+8mUXZ7bDtdmoB/YbLL9VSrn/K2CeSa+8c5bOZo4i7pgK1OTR?=
 =?us-ascii?Q?V29S6N4IUDfvpDYz6tBtP4/2kIOHOOroydyuOXJ+M9mx36TsnMdHZusOpcq3?=
 =?us-ascii?Q?Z+WZPlFDNArRygUpCBifOO5gkFqoJq+DpFKjfafx6lGoE3HxUE4u3bi+K1vA?=
 =?us-ascii?Q?pRwMkjLW0ZVIPvJGZOMzpJdnabnT58uXOwDETWqXG4/1RjUJw2dzDdhQVl5k?=
 =?us-ascii?Q?Y3T2yQxkQrT1+5rnClZz3tlHOPs0YFuQhtzzlO76Mrcd66sRvSmv4dXyyUPn?=
 =?us-ascii?Q?RA9+EPtqr4npeyRSGuehYy+aBA5jJufT0ZQmF6vHhe3dSL2RigFRiLva5Zzu?=
 =?us-ascii?Q?IbROklEg9uZAGv/cd9yieb8lIcmkj/10h6PVT98pdm+6Qk/MqzOzvtIFywQ4?=
 =?us-ascii?Q?x5RiR6sPYzPNhCttQrPBZEgLVU1t/gbp8u4SsVEC9ELqTqpFjUYNBGxw6yUi?=
 =?us-ascii?Q?Ka6g8XMIjL8xIiCfBnPtR0wXvk/aCxzF95XyRRuJZgaGad6tbw7ZEoMKPpGZ?=
 =?us-ascii?Q?9AzgCgMBDe6qZzsBLR3uQGGLm6WOVlG8IQa8kM4H7VV8gnZZaNq70rZAzzdy?=
 =?us-ascii?Q?7fw7GMq0n69Ng2BhyZqlcTPGH0jhxMMBd17vIW/s5dMNdGAyDH2/BIZhtGGy?=
 =?us-ascii?Q?UvfF9av9HA5+cqpvc0SPOgReeuowdGentN+Bqq+5RlGvWMAEXwFX4i7L/W5o?=
 =?us-ascii?Q?wDEon7CJejYR/U0i8dwPMAQPcpU/QRIFZGRKAQdHzUsObBpW5E9b8RCHlwI8?=
 =?us-ascii?Q?tBkSmfOHVrafwGGrZp5rIm7Tfv40FeM+0BF6yuNvKMbsvqZ33Axi5IkcrcTW?=
 =?us-ascii?Q?QS9Y7Ki/r2xpu3tPCanfgb01FTXlT6U4jBhFIJwxEaGpmT/4ta0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KggI1JSuhY6vlp4n6fPkM3Vo24JIwSvwVvgb9c1qAJlif8b9z4Mn724oNMc+?=
 =?us-ascii?Q?ZlUYdlFIfPLsOBl46z3N1KPOEYPrf5qSqnJhlgOfhsqmVo1c3HdI9B6u747A?=
 =?us-ascii?Q?1BCtj0qPRtfvYnzEamgIOXQmmiluomUq90QaN5hEvPXhDnb5xwkClhC0oZbJ?=
 =?us-ascii?Q?TOTmlaF1dUWAaPzwhTNBVYk74om+fg0jL0nHUUmBG71ixLzqpVMOvMbyRBaY?=
 =?us-ascii?Q?CSqAxplX7gzAEtrmOa0w0SPG+5iPRA6B6D+OgiLStvkKHFViRkw5G+f5LIAT?=
 =?us-ascii?Q?EbcvOyvpZoX5O4YyYkJk9pigLglreUGN/7BJwnACWWrdskY7j3tYV5fqGJnf?=
 =?us-ascii?Q?N2qazLOZZCu4QF5Lkvb1juEYMxw+5KjG38PBL8Vcfn8CyV6pQmXIIK96/H6x?=
 =?us-ascii?Q?kG2cnqieXcg/n6JME16FQbCkSx5QlOCgrKLB7cLKg1BsOio2G/xDbnBVBuuf?=
 =?us-ascii?Q?x2Hw+V68rLZY1VjGnaZ4m/aUHpqwof3F4C2HextzmorlZ7yOUCGACP6hQ6BK?=
 =?us-ascii?Q?sz4eKdh4xuozzAfjeFJnV0IUZHH+LmRsoftaalGi6g5t+2x5I0d6gJQ/EteK?=
 =?us-ascii?Q?LH6arIK6HL7hOWPzje3hAPab1gULZwQgMbac2v/hLSXfIIb7b88Jj0ZTQXg9?=
 =?us-ascii?Q?w/rTRCMCNGRbrisQvxdwPUNjcYhm2gMU9z+n4j4dvorPFYE2qEpUlTNTYlPV?=
 =?us-ascii?Q?Kw/I1TenVg3Pl7p7udfYt9TwXVE5sH5YXplOuT/vYxRuSjrP8ErYgAMbzE4n?=
 =?us-ascii?Q?lmyL3GGSnX0G/GNqOX12xK78FEPlFYkTcj/D+sdr2Vs19FhpmNPb/VOSm5zA?=
 =?us-ascii?Q?ECiqSOfFs86xfB2fqjpgvYJgBs7NQLRbPoqhpYG1A9WqU38nxXCwkFusj7No?=
 =?us-ascii?Q?KRkFVoTZS1IW/zLogApumpWX9TsVQeXFtAACeosi0KFQIOketJThCOu4Qwbs?=
 =?us-ascii?Q?x4grkRmBeUKDZZ6HN7OFS/UVuWPxp3lQjgaCshGhxX5VwQfhNYrjFOcjfR8r?=
 =?us-ascii?Q?fNZHCsrU7kNvRHAlcmXi7agsBu+FEh9vLkBzd/KfECJ7lMTIzAnxuaFnhKkI?=
 =?us-ascii?Q?ILqjnZRsGl/mL7sJ9suJ7UwtAJOEZ/FP0tNh/FnaaHAWeJ36EKQROb3Jnkyn?=
 =?us-ascii?Q?6kAGKld1oXR2vTh3Af/TWtexflG/sn6ljZ71rUlsBPt28+huuXjMq6d+ie+Z?=
 =?us-ascii?Q?rzJCgfaeY6965YBHtxFBIKz8K7ugYOeQis+S5PzdC8g+dzAJP5Ri7tmmatXj?=
 =?us-ascii?Q?MH04Pe/o5puVbF67VosnEz15/OTq4W35oiHtzwtTT8WkTtOGZ28tubQo3nqx?=
 =?us-ascii?Q?oG/Lza+TNB31t3lLr2Sg8/nqIwyByPTDg6iz/AK2rwAa6pt1gjQKq5OEdDra?=
 =?us-ascii?Q?S9JjlvKbswzOLH3Z6woJIPX+8oTt+tp1dyRlzHVEt/h+pNjft7HigXAWkMBA?=
 =?us-ascii?Q?AngCTmEcsEBxuuqjvs8Cfau1oUS7aD8N?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 318f5006-66c9-4d3d-7f58-08df0b8ead1a
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 20:45:53.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPF75DB7739D

On Sat, Sep 05, 2026 at 06:49:35PM +0000, Sashiko AI wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but does the lack of cleanup
> in ac100_rtc_probe() lead to a use-after-free and resource leak?
[...]
> Can any subsequent attempt to query a clock via device tree traverse the
> provider list, dereference the freed pointer, and trigger a crash?

Yes, I think that is correct, thanks for pointing it out.

ac100_rtc_register_clks() registers the RTC-32k clock and the clock
provider without devres, and both are released only from
ac100_rtc_remove(). really_probe() reaches probe_failed below the
device_remove() call, so remove() does not run when probe() fails, and
chip->clk_data is then freed by devres_release_all() while the provider
still points at it. A later lookup on that node would read freed memory
in of_clk_hw_onecell_get(). There are real consumers: the wifi power
sequence nodes on sun8i-a83t-bananapi-m3 and sun8i-a83t-cubietruck-plus
take <&ac100_rtc 1>, and the sun9i-a80 boards route osc32k through
<&ac100_rtc 0>.

The RTC-32k clock is leaked on the same path, and since __clk_register()
rejects a duplicate name with -EEXIST that also makes a later probe of
the same device fail.

The -EINVAL path taken when the ADDA 4M parent clock cannot be found
leaks the RTC-32k clock too, but no provider has been registered at that
point, so that one is a leak rather than a use-after-free. It also is
not reachable with any in-tree device tree, since every board points the
rtc node at the codec node.

On the rating: I do not think High is right. devm_rtc_register_device()
can only fail with -ENOMEM here, nothing on that path is influenced by
an unprivileged user, and re-opening the window needs a root-initiated
rebind. Per Documentation/process/threat-model.rst I would treat it as a
regular error-path bug rather than a vulnerability, which is also how
the equivalent fixes in rtc-jz4740 and rtc-pcf8563 were handled.

I have sent a separate patch converting both registrations to
devm_clk_hw_register_fixed_rate() and devm_of_clk_add_hw_provider(),
which also lets ac100_rtc_unregister_clks() and the remove callback go
away:

  rtc: ac100: Fix clock provider use-after-free on probe failure

It applies on top of this one. It is compile-tested only, as I do not
have AC100 hardware.

Thanks,
Aamir
