Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556699;
	b=OKS4j+q2YYVxuI+M6bsJOvsw7HQvMScDZX4MKxSfHJL7jhrmga2BRdrkP1Wa0IZIfDc2
	 wfRjHpkbsGXRfR7wYIgOOgDLtDAaEQzX+MiMvHVYsp09CMf2VnQa2oOrMgdXir31DExUW
	 RzVvFIGAbGLy2NiqsAZAnDuzFw50OXN6mh/YdB47BYU239+9WlLyR60JRO6/VhoL87qfF
	 84fEynqUx8DsRHSMaqaaXMP/OyejaySW3AvtbZ/8O6kBTV0BjU0Zzu5kT5UbW6Rsm0WbI
	 cn55yc0zQIPKlR6r6+MzkHeGPSsPhwtlhNRq/0ceq0bofV2bmZ7UqyBR2aSSbO254AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556699;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oUCL9BXIo9vc+DJv3CZ8i39yJL2VebW/+o5YJ54j1Z8=;
	b=Nbf3oYUwRiI99uFZN+lcpgoH7QEK2PYi6hcb1bIEeaq+8Vtaxklw/FuJxVqoObNqviiv
	 3F7NOJFMEyxY+UegH80ul4XknSg7xl4tyGR0Y7k9HKQbhBgg8tvRdfMKomYaWrS25I/Xt
	 xTPPLvHD6o5sMgWfu/wSZAdwV4iiu43YIp8TD6LQBZXV+wquWUHMNyMnkGf4tnCBYx883
	 YZ8qyAJ1xIFH233pAleDVX61pWO/BrBSyUgNs3hC96N4mEpQylkfe/jfb5dfTCvuRtlyB
	 i9YMdKdNnU2Qz96iCIn2/JK6aDEgKsLLI29B/0Y9X4DokBLcCHVmJnX2eC12ZIULDWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=NqYNBLxo;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=gjtcJIkM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7DD606A31A;
	Wed, 21 Oct 2026 04:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD7DD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=NqYNBLxo;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=gjtcJIkM
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L2Dpmf4095342;
	Tue, 20 Oct 2026 23:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=oUCL9BXIo9vc+DJv3CZ8i39yJL2VebW/+o5YJ54j1
	Z8=; b=NqYNBLxo0U3QRlHhaK54nYqnwtIquzaswFe8X9GMrGXDmcdlI1yVJg4Dp
	0NDTywXbSuNpb17ixt6lEsj4wb7GEqiOaQW1h6HEXwXgYV9aFiHqW4uoAY/6MEMb
	hrsSwmO9a0yaWj2EexzbsRcb9V45MhHG0Q8AY7yEmxSfjSlqAndQ50Ptgqm2KnDA
	MhRDIf0sz9SUHAnkrwvQjM9y/8c+6DpHBE8pQhEaWGvKXLMFKMk8UGZ21ekadXC4
	p97+4jEIcwPwjrES8C6SndYWWs7f7PA9ALp8OusMT6tylV7o3+a9AIhNoYYpg7wX
	6ISk1KllnVFTp/CIct727ZNNFMbFg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hecukb3a7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 23:24:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HK92FKU0/x7OoqGry8EYj4AG+wPElI2iaykf2leMHMuku5scqrHF3VKeQsulVGrvxdrIbHTTR4y0CkAyqlxTyMXop8EE4xQz2Eq95mFv9QdBD7txYVnjgGKFP7rlyqtE1JIU3gu4IxVVt1/uvJOVoPtziQvBWB9aHv7V/FkaFHwwVKCHHMMLWx9ZADSKFJGpZb0l+4RYbnO8X1TKMmNQGUhfb7urNr/oCOH2+dRwQz8WB/mNU07GqQcfAt/XgY37d/B3IYsWHB8dxyhjXuG+cHcc5X7ioJH1Y48s3Q9zaNMfPic8TXXd5f994/7lUI0/O04zx3J1g+JImhTowVqz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUCL9BXIo9vc+DJv3CZ8i39yJL2VebW/+o5YJ54j1Z8=;
 b=aIr+lcL14suLKpX7vnIV22EoBcz1ePHOF00HdzO/qP2S7RwEXhDSHsiL/QdFCKxRiJDJuzsFDtIlYPiXcXzJF7JwJvYLz1HC1N8PnVu0rR80xE369WHfcR1ScwJybKtWETDgGZCwD/SzMUucV+YVqGQd9/oQVJs90BLclPvkHjI9RHisUH92q17wt/pMb3WzMdnvTmJPtrJp85P1c6kgs0CoAHwORmFrBeK+jebsg31mvKlpAsAvdidTkSWfOevu1XvIGIH5kqo3I0H2aZAKJBZ76WuthZUHsEE1HLamij12kHuQg5bCGncRjK8dDFejZ5Gh/MUsp6VQMOTC25/W/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUCL9BXIo9vc+DJv3CZ8i39yJL2VebW/+o5YJ54j1Z8=;
 b=gjtcJIkM6JI942zJy4L3wEUlIPT+jNB9XhaV1M21yaeaixVrmVWB4rseQXyxcJOjdp7dk80MVE+3NNYOJRtCNKRo0nf4YQQH9hExbF5I5ZqvQ0v43pb7DXI9d3NJtbcxPCQSqyrlE51kUoKEjpYk6exHlkfPA3YJgCpcx9+B3FA=
Received: from BN9PR03CA0391.namprd03.prod.outlook.com (2603:10b6:408:111::6)
 by SJ0PR10MB5584.namprd10.prod.outlook.com (2603:10b6:a03:3d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:24:47 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::41) by BN9PR03CA0391.outlook.office365.com
 (2603:10b6:408:111::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.18 via Frontend Transport; Wed,
 21 Oct 2026 04:24:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 04:24:46 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 20 Oct
 2026 23:24:46 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 20 Oct
 2026 23:24:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 20 Oct 2026 23:24:45 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.53.39])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69L4ObtL2802556;
	Tue, 20 Oct 2026 23:24:43 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <alexandre.belloni@bootlin.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sebin.francis@ti.com>
CC: <s-tripathi1@ti.com>, <vishalm@ti.com>, <k-willis@ti.com>, <a-kaur@ti.com>
Subject: [PATCH 1/2] rtc: Add flag for dynamic hctosys control
Date: Wed, 21 Oct 2026 09:54:34 +0530
Message-ID: <20261021042435.3895543-2-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SJ0PR10MB5584:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aca643a-ed56-4e08-3231-08df2f2b3d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dEnfbFu3jCh+9ksGUjJE8pO5+NMjt+Jo/gTkLjGBeG6MKmAFEjfAGiHxtRHLQ8m+0U5c8N4mqMsvQ5cy6PO0VS/nUresohwioRMo03B2e49qmaVitDCVhwzOPUHkHSaglSGdNPGAKTe5bvhJFO3PqOk3cIygvurlU7IBxBxqhsqsl87se+p6InHRRpRu1zZGBL3QtdGQ4KZA6mfbv/fuhrgQEgvS/iP2qqyjSi4PO4gus6Za3FeOs+q8NZa8HZKMTKtff0JVmYLsva1vvJMpK1ZhMjUTGNJm6DLUfLQPlsampDEAAr9t6MxYlbdHKWryv2WB1X+YETloT9j3emVyC9R/hgZxn2wtKG6MzEk9rVKedKjtd77JyzDV+KXG6aDD5iBary9SXSXItDanhQJBik6DxzedAxu/pvG+V9ONEspIERD/Pl1daTWSh5CQRtg/4glm7dl4iOIhI193dWOHHujGuiqdiLDHRzbU01nbXXaWtadSwsIlSL3+7A3cs6eVNqmAhBiAsbORP/0H9jIUDq177q78wuYDeayL/D+xT9NJ9usULITSuA490qYul5hBNakKmxVg0jlhKjMVwdyVwmt5llICbI60/toD8FcqlBNFLG4UdeehFlrNhgCMvaAUqiv9uxcus0FdQiOPbFF9cmeNQG5fiLLIqQlvfydKJppLlzJJ4FrvGGGlA5ApxHOoonHrnCJ+AEI0SwADC4qx1g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lf3yZaUiu3YeKb8LdCg0W+49X+fpgBa4v69aH5Aw7xH5LI03e1XCsdRD0pJauzC4Ap0zcpooGkFo26DcTfsfsRwn9vaL3anvUs3fMXMQ341hnJm82ukUbhM2XS1ma6UIW+VnDwCbg4Jw/O8wkggSy++skx4Yjfp0iHiKeukvUaCEpfteRJsiiYy2Tfy2biHz4aozVaimx1E/512bgjuMja+XX2vjpLZhRqQ3Wyx+shMCMB048V1m28fUIxVn8NFUK4qXm65Zspynz/vjaUb0q1OPOZHWoYq3mcGNmEA8Pr9l7NLwvjctzLBsuN1iSsjilrNUjZ+eA7tYGcgi85flEk7px9Xc/byP1s0btEq4NMs/A4oWH2IaJp0jpwZAZEe/U2+LF7D8mvp+psZtoYJh5aUwhoJeGxl+xzAhHVjRRZTssHEQppQ+nFsfExJ4ZbQB
X-Exchange-RoutingPolicyChecked:
	2KA1i72Ju+sycf9/uPR+e4YV1Vpt1i1+XBq8aB7FyhOGW1U9T2rfzN+J63tJR5Sposx8kzRJCzATAIvX/TkoCSxlOU7q6pfOBKSg7lvc016C56xs0F9o6Ol/QaOal6yChqW+6FJIqUR1dpDMHzLZd+QqC+Q/fHa/9hqGZnCWksimGOndng67EGR6oM11N4lMV9fCfF75JhDYSBUfs20OdBSZEONYMXv+Cm/u+VARWiABWa9O6p7vir/MpYJ5VHUmhlux6Ae/pCPNAFl4ywSVcpKAFClLqqkr1H74xirEM5RoP7npGz/7F8AvW+COOjK9OJIrfA77RBZFHbpU1gI+cg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:24:46.8217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aca643a-ed56-4e08-3231-08df2f2b3d5a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5584
X-Proofpoint-ORIG-GUID: BLb4iZviq28dvstcwCfQc6QQ0vblT_TA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNyBTYWx0ZWRfX2H+VNkYXL4i5
 ImdzFa1BLci3yQ7VKS0AXZX0OLXpWZxb2ZZk6k4sAJ7t2AxI6lUcRgMZkhTZIxjYoSMwAcRHca6
 TljEHgk/pVyK2S4pi64kxria6ogKyiDGitxN9jTKKYwY6KUMlXw2hTvSs9QX4yYWE2Z0C/3Xsum
 aS+ooXHGvzWSy024aAaSeqGBjdWvnqqYVlNpukQmstfjcr0m70ArnyICSOiy+PAUnaCpolp8Rlp
 vAe+XpbLxCS7++mMsjDg6dafUYkLy/4zwuUurqjenXrhswi1vngspZNOQB1QzbmdNfLweT2XK9W
 mO286vKVoxpHcZqfhO1tDZhKvQh3afKXNGPZebyzS62qe496dUOK6Xs40gTyeb9TLeMvoaxCxWr
 gMqiis1C+sl62wAEZ915jHvNNXJB4RcupMjopcWZmKZsyVJMg4koAYjWySpqYNM/WcCX7+7IgR/
 KwpKb4LkXClcQd5uPpQ==
X-Proofpoint-GUID: BLb4iZviq28dvstcwCfQc6QQ0vblT_TA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNyBTYWx0ZWRfXyrm/Phlri6C+
 o2oG25+5iPbiiPFp9WaVb1uSzz1LLOTvJZR3Ffp90b7kjUyPF8/Za30bqaeNRDAu1Z8UTItHFrH
 tZf2WspP47EnAXwXSEm3kMvrT02jbSg=
X-Authority-Analysis: v=2.4 cv=dfwVTnXe c=1 sm=1 tr=0 ts=6ad83e91 cx=c_pps
 a=gJSDm7Sez3IyWyplfMHn2Q==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=MVyGIC_sB9K4wsjetMgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210017

Add flag to indicate whether RTC has valid absolute time on current
boot. This allows drivers to dynamically communicate RTC validity
per-boot to prevent hctosys from setting system time from invalid
RTC values.
The flag defaults to true for backward compatibility with existing
drivers.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 drivers/rtc/class.c | 15 +++++++++++++++
 include/linux/rtc.h |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 01ba04028f1f..cec27c476545 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -63,6 +63,18 @@ static void rtc_hctosys(struct rtc_device *rtc)
 		.tv_nsec = NSEC_PER_SEC >> 1,
 	};
 
+	/*
+	 * If the RTC does not have valid time, do not set system time at boot.
+	 * This can happen when RTC loses power or has never been initialized.
+	 * PM resume compensation will still work via rtc_resume().
+	 */
+	if (!rtc->time_is_valid) {
+		dev_info(rtc->dev.parent,
+			 "hctosys: RTC time not valid, skipping\n");
+		err = -EINVAL;
+		goto err_read;
+	}
+
 	err = rtc_read_time(rtc, &tm);
 	if (err) {
 		dev_err(rtc->dev.parent,
@@ -243,6 +255,9 @@ static struct rtc_device *rtc_allocate_device(void)
 	hrtimer_setup(&rtc->pie_timer, rtc_pie_update_irq, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	rtc->pie_enabled = 0;
 
+	/* Assume RTC has valid time by default. Drivers can override. */
+	rtc->time_is_valid = true;
+
 	set_bit(RTC_FEATURE_ALARM, rtc->features);
 	set_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
 
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 0f43b5027235..f6f982610938 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -152,6 +152,13 @@ struct rtc_device {
 	time64_t offset_secs;
 	bool set_start_time;
 
+	/*
+	 * Set by drivers to indicate RTC has valid absolute time.
+	 * Used to prevent hctosys from using RTC when time is invalid
+	 * (e.g., lost power, never initialized). PM compensation is unaffected.
+	 */
+	bool time_is_valid;
+
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 	struct work_struct uie_task;
 	struct timer_list uie_timer;
-- 
2.34.1

