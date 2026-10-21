Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792560333;
	b=ZxWlFmEi42qTfTQs26e2ZD7WNAcMCCn8e1duRrISvbEfmcUD/mjzcAB3IAOO1BuGpNvy
	 mqk+SjBoK7lj6g6EluCgpXynmBDp8Ihn2zOM5SPCUocI98lsV1wHEh1d+YkXBEyfpsbZA
	 2BTEAQqbmuqMikYGBAovmctHAlcCSJy0tMeMr+miRLkMx4g3q1gRQQejJsk6+qNiv/Q7Q
	 NnxcwPuR6Fa8PZvnivdhthqELdaqgMMaFp92boBg+Gb947dzYQjqmOqHe83+ZgDN+7k++
	 TWJwSmI24ylZkhnDTe3jclWyhyNhhNjie3L2zWelchEZgaCt3oVjfhHJY1coZqY49uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560333;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mKp6M2WTSARENmYYx62aXLw9T8dLsocf4luZ9aU4KwM=;
	b=SsohHAef/ldIF45QzoeKj5JgxgTIIESJjuceqYV761NBFeamRkCMppHpK+RYuG1JMtHj
	 dI6wSzdMc08c4ZuifHoVaqhpZnQEojJCxrXfdmZPWREapITPzbDN39NxJWaTvsY2+USww
	 9o8KdbA2R+XS226eUUfa6J4CDzI7HohhKxjqQEj1okaKKKVPMBcrX9Lfs4n+5YKemule7
	 mPktFeWoYk7dyvWfqrykLacrkaYaEDEuDd6yBMguBKWhoktmiElGB3rt+O8QexDT20sss
	 FBGPFRstAPfj9KowKkAAfSKzEJhuoFCXgnt1gGtwnSQFe02++yIKxW3LW0VCp6rJ0DA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=EPsNz4yR;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ehfiZPjA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC0606A319;
	Wed, 21 Oct 2026 05:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DAC0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=EPsNz4yR;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ehfiZPjA
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L2DpT54095361;
	Wed, 21 Oct 2026 00:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=mKp6M2WTSARENmYYx62aXLw9T8dLsocf4luZ9aU4K
	wM=; b=EPsNz4yRTb+q9eXm5CdIbrJ+h+kHyH+a3gxdIRmw7qB0ZmLShGzwDreIo
	BJJemBIDN/EpGMK1vqyYj48KnS9rPTdU0MRDvWRRfbeEpYRFH0S/MARAtyahORvG
	Zjllhe+jCARK2nHQZnd51BCzEVLiGe+6yWDw/J7PcAead9wkaePAApcXx2i4h38O
	L98QtMyzOJ6Xw6Q/oREg2f4+YKtnsI//osE2sHOVYs0+mHk/Gxy50V9WsWn4UPm9
	LlPgM58lyDv+rWf17qrVkgxULcMeCSAUZRFd7PMPDmK8EbZQQlVSOdipoBlSx5Y4
	dHQhBt5hfnERPsUojeOLBqAS+k3/g==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hecukbae2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 00:25:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEnO7/f1phFCTxbrAomHJ8wdz3VRSIWYwpldYCu0Jm19XgnLEzK3DUVyw340nmd+cxXZC+4bpxvUZXNvQUgKdoLbCjjDeNYIncvZ9Yiynu1dXpb4XgfT6PSPVmU+m/XlxNOj7x0o9TYH2mw0cx51+kZPmCqdxcg2DC1+kLQukMADwWBViT44Pnb1X6dfqWbRljkcKZVgeDlkHeR1hAbw9Vfl1112QeO+LB9vwLPMTpVgwxd9DHXpXPx6qChhhFfeTacWrDtIjQskFE+4RiALjAjFb6wkCtJYT5eMKaQmCTxc6+wyE+n72I7zj0vcChAkeKRV4UNvCvYJFCzZ5idNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKp6M2WTSARENmYYx62aXLw9T8dLsocf4luZ9aU4KwM=;
 b=dtlG1h5+nl33p2EkMLhe+noxXvh8NkoooR2rRWqC6JcxLMEiMShXSZk41jRCVgw6xJHMqw5CMkwsuyy1gyI35T8A69TCeDfFt35+7BjWLOhd3M+kWA2JNg06H9DmYxqJH6sl6yVXGMkZAkd3QCWphFqZS9eb6WyYEhLqkR2M81OLzB4YFX/iBss48FX4yKK3D1sxAqvI+df9mWyqW/i6/JHdKT0HwlBZ4kDlmOUOzAi8rRas5Dpjaj2eqNB3goTqpmXAsoVMCZcapncwoJuOC1+HrluVPwV7KdDXr8oN33I0krnEC9prn8BX18DurNOUmP/aPj6VaAJvVrovtLJwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKp6M2WTSARENmYYx62aXLw9T8dLsocf4luZ9aU4KwM=;
 b=ehfiZPjAGQtMgtKMOJILmjayEglKBUOcw6zykIgviXwOZE0x6BxjACNgM+vsCSSvOpspUZjRUvrWw9bltMl7/O3G6Y0qiVWAqRVPiiA1CjzG4Q5/MqfeAeiQcGuO2r9boFNFsvpRXXTBt6RRTjRgb+3Wgo/bSnN3hOcZkZzg/E4=
Received: from DS7PR03CA0350.namprd03.prod.outlook.com (2603:10b6:8:55::27) by
 BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 05:25:25 +0000
Received: from DM3PEPF000265AE.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::75) by DS7PR03CA0350.outlook.office365.com
 (2603:10b6:8:55::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 05:25:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DM3PEPF000265AE.mail.protection.outlook.com (10.167.23.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 05:25:23 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 21 Oct
 2026 00:25:21 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 21 Oct
 2026 00:25:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 21 Oct 2026 00:25:21 -0500
Received: from [10.24.53.39] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.53.39])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69L5PJZ41961055;
	Wed, 21 Oct 2026 00:25:20 -0500
Message-ID: <4887de0c-eae6-4e5a-90c4-2398214c8cb7@ti.com>
Date: Wed, 21 Oct 2026 10:55:19 +0530
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rtc: Add flag for dynamic hctosys control
To: <sashiko-reviews@lists.linux.dev>, <linux-rtc@vger.kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20261021042435.3895543-1-a-kaur@ti.com>
 <20261021042435.3895543-2-a-kaur@ti.com> <sashiko-outbox-179788@kernel.org>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <sashiko-outbox-179788@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265AE:EE_|BY5PR10MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: e311f258-c3dd-45ec-74c1-08df2f33b538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|6133799003|18002099003|22082099003|10067099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5YiJ7DgSK2vIebasU+03k+/fPg5LjDaLb1TPFtHapSuj126lFlD4CZF/ziQFv2vRI4vEeBpOzA7Kf0Dg+XFC0nwneJE2C/j0PIPCXEH/BtbgZoEpJpTUUxH1Hm0GmqB2/WkHbIEE4/EoXrt0E5dFSvDkoxmCizubapmWRU1fGFPFbM13LFI58u9SsMdKaybPvhIdzuGy+XoIj2ZrVbgd/0yMWv7B9E+XM2/jg1huzt1WV5tOPkKdJyE9Ar6Hgsh532PcXVFb0gBScyCkubBKg3csuij6EsaoeuPtxRsQ6HQ8q1vTbuLHySBS4zn7ZDG5ApG5PAlkcl8UNoZTUN6wA428i19WHfzen3+/uDBgzuqKrJH5exUs7zNQOKOW8CsA/nB2EYmkiHtNE+8ffZDMX7AHJI7Vj5iGBhENOhjcFQfy/TGInXlJJ2VnL3dL5wkXuXioObxe4b1FQb86pdcXc3U9Ip0YSFVA0CXPZpS/Ah1hlAyR4gwUb//50VCY+dgJi/TwLx9tR519W2OaCvAegK6okq5nTpJtDEsS4FNU4HRDzlskH+cc8iIN8gH87Xb1+iaQSS5YknOvDZkwqgN4+GE30xB+YtWJLtbLJqmBKtWq8Im0GPPV1FHw+gQBUn3qGmChl6pZmL+dn61UvlUW9fL8OAeCYZdXSSowcPVgfjOh7MhMtrukNLMB6MObzFvakP8SV/sOw1GNeZ2TYC0z/A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b+VUz8ov+WOQ1a74Fptv4SKgO4Y0vvlksZW93Q+EXF4VpRBFjnhtrjl/qffjRPh8E/mujKulefg0G078QPqNAZLWaRa8cFZY4I4inTbr0q3mgCFZ/9ete/WdXT2+bB2XF7tbeHOkSkmw2N1NVcrsYh/H/pe415/ujkfVcnbIgmkFjR+CBqGxak8JRKuzCmay+T3Zzm+s9f+sZ+33cgBDVBoSXazMh093MXbJPdTb2QgrpRB4ivHHYbcOsiW1/kDyOtdawx4+sdGp4kFmaj+/i0jfMcW3uSiUMFfasZfdzsvP3FCGwM7doB3zUd9Bec6VpjsD//mpGw5IPXwjGp2ST5WgTNKxg0rmrj8nZuS8nVk1+2Cx4sueocAzg//R0hAJDxlrBELX9XK6VS8bxThEECR3ZVrnszpGQqBJxquo2GF3Zusj6jC/rzUSQ2JQ4LNk
X-Exchange-RoutingPolicyChecked:
	jCDf8Qr8S4OTMj13lXXfkSo+EffFyUUiGunBdbeIs6z/yVF7E9Jnwdeua261PmJbYgcxV0Nv+/As0iyoGW8DvWsCG8zBNq5vp4dtfd9/URPhSLjmij5GQ2xwXjvogwClGBAoaKMeYb+dGBcVrxYWWm+Kho73+vOn1Qlmiapt+m6DdqEg4tZ2/cZ1RahYmu6hENakM3w/jBIJAP1wggr9IZ57B1pEgvH1Sgyqc85soynO8T/POhRhABVZDqbUVgwcsGoic8v/3gicJGQMmzUDTO7BSiIJ2e9inm2C4bMYySZRC7gr8WnBteor8iUZgWoelLOKDqnsjj7aVzLg8OGwLQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:25:23.9109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e311f258-c3dd-45ec-74c1-08df2f33b538
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265AE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4337
X-Proofpoint-ORIG-GUID: 2ZGXa_dpYv1ahkulUxyi0deT8DKkqkqs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyMSBTYWx0ZWRfX/h+URDtxPR8u
 E8vq3S0wTkr7oJeDpmVZzCi/YYw1/VPrgGD7JP7myJT3+qCfNssIG3R2liEAa38pYUKBcCMrXe0
 7A3f4dCj+FSOsPWVg8TRJxzoS/vjj4KEHt4hEo1dUgEfFR/mtUmL4ZJItsxh0JuhkFN3TApgYio
 od7mzONFa3Sjm9UQwfVBZeDU3zdxpqnU5kUWvyY5hbK3LvAdmjumylcNRYevmWYNUNvbaD9O44D
 TCXOFS5tjrlzk60AkVPOK5EreHrnPCArcO6NDZXU27Omw+TaBLDgRBIIhMFKuOeXTdYGhrJjmQi
 jvoJrGToZSbpsxkOUKa4Z9vwiLg9TcSRtN7hU7rIO+gkZig44kcnTw86D64qpv1YK6lGT5xW8v4
 a2jUm8TOll1rEL/mf2eHNdAfgE+Gr/NhMh+mJGYewlzyYNY+nelBVBXpgPvAaEGKbi4LledgeOs
 dQdCDmjfAPG16UesVxg==
X-Proofpoint-GUID: 2ZGXa_dpYv1ahkulUxyi0deT8DKkqkqs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyMSBTYWx0ZWRfXwMxY7AYy+cNS
 BF/5gmgsg0FTJynz89Ya5RmLgnNYXjNfyw6l6fn58O3PtqecvmGh5TVAzuOJQKnhBEo7ZNtZ8yw
 /3BDIJxRdbyON3XGjDkYI9xcw1inYdE=
X-Authority-Analysis: v=2.4 cv=dfwVTnXe c=1 sm=1 tr=0 ts=6ad84cc9 cx=c_pps
 a=ysgzExocFkmHQmNOaQPFvQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=0-KZwX3OBq9UYba18jYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210021

On 21/10/26 10:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] rtc: checking time_is_valid only in rtc_hctosys() exposes invalid RTC time
> --
> 
> commit 378dbc5f51408e7a59e18fa3e61590784e92a232
> Author: Akashdeep Kaur <a-kaur@ti.com>
> 
> rtc: Add flag for dynamic hctosys control
> 
> This commit adds a time_is_valid flag to struct rtc_device and checks it in
> rtc_hctosys() so drivers can prevent setting the system clock from an
> uninitialized or power-lost hardware clock at boot.
> 
>> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
>> index 01ba04028f1f1..cec27c476545e 100644
>> --- a/drivers/rtc/class.c
>> +++ b/drivers/rtc/class.c
>> @@ -63,6 +63,18 @@ static void rtc_hctosys(struct rtc_device *rtc)
>>   		.tv_nsec = NSEC_PER_SEC >> 1,
>>   	};
>>   
>> +	/*
>> +	 * If the RTC does not have valid time, do not set system time at boot.
>> +	 * This can happen when RTC loses power or has never been initialized.
>> +	 * PM resume compensation will still work via rtc_resume().
>> +	 */
>> +	if (!rtc->time_is_valid) {
>> +		dev_info(rtc->dev.parent,
>> +			 "hctosys: RTC time not valid, skipping\n");
>> +		err = -EINVAL;
>> +		goto err_read;
>> +	}
>> +
>>   	err = rtc_read_time(rtc, &tm);
>>   	if (err) {
>>   		dev_err(rtc->dev.parent,
> 
> [Severity: Medium]
> When a driver sets rtc->time_is_valid to false instead of returning an error
> from ops->read_time(), checking rtc->time_is_valid only in rtc_hctosys()
> leaves rtc_read_time() in drivers/rtc/interface.c returning 0 with bogus
> 1970-01-01 time to all other callers:
> 
> drivers/rtc/interface.c:rtc_read_time() {
> 	err = mutex_lock_interruptible(&rtc->ops_lock);
> 	if (err)
> 		return err;
> 
> 	err = __rtc_read_time(rtc, tm);
> 	mutex_unlock(&rtc->ops_lock);
> 	...
> 	return err;
> }
> 
> drivers/rtc/dev.c:rtc_dev_ioctl() {
> 	case RTC_RD_TIME:
> 		mutex_unlock(&rtc->ops_lock);
> 
> 		err = rtc_read_time(rtc, &tm);
> 		if (err < 0)
> 			return err;
> }
> 
> On boot before rtc_set_time() is called, any userspace read via
> rtc_dev_ioctl() -> rtc_read_time() (such as hwclock --hctosys, timedatectl,
> or chronyd), sysfs reads in date_show(), time_show(), and since_epoch_show()
> in drivers/rtc/sysfs.c, procfs reads in rtc_proc_show(), and alarm
> initialization in __devm_rtc_register_device() -> __rtc_read_alarm() ->
> rtc_initialize_alarm() -> rtc_read_time() will all succeed and consume the
> uninitialized 1970-01-01 timestamp.
> 
> Additionally, rtc_set_time() in drivers/rtc/interface.c never updates
> rtc->time_is_valid to true once a valid time is written.
> 
> Could drivers return -EINVAL from ops->read_time() until ops->set_time() is
> called (which already causes rtc_hctosys() to skip setting system time via
> rtc_read_time()), or should __rtc_read_time() and rtc_set_time() check and
> update this flag so all callers see consistent validity reporting?
> 
> [ ... ]
> 
Thank you for the review. The time_is_valid flag is specifically to 
control boot-time synchronization, not to block RTC reads.

The RTC hardware is readable - userspace can read it via hwclock/sysfs. 
Reading "1970-01-01" is acceptable as it reflects actual hardware state. 
The problem we're solving is specific: preventing boot-time sync from 
overwriting correct system time (from bootloader/NTP) with uninitialized 
RTC value.

Returning -EINVAL from __rtc_read_time() would block all reads, which is 
not the intent. The RTC is readable; we just shouldn't use it to set 
system time on this particular boot.

Regards,
Akashdeep Kaur
