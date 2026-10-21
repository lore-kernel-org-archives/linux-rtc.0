Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556720;
	b=tkE4EPqt8Cp111z8t495aoMe9bURTbqYQtCyHmmo6NDk7OC1LKUy/b4TC6KDiqkSJ+9q
	 0CbiRsW9hFKMFfGyiXJ6vmOzbemIxOQHxrgQ08i8xAU818f6CyasKdWlEuGKGuDmF+ZOs
	 JrgG4RMDQ/AAmCHNyROUIObr9G01oYsFjMeXzhtc5Pny8MV5BFZI8nAzRZkLOzwzQnMzi
	 d4O3kcyUeClz2ORU97bpLMFhQuD/LgiZowIwqWChxB2ap79p4ezRCa2Q9h0W/e+YOK8hh
	 9LY58T4dAxgw6SDl1REB7dclR4RjpUQcfBn/6U2MerIfQDy1k1eGzWv2mWmLV5y/PnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556720;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tCbJby9NshbfSYKFH/YgoC2cqn0nU24+77ZT9htVTyY=;
	b=A3qhnR3L8dmNxgn/Q5vg6Q7IBO89acN8hhI5pMTzLARZi6Z3D/C/Mm/mMiP27G9+BMZO
	 fCsUwkie1J3FiJSoYln0ZEJXWQvTJ46yiF+KfQF+9ZvTH6oJB/q8sQKFZ5fhw3fuqL0xn
	 ZwAYPrwMfPfVImRq+ENql541umxwsGLOYbks66eADhVgtd1ADRGQQokuZRga9CvRY0bib
	 FI4VSRoFh+55fYjgZP0Oex+uCD+wVEMvdxha/ySVW7ju1mwB7RGY9wcSWV6TyVwf55cu1
	 vWri4vfF77Bf2YQJfH0ZziL25PCIBFai3nkdsEcyNmeX1ENxkpzFepVHo3Pt5+mc5mQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b="L/K4w9tn";
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=KaMhRols;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19560606A319;
	Wed, 21 Oct 2026 04:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19560606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=L/K4w9tn;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=KaMhRols
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69L2DQNI3246522;
	Tue, 20 Oct 2026 23:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=tCbJby9NshbfSYKFH/YgoC2cqn0nU24+77ZT9htVT
	yY=; b=L/K4w9tnXESn27lsLHcXXc3EIE6d+9nMtEK5YcP2mqGgKqdFTBhNvtivc
	+CEmbKYIyQaXHprL1o9BZH/JQmWkyJ7VPfnbfjEbZXitgJFfiZLH1B/wq50FbIfQ
	dvyZ4adWlZv+HraH6QF/iGJRSPcN+II3MNigmzKtGF0ihU1FT07tGMhmUwtrt7LT
	zdeEkFI1H+zIoMrgvtKTfjIQOXPyOlGZYjHJapdD7bTVMQa1HBmL5MGzrN40zDU/
	ZJGjcsqq0J1o90jLCgTk25e5ZgNpaa3pjqIjlhQN3lqFoaHiS2hUBIbOfwviw8Wq
	Pk15RKr/xfYJFV+8fv6odplmXDHkA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hek2090yd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 23:25:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNXKjbu2ocRKjyqv8EA01aB3du6sw2vyYZSfmM4CWlg/P91GeRN6+jYeKfpywn5Q4W8lh0+h2M3uFMLjskf5sEuDT5whU0eMVBB6qFUXpy3XJaix+9tf8BuRbJGGNpNjvKF67U6CvZv/HFw1UNjGGPue56ke0zm/gmjg6J1VexHUx4npR+QygZQ7Fi3CvLYhWCVi/yemhKNKYFBKSjM5wjRRTT+OQy/GYppc7DQk4N1qKr6uENtl7tvLtsYkXaxyA8qvWUVkHwh3IK4uHrZUSptV3e3nLfMBxJydocQHOE/hh71egVvOsfolK/phu3F5pGW1m0P68O+FJ2sbqujekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCbJby9NshbfSYKFH/YgoC2cqn0nU24+77ZT9htVTyY=;
 b=ZjaEfeUSwS3Zf2PH6XtF/Dew1RyTdQ8PEqtvG1J7FEpccmL5FnGaM2jCEqU5DutgckCCErMVKjE4JYTqGWTjSna6ugvh6fl/ch6uOuNl8iyNJAd2rLtSwZZBV1QmKkr61gpBriWE7YIp60TDd6y7pyEn7yBbJiKArRvENH/gIRsL4DOO9yOkhZiQGQI74NhvumZRmtCb8CJ7BaiJBitN20EGNfwqMdXhpcheAAE7z3wCBMysUWO0KakjE/z1O1PLpbnPFQaL5yD0fjXsUpMDio98SaV7o1RvPt4430vrD+tAcb82yMfA5x4ZmthNdvMb07xVwD3kAR/w0JY4FVTXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCbJby9NshbfSYKFH/YgoC2cqn0nU24+77ZT9htVTyY=;
 b=KaMhRolsmPW/iVZFOGIoHLrCNEAhhAsDY3n0dzQF6QAAigmESisWAZvSFEKZkcxyDnYuSVqKQD3d6xMYkgo8E5kFdR475BLidQYWdnG4mTOzkhOTx/KHzZaUkuA/LJYOqNCNsDDKYhjoR+E24B6I4k/Q+XzWcaJD+o3UglvUJKc=
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by CO6PR10MB5539.namprd10.prod.outlook.com (2603:10b6:303:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:25:15 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::b) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 04:25:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 04:25:12 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 20 Oct
 2026 23:24:51 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 20 Oct
 2026 23:24:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 20 Oct 2026 23:24:50 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.53.39])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69L4ObtM2802556;
	Tue, 20 Oct 2026 23:24:47 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <alexandre.belloni@bootlin.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sebin.francis@ti.com>
CC: <s-tripathi1@ti.com>, <vishalm@ti.com>, <k-willis@ti.com>, <a-kaur@ti.com>
Subject: [PATCH 2/2] rtc: ti-k3: Mark RTC time as invalid without battery backup
Date: Wed, 21 Oct 2026 09:54:35 +0530
Message-ID: <20261021042435.3895543-3-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021042435.3895543-1-a-kaur@ti.com>
References: <20261021042435.3895543-1-a-kaur@ti.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CO6PR10MB5539:EE_
X-MS-Office365-Filtering-Correlation-Id: cadc54af-b018-4a6e-ab22-08df2f2b4cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|56012099006|5023799004|261009223027099003|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NsCksnsXQaxHa2/21QUbkrkinnkEj05o3bpC6z8xXnBn6KXz+UiXbwVztoKIQQRnEJHF+LJ+/yEfXqiWx7QBxWb95h7YGqun/878E57pfotcfWyee3XfAGUuYE9bJZ3V1cskmtF2aC8TszZRXNQ0oozNYCM+9JLFundCaYaco3vWCs32O5vLkk6JdiQhDmsWEgdH1eGAnhPGG4Ja0niNnxbpEY3iGJ8TVOCnGrj8NObgY5dUzFCfOcYCmlD3jQywLAqCGtK3jT0C+z59zvBNHgVGIba12CsLUrvK45L1C3fVgNsMVQdFjM1TaZbvFhIbKQPowlkrUi1TPNA06Y3WtP6A0w218SWdi3agRww/uFR/flTRoa6GCKEVomiNBK9uu1AhcrmNlMOAVvjf8UTaIQ+GAvKxXansVWUt5wdwXLr3gAVsqWPHwDYQuvwR1iQ8NbzMfxoIxCK573C0RGK7C0g6p3kujHUrRyvhs1/SPXmTjWdDxc6HysMRdP9RGNSqO39vDsuD0+FNGVas29h2ZRhYlZ0LDhIU0QAiWAiMFQHJ7gThlMFnxah3lELyIYEN+Xz9mggwvMprw0DG/jP5LlhRVODzoI/DR8H2pZZcxCifljNwVRJ36Z+/NNskCGvCICxpzyJYoJkpQQJqSt+7hd6B59SYJiodSVLFgbZy+id3P0KNbHbm8cN5j9gRjD9vQCzi11PbfgvIsZSOhei7OQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(56012099006)(5023799004)(261009223027099003)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VPWI9NLwMFQ9lNV7oUeoS1x58S5PQc4o9eH8O6fNjrr8DFsL1pDa7lsKkwbh1bAxktrjfP7vwntCHlHjkSVLcUuRnebZiVEZORtq1lzF+aImwKjRw56VAUGzJdSt+uzMscZyl/1+srv5+qNm5h+9MMNJGdcm4RWsJyOb0L8W2I+V92HnombL9z6ZIjU5LFcbJWKuGqcPDVNwkxmx3QPxJVQH3uSJgDZV5/MzqGiXNasTGda1i/L2vsFsIFBbGd/k4JWnCRp3pZ9pHg6j0b6LRr8jTa0ylhx7chzYd7cgFm1moLj/qCPkQKgph0UaDAllNZk4FEiXOfzahWCdqP7JT+w3Md8evmN0r9vLX+aWW4azrVx7xrbYz39XfCDy79xxDIChytKwuhlvv20UqChwLm6KcVXTPZTP5jpa6fdZs879oph7fbYjT9k/Qbvl3M9b
X-Exchange-RoutingPolicyChecked:
	ZnQI0nWIj0YnI4kFVPENnNQvatYMMeEsFRiuNTr0/67znd+gRSML0/7BJkvHxDNlDY7hJe3GWTg/PwRyOLe71e0jR3RIP0j8tS+ROkSat73sUEM+kNa7TtewgId4an7PowlHDQmFp5Tw66XuokhxbM15dwI5sKGlIkSQ0KO274AyM1aD8z8h+wdRnDcm971sroHRidnu0vDoWsmCLjTGjGph4mB4q5gw+b8e0t7LfjNhqu3fhkRNnPE0vn2Ye3ti83iJZmm/XumEDaUnnOK5ZxU32KryxdYO6xWgow4OvUFRpItkXK+qsV9S/kj5HtcWdtR/K2KwbswU4e4a+6Nubw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:25:12.6397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cadc54af-b018-4a6e-ab22-08df2f2b4cbe
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5539
X-Proofpoint-ORIG-GUID: 2HxRNtTAP5Xze9GnCbdchYW0l9bm9kyg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNyBTYWx0ZWRfX86CXx1abAzC/
 5nD0m4lJoCI4drLJk5SkyAiUWLnGd/jlbcWRbHOliJV1VxF3Gqu0lqSa1VH9G3F4ffiUlMlZgPU
 PEfAKEAk1npVDx8a8rfUfV1n2pNIywY=
X-Proofpoint-GUID: 2HxRNtTAP5Xze9GnCbdchYW0l9bm9kyg
X-Authority-Analysis: v=2.4 cv=B98sQ+tM c=1 sm=1 tr=0 ts=6ad83ead cx=c_pps
 a=uJxR2RjB/d5PFa0hjvWx4w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=Au0HeY-_TDB4qlutwuoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNyBTYWx0ZWRfX9prnRKKaqtDs
 lLm2CdGlWBT6qvbBBDeRdnE5OQKFFPV8qAdLScD753GRKJG/VjWIIZnGMl27p6GI8fyQ1nJKWqu
 88y6Hw64O9Jfq9tvDX+MMw21ACMDARz3Avv8BqXcAdOaqgMIIAXXgVrd8vW59nVujf7YbDzboxn
 EdSao2hnEWvvqv3o4emE0slvCbMwSzRneFZkQxhPU9wpnsdQhryfxYs3QybdgLUJ2c+0zF+wxBo
 RUYoMhQd2YPoQBRQm7hZG/KkufqTdJwbCZ52erC3BJnjwxE6JiRCUpjA8okiB4em4H1WEows/He
 hsfMkK+HsBK5Rob6xD07V5Wjs5ldeI1QsyGqLeqAGaKJJJo4AlgriTlCPTZlEMdS1XZHkEyKTuK
 TJkg114cu+oCY+BxGoA5Susj4l7B24izPg/Vrr5e8eU32HOvALuKRgMocD0ShSh5HHy3uDHGwdq
 wQFblatq8x/yQq0QIXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210017

TI K3 RTC typically has no battery backup. Prevent HCTOSYS from
overwriting valid system time (established by bootloader or early
NTP sync) with invalid RTC value.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 drivers/rtc/rtc-ti-k3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-ti-k3.c b/drivers/rtc/rtc-ti-k3.c
index 8df00319cb6b..99fdf1192675 100644
--- a/drivers/rtc/rtc-ti-k3.c
+++ b/drivers/rtc/rtc-ti-k3.c
@@ -613,6 +613,13 @@ static int ti_k3_rtc_probe(struct platform_device *pdev)
 	else
 		device_set_wakeup_capable(dev, true);
 
+	/*
+	 * TI K3 RTC has no battery backup in typical configurations.
+	 * Mark time as invalid to prevent hctosys from overwriting
+	 * correct system time (from bootloader/NTP) with invalid RTC value.
+	 */
+	priv->rtc_dev->time_is_valid = false;
+
 	ret = devm_rtc_register_device(priv->rtc_dev);
 	if (ret)
 		return ret;
-- 
2.34.1

