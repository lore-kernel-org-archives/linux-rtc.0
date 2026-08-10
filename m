Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99C3C1974
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367157; cv=fail; b=KON2DwwE3SkD5BdmEiFaj0hs8Sp7204Pp3ny0cqzmjRTS7zcok41m8058kJIEzsWZ+cQ2QOBKyesZ5d/wCLwlw989I7dSEgx33+McK5O2TU1yFNzXPfHRunHKxWS9UkhIbme950u1KPBETxcjZLw9cPyRDXz42eXQK7SaSpUvMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367157; c=relaxed/simple;
	bh=/Csfq9rYTEO0mHwdIcmwY8kOzD6J4hvAcp4/bkr3ytA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwaKvgWlGoB5K1UhG/SbE+59E+QI8Jo76Uw9AXtHJlkp4or2p61bt+em+EPOeRRcsq+BwJCMrIiQ51Q7iBT0UjDHJHME72IG00aweqalqlxhXajCHNM9iqkTI1PuW//DfgkIAKyY96onjVGhdFV2qz6ZhOqgvTH9+erI9PAtnD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=LIojmVSr; arc=fail smtp.client-ip=52.101.84.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="LIojmVSr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODMP1sB0huliuVtdvwj0vZhFRpLTDZ8jN0++GAKnyn5ZiuczfXWFZK63bK07cNu93eUnzeKWYKtSGXVHXfFRbEiQwAcC1a1rawxJ87RX4avwyM1ChmEpuRLWGy1+CtevgOJBlqYcCBaFANs4nBlPSK1sJ1P4X1Rk99ZbMDck1y+DU7dS/AaPDLGzM3Hkd4WBQ0/TqHiOuuLbP430EYvSKuBCuYQ+wp9p1YhvCKLsKj2DcT5TCtUF+ReBOsTakFiMqi4LxV33Q5tnLe6RhhUcL5quToYMOv04N2PiiQNqNos4RDChflJpzJQ26W4kdDW2D0xDe/Hb0lueo4Bk7Onmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Csfq9rYTEO0mHwdIcmwY8kOzD6J4hvAcp4/bkr3ytA=;
 b=Au3qG4NUdcoi/HVL2RdItioueLWv9WvMy8ffPXsEYphwK0750EbiKgIGe5eOmtkT8kfH1r8ZqfCyLl24A7w3R4yr5zI5z9n8NUtISpJ5hFepTgtQr4qB3phVzSzVMPP9H9DCVa/S8ohfBtFWLyVT1b5G+/N0ZFOEMHLWYoZi91GZeMhTt52ZDzNL5CVzp03E7hz8UwbK/5Bb3yqhBxVXm9h35KeyOJ83XeLbxkSZZtcfJHAO4C5oJPZkItLAmtcVOe6ig/xaMjy0qMSh62cibowsQ38MJgtrS5BoaAdNMaZbGolcdl8RRl7qGRGTu2tzUUVVKhqoY78jDARqoAjZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Csfq9rYTEO0mHwdIcmwY8kOzD6J4hvAcp4/bkr3ytA=;
 b=LIojmVSrkwkkqgWQjSJrFZa0mQZHW7oeMEu07W/NjwVdmUDk7HGVK0NgJHOHXVrMX0z5S6aHwL5RUdg9ARtsgVpzZd+V9Hajz/AMpjT4wPIv8ElS+irbuq38n4+2lEdDDZjKgxWKo6uBvmtIhBisLdWmjQo2zKYYYwNwIeWZn40=
Received: from DUZPR01CA0265.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::15) by PR3PR06MB6732.eurprd06.prod.outlook.com
 (2603:10a6:102:62::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:05:51 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::3c) by DUZPR01CA0265.outlook.office365.com
 (2603:10a6:10:4b9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 13:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.99) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 10 Aug 2026 13:05:51 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.61.228.61]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 10 Aug 2026 15:05:50 +0200
From: Robert Leussler <robert.leussler@leica-geosystems.com>
To: sashiko-bot@kernel.org
Cc: alexandre.belloni@bootlin.com,
	linux-rtc@vger.kernel.org,
	robert.leussler@leica-geosystems.com,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] rtc: ds1307: fix RX8130 wakeup alarm WADA bit for day-of-month mode
Date: Mon, 10 Aug 2026 13:05:29 +0000
Message-ID: <20260810130544.3551013-1-robert.leussler@leica-geosystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721083021.7D2921F000E9@smtp.kernel.org>
References: <20260721083021.7D2921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Aug 2026 13:05:51.0012 (UTC) FILETIME=[F7FD3640:01DD28C8]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|PR3PR06MB6732:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5504d03d-4bd1-4317-5469-08def6e01ab4
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iQgqe54B9J1aRHvkrRCsz3LkghgU2LWrx5tzOUJ8CHp47fRJHH4jc4FzvFP0IYbNzpKveWNoIC3/d281GYpZUaWffIOjH1sqndYBtbj0eQ1O4rtqY9RG+Eyjo+FqAfp+9u8fu+El/01b0OY2lzyLZDh2wP26NDdkrBnB+R5hPKTvc0rW9CDRGhIDAblPI3p8Uu1MuIZVqiNZVWZF0+1EkWIwH6quLF1BAMPAdkVSde/2r9f+A31e8sVemlhxY5WsdxNMta0ojLEsUMT9mRMiITVk8g9NzYReUDy2kLeAoLQujDTZOKIMbY1vbjsebfAaEG9HQVQuc95stHEHou6dbwfBR+EadnlzjQzrOa0OjtqtxhUXfLWfUw52wnpoFcImgBmVAT+D8SWttTVQV5/yunj/EiamcX3UB5JBFhmra0D7WcnxXqZk/UmQMJkh2VaW/6qXZFQ/xgmKmy6XqoAKl3xTKc9cPEwsrQxwPcNDfPTU1WdHtj30HWchn+KWHxXFfe6lSHPSoFFxEt7QMP3sU8x0d1GBupsZkgDLcqm6ZEnElctZBd6AVrwiVYxmkfH6H3Mk+OJvtlxmgXJ/2qrD9ZNvXNSnETBSR1ARSsz8X27t0TRepOb54JKFxxos2KsCtMKddTigvCYFJZblrZADLjlNqtCEJGPmxcGUEmiwi1ZT/e2DSXbhxwnSKZiKtudM/hascuzkS67URE71zTREGA==
X-Forefront-Antispam-Report:
	CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QuxGPOUzc+s876o4F6sCVYf1+l7YkaJCpGXVurbpvPB5c4qlvKD8nDC9DJEbCHhhwK2B6LRiT3+1fUHk77hMCH37TuE7nk+ouf+pxzjV26FYQS6BJXdlnk5yLJNmpCpy44qlZAZTxCPR9BnLlTZYW5NugwlN6biXsZr7hWfxtD9os22gOFp7qT2lkcQj0bQ8lGkM5hnn9+tsCteh6mkLk7L5AnJOXjZx5TyoctwcYUikr3DgDNULPuq00G6JD6gnZIWmtRKVx6mrvI5WfWxpDCP8/JPEy/HhZEh1FI5Zp6HRTnoFk4jB65APsJQvlWDhYeoIbU+qOe87plN+RbZsGxoC74/FmvWCOdvNeztBOeABJL5uiYI9hZhIy2ciIERSbKkpTZwqIiyFMbtZjs0uKbzUkJ8bqCcrNetQ5qAgJ02FhPXQ66uDGtdnNXP/RiPO
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:05:51.2863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5504d03d-4bd1-4317-5469-08def6e01ab4
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6732

Hi,

Thanks for the review.

This appears to be a pre-existing issue in the RX8130 FLAG register
handling. However, it is unrelated to the WADA bit fix introduced by
this patch.

I'd prefer to keep this patch focused on the WADA fix and address any
FLAG register handling issues separately.

Thanks,
Robert
