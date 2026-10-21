Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556694;
	b=5kQ4VRQ08LE9i0ZkAhKtVPCbQ9pMk7cC9s93P53x6xFRrUf1e0U3X+6r8AARpqvIV9ae
	 wPsGSkwwdzmWYTyzbGjJzLKVkWaOpEzXl2StlcCM3tfPMM+YGBOKrIxi7BKRnRlcx07gI
	 KahIJ7TwBSxNCVlF3e61OzQfTtbH+WKLcFuM9AdNkD++jqpQBGEQOZF647XC469QxwmRp
	 Ku3y3Y7k0D3/+PvSPIX2SmAmU/4vG8atkHL2vtA8Fd7fyR3VVfzoV0l9oCjhNDRX3JxrG
	 zUWDqzX+0g2Ax6Rr994CaYNCoj5VBCWru8wperDILEwN+3ErPD8MoyHVTtwtawxe8QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556694;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=d+/uLfqthusBAf2Yy+AudNiKGnxe04r20F8OSjFZwIg=;
	b=w33xIPVF+GxZmFVqj3yeVL3t8Uc+PCfpaBoQAyfuVbP1jpfShDvw4PyLoV9VHxnZAMSD
	 9w5bU6YE5qu8pG+2XludVGwcfJNNE0GyaELU9FycFVRwrm3uPkXIjeE9q+Gyz0w5WsCw+
	 +DQX+IKd0IkLgMjpr6ljGIzX/VUP9jCOTg4ObSxUH1KvWy6LszN+T4P0k/h02lGtsNt/S
	 4UzXFw8dQyrgOR6DFbjewaGi00PFFyRCyd2JeuFElV0mo04YdoAZ/nPKjfBu4537yCmlp
	 jaIyfua11duRLGcmQoMhw2V/O7nY3vtxYj01B751tJDQl0e+ra9EVT0hDrZuBGuWHHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=VMVvgj3y;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=K5gEnKKK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEA606A319;
	Wed, 21 Oct 2026 04:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6FEA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=VMVvgj3y;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=K5gEnKKK
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69L2DQph3246536;
	Tue, 20 Oct 2026 23:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=d+/uLfqthusBA
	f2Yy+AudNiKGnxe04r20F8OSjFZwIg=; b=VMVvgj3yW4M/1r6AeYqhPpFQW52kj
	n6FV74quhQmeAgHoKPwUvlcwPd5cPujW9p0KmKIrN9WvIvDKSHPTs4fSlXNzC4iy
	+BqVF+OMko5RGkOBiOZ+1efRskSRYymY9lEXUbr5ROZQbNLB0KVcwAPcumZSRJFL
	/l/LJAUc8cES7olWYltnilj5/g0k222BEI5j3vc5RYL/wz3qM2LfzwBZZkh8vxC6
	ya67xdsd9jGIpwN/RfpTHLmdURtuIyXcrWESC4df0301TFFz9CUGwlgGhmfaIuhy
	qJEYX5i32unZC7aV1ehBKnoGTswKW8LH575STPtFdwHO24VH/k+50TbGw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hek2090wp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 23:24:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VP0llUnxROfVxpTzz3R/jr2V4iJml7rqMCy8cE25BnwDORhOCWL/kFIcnEX7f4c2WPUiJgi2FimfhCn7LYrFVx1A/C8vw2JqcjsU20kYP1E7JPKyKVuFbZ/mqYyMNZUZQxc/5NmZBhKHOLo57dLt7EsEF24+O0gS1Z6Fuxvnk3Q6Kg1pfTygZFIFwFsKNtwEwJi3gLX2usPPsWH3Sdvy6txLRNMV/qeZxNlywjEAl31c5Wtqkxx7nLk7RMgpd/3NRxcYOLl3h7kgyMLPvCaEl5tciJ4Za0UD+84M72BjsqFIRUYZ/dLNMqWHO6h0y3EP3IRJBLOinZFusJSsYbhOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+/uLfqthusBAf2Yy+AudNiKGnxe04r20F8OSjFZwIg=;
 b=YkKYgMuKZnIr+KekWxfYZBqVBArI+rHE3gzMOuVzXdTwqy49KJSSW9pCPO3xoYRLyc8oRhFAT5/rV/WOUppH0/NjVvhBKrdQdbX4W7EW+kzod+3kmifc8SZqKN76mvZ9Kr2j40nyZQLAjEtEYe/PBzpkanI5SQQ7g/b7+h8clvxvTDRnD4D7/s06KG97m6veK0HJszMzVjGXkdfjS41wU8m3FjKhjPAm/lYx1wVoPTVdVCOWbBt+/d9RtGeCvtFHrr6xp6LtU39+EfuRPk6ml0vYWeYEFzokp6SJ14Ycj949e1VWJJgihki6VllvPyPT07qsMzby+Z+5Cj5v+IL7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+/uLfqthusBAf2Yy+AudNiKGnxe04r20F8OSjFZwIg=;
 b=K5gEnKKK6cxr46vKEzVa4v+trbtczQMgGWeS2R7Uhu5ZV2SDGL0GIWwV6t70tW4VHQzL8CTaNG/4Ig5JOrqLQJyRPbDnB3gLOSG9bWgqpfVYgqUU336n/FS5CDlMKlSxFcrqhMnMlflEkgp2z5XnXdq2Msm1RX0W3gCVFcOH46I=
Received: from DS7PR03CA0146.namprd03.prod.outlook.com (2603:10b6:5:3b4::31)
 by SA1PR10MB997784.namprd10.prod.outlook.com (2603:10b6:806:4c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:24:43 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::91) by DS7PR03CA0146.outlook.office365.com
 (2603:10b6:5:3b4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 04:24:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 04:24:42 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 20 Oct
 2026 23:24:41 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 20 Oct
 2026 23:24:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 20 Oct 2026 23:24:41 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.53.39])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69L4ObtK2802556;
	Tue, 20 Oct 2026 23:24:38 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <alexandre.belloni@bootlin.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sebin.francis@ti.com>
CC: <s-tripathi1@ti.com>, <vishalm@ti.com>, <k-willis@ti.com>, <a-kaur@ti.com>
Subject: [PATCH 0/2] rtc: Prevent hctosys from using invalid RTC time
Date: Wed, 21 Oct 2026 09:54:33 +0530
Message-ID: <20261021042435.3895543-1-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|SA1PR10MB997784:EE_
X-MS-Office365-Filtering-Correlation-Id: e5161fb8-a5f7-482d-95bd-08df2f2b3aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|56012099006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	qUalHFvSSLUQ+0pnnkPP4CzyrYfPxk4Yys9g+Mcc8mIw+mJu/R5h6JK6QE+JBb8yNugIoTD8+aOI9V/kz242dbSCTIZjDNdLxpwwTAP+XTLQgoEAWwM7n6z52RenvCd/zXaCsbj/auzmqxIFqZ54E+5+MXtC5jz5aOkj4XA8hyqBfkhT03ycYZgMuTbqjnQzHQ/kJ1x4Tei66eIJN82KDFJFGCwN56gTSmMTJp5kI1c9LSH9uIDpZE81amKEnfrwMrdNeaEp1xmpUgMzGDHGZMEAr9wjRZDgxDC3saNiW2EHtoY5iUQMWYwvhrgwVTSbB0N89r3GNeP9DhRAgLuc0vCrS3SsWaSXTpB8b8Wc6lCio8gAiQQnrQqanDUhAw1iPyaKgvmk7TuVnrq4qCh8vbd23GahhQ2/TCTpkTxTdoR9VaHgnUuek8mFFvSCwtBe/vrSn5MHBkmEXLMOS7pEpI8/GHmn9kk6+KUeh8mN9r2Oxw+uxcoJWyoYq8ij1n9HNU824R6yeRceQYWjnzW3/6IjloTLUwRmJn+95AGcENGaxjllnOogUmKmw975xGvodTHemSY6B0HJZ+AuBiDc+WQsu14QSw0DntBR1nxfha6ihMvguBTMz6namnzWVtvswMoXTgCPKATTo4umaMnNm5PEakGqvi8bGcWeYaHXIgPczFzBVbmb1hiXUaH7H493y0IcLwgOOh6j5zIOhknUGQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PHo5nr3p63KS6TG3PQd/rWIht5xR2RwApyV88ajzRzdwRpqQJOsBl86mHwy8+kaFMX/YkwA8BW0Lt9YwPVCl2VG7IVsUCu/YfM2myCyK6P3WHjAt5ujBCZhn3RMu7r3hiis4U7dDZqxzH79PibfQG8RJEHoJRXH28MPpXXszFZsYoXKVpmB081xxbzU8lQ3uOK+mcmHhO9Hru8g1iBw3OzmaNXZb0rt7s/zHV+FirZmFST20G44pB1yF1nt9hQtQi64YE0HVDNycuCswjkwzl+VHpeNSJcOiVYngCPowBl6+JKIU9F7GXewF/sOkRi+KihiIUvJb2eeDBO0LQgJq7woaQNR5hRQegX+5EmiR0B7xS7DCVVXb3qqugq4UcM44eiK7fhtQ/pzuyg7Dw+x5ecZIlc0nbsLlbV0UzqJQEWOOYQtzraX0qa7VUyr1tl0B
X-Exchange-RoutingPolicyChecked:
	cufCNzByTA1gHNYwdu2u0fZC2BXH1xEuCto+Kql9r6QjN8b11/no/XmeETUghCs5LWaplpQPaC86dVCLPoJlgVTBq8w6ihAUDbkjwByAPVKNeyhX2OX5OyNUh/IL3avtjMTU9MDhayi2E6dqUbXx2FanOkvW/WJ9Ke3N9GL0FnJIkMc1O0+NYoAnkbztxVtsiZwNAzi3oUMEgIT0feZVyp3Qy3sqKchxW6xve56deHPv66U0DuNs+w+0tivetFzb12Kk2acbkJYQZ/Slz/J/1l5Ds0MsVUA3EVonACzs1xRCEpxjiUsziRZ+xutTHNtdKasn/H2ljRvCn9CJAaUH5w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:24:42.7666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5161fb8-a5f7-482d-95bd-08df2f2b3aee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997784
X-Proofpoint-ORIG-GUID: OZc4cSDwfjHfHHu6vwsUrrqOmocThtTy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNyBTYWx0ZWRfXwAVMlFZasrE1
 m14IQVDhilC3oODJKre3lKIAZWNOBPkZpx9IVPX5Yk/twNNQMt0nJBDgiNELYmE1GZXQeVc874D
 wqJPxRkZOiaaL3XL87blqJbjYDmsfv0=
X-Proofpoint-GUID: OZc4cSDwfjHfHHu6vwsUrrqOmocThtTy
X-Authority-Analysis: v=2.4 cv=B98sQ+tM c=1 sm=1 tr=0 ts=6ad83e8d cx=c_pps
 a=qx7sgmNqCaiUqJuMW1Xodg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=JqP76R1kOfSYmssT1ZcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNyBTYWx0ZWRfX8w0ZAUD4TtRG
 bOu1bjjXKXbxT7b8u96r1UnuIy2OSLQG6qUFOhxKZNVE8hD1Lf58zrISDGgkONpT+d8ENsM//us
 LJU8sHuX6MkUTXh4h8STV5RD7KiOcliifzReRpydsj8e54EjYiVYCY0ld5+AW10ygo+Jeq61twZ
 PPb7AVMkDI67ZeQDRfjPEhowCStEIuJT7Ik03rA9HVdKHI+W0WKOkTPhGvrUOTrunEqxDeioll8
 aytvjwJtbQTWRLzCYdLlF1omzPtd4Suu1W3xJobQwdG3Wsc87vAFiKGmuRHMHfWgIG5XW4xsFe/
 8z+R20wqCioPGpAujZZ7uYQHFWdaXa1//Ob7uWxa6LaVHMcBif99rNk6CyQD2Qt1fIRUF1OjD6T
 7FDCgij6Mf/ooF+ysWYd0b5Y1i2smwPn2EPY/DSwU/uu1PPZgyTJa72C4FBUBvAo11CAVARAMpx
 M8Co1x1NGVgnGFBcVKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210017

The kernel's boot-time RTC synchronization blindly trusts the RTC 
value when setting system time, but RTCs may have invalid time 
depending on the boot path:

- On first cold boot: RTC may have lost power, time is invalid
- After low-power mode (RTC-only) cold boot: RTC retained power, time 
  is valid

On normal cold boot where bootloader or NTP has already established 
correct time, boot-time sync (triggered when RTC driver loads as 
module or probes at boot) can overwrite it with invalid RTC data, 
causing time rollback to 1970. However, on boot from RTC-only power 
mode, the RTC has valid time and boot-time sync should work to 
restore system time from RTC.

This series adds a flag that drivers set dynamically per-boot to 
indicate whether RTC has valid time. Drivers check at probe if RTC 
retained power through this specific boot. Boot-time sync checks this 
flag before setting system time. This enables correct behavior for 
both boot paths while keeping PM suspend/resume compensation 
unaffected.

---

Akashdeep Kaur (2):
  rtc: Add flag for dynamic hctosys control
  rtc: ti-k3: Mark RTC time as invalid without battery backup

 drivers/rtc/class.c     | 15 +++++++++++++++
 drivers/rtc/rtc-ti-k3.c |  7 +++++++
 include/linux/rtc.h     |  7 +++++++
 3 files changed, 29 insertions(+)


base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
-- 
2.34.1

