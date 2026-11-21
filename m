Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.99
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795256094;
	b=XJSK3Y6q2UbxurYyQUW0JhYNa+LW8MkN/7snzsdMJ30wvHryMO0KyMq5YTha4z4GYljt
	 ZjsCWO6232yRKFz8TedhcncA1785dthbsRskG43dTYLUgsfdL7q+kpWSYYV/PLemyyygg
	 87zz3QFAX3RD+1q67B51l/nQ3S7wubVGNT78+1X0HnBF/T+q0QXh1YKv28/vGYfgPr9mz
	 RKyaGqW1WJ/mBYrS3kOk3rk41fWteOGFu4isDG4TIJhF4PkEn9fDJp427tWyliElHClQ9
	 /H03kaTUtKfpBaM7EyrqYFeUJ11bMPnM7nNLNZqA715NRdbHZZ7UQsLDcfswf96tujg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256094;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xbo5T/obyNAV+/KQ7LPQIGfUQr6bR9eYwsRe2AtOm6g=;
	b=d8FBnBRWgc5npEdRxu00pCzHJ3uwvtb7e9a0sHqe8aKMMSbVmJplySrZVSgprxE090cL
	 a9oFLn8IS/UO0NEsEShFs03/YTvOdVm/iLUJF41fldz8XPND/gL9mM5exTwyRZlDTOvT5
	 Ql5Fe6gMN0X9Ici0S8vPKpHlPNDc2ihFeR74umxtru6tMhxUlTLk7sF4Eu+nUXO5oZ3RH
	 FkYyTENZZ0nItgn6r60M3jUfWj0AJxSCZNd1X2cUcy3lgoE5y1yYw8rzpkM5xc1vNPSEj
	 ccXKfo+tNVh8/vJRXCMwHNoK5m/ZHkSJebtA8w+ASCDI5QEsZR6rPZ1pl0kxia0N/Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.99
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2099.outbound.protection.partner.outlook.cn [139.219.17.99])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C6606A320;
	Sat, 21 Nov 2026 10:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 576C6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kz9rPs6JNV9wGcOr1lmwpEnm8CGN6GKbQNCabCGjinqFQH5qJN+KhoGITSYYPB0NInfu+5Nts2kU+KhbP74G6SaTQ/SBqcopmlLhHNxVJpXZaZNFYJhFcYU+2ts5aZi+V72b25ObC/csAuQDT/I5U+2xL8SQtJ4Z/rDgHI0ZnssqK9awWIA3v/w4HZNidrKP6QruM8QwIqxxB2MLzxP+9NDX1O5UCloUoN1emJ/EIgJDGJUkVNglXJcQY/S2q8bru8BXv1X3ucvKwshNxWKbI88F3HUjTKQ3i52/JlONdIvhzpIUrhWGZMf3K5MdsU7I4l/wnpDCPgJej2c6AbcdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbo5T/obyNAV+/KQ7LPQIGfUQr6bR9eYwsRe2AtOm6g=;
 b=OTCveLYzHZcm3eHbuoVWt/6G2gxdd7VNC/Ep5/YloutaXE5iIZ01GIfrqcnn8kgQzVXGTEBhMQdvFyX4zn6T1uHwxSV00V7d/7wmHILrrfZ+GfV7r4pzPZiDGyJKkYgZ0psibBRkcqkEPHVbHGrq9LInamlYEAKEMvBZrG3dCU3DT6Ed9IDk4UpAzH4CL0giU1tiF1S7OInEjU5oa2/cFDXru98uoBI6riY4GN/ZiYGuYXtSZH4yE/rUDdMh3U6n1Q3aYt3eBHwlxaiKau5a0nBms9Ae1u3T4fPmgOPKGu+YSdSl2MsAfk9GCr+Hy66hkqvGqsyTMbCyHEswh1QDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1213.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 21 Nov
 2026 10:14:46 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0615.009; Sat, 21 Nov 2026 10:14:46 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: lakshay.piplani@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor+dt@kernel.org,
	daniel.aguirre@nxp.com,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	pankit.garg@nxp.com,
	potin.lai.pt@gmail.com,
	priyanka.jain@nxp.com,
	robh@kernel.org,
	vikash.bansal@nxp.com
Subject: [PATCH v11 2/2] rtc: Add NXP PCF85053 driver support
Date: Sat, 21 Nov 2026 02:14:34 -0800
Message-Id: <20261121101434.16942-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261024110437.2851275-2-lakshay.piplani@nxp.com>
References: <20261024110437.2851275-2-lakshay.piplani@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::10) To NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1213:EE_
X-MS-Office365-Filtering-Correlation-Id: 418e4445-d333-47cc-af84-08df47b844b2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|38350700014|261102123227099003|56012099006|10067099003|261021121427099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	yBa1PwoX/RfNX9YpY6lsjmZpluDfQ2nqPSVqlwrMZlYDszKKBfZrnfvzWBP19Dl/YLtrVTTP6Xqy9mUZ4WPNT7ufqloRWJXMQ+QZMIaRCDP8DJF3s1SSMcSNX0nJpFCS4mAfGKyMTEpc0BSee8P50ziZtCd/sQpzhbqTdbvjX64p026j2mca7km0lUNwPyr4MpX7xjdkmcf012QN9lZXEnnycjAprkLR8CBYOUtCJwm92dyR9tskuPlC/HcMnfoKfmhToQpqxEng4NqxxDzmcBg8st6TA4Yn0ED/G7Un6T2Cwdv/1S/3uz/Uww8JMgEz+ZW+zT6QfDgrQvFJNVDL8XtU3dcpjiECI4o3k1m8s7p30QFV9+/hNc/Ums8zd5Ur4gFBLXGPYTl8S+WpP+ewKpNnkFhIS+YYD4FM7f/UJHovof604Aq1gJ6zjXV2yyWYKTpMr4tdN7D1PL/u0jt6rAAYZmq56iLWU1hBLtIKK1Vlr1EV58af1ooiO4LhWbM/sZ7VvkHSR983fNJ6ciU7pRVY9mO9vMIKuLMiYrG7VS+HvMDD5vwOhRdctWtO97ee
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(38350700014)(261102123227099003)(56012099006)(10067099003)(261021121427099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ax76MyErs4RO9xZtyeb43g5Q9Us2Rl6bIMsY/rjNJQvCHZWUdScL6NqdUFQx?=
 =?us-ascii?Q?fnV4f0gbda4OV3xpWuYnzIV3ApU6cbFQFTgkdOQ+ZBtjP8JwXQgBW+JHuFV9?=
 =?us-ascii?Q?pCoQvq3whoDH/1pm2oKDsKjPwVBxK8EFwmYt/XfIyypPSGz6Ai9QVwL2tN5u?=
 =?us-ascii?Q?4ub1D4r/PK5MH9Z8GYm4OKV+dQJiTDZcfP6ht3FC4bhr/jDkm8iLvmh+7yCM?=
 =?us-ascii?Q?UoeOJlqNbetfFKoJIhzAPyxPtP3HKdDTg7KIwsuAmUQzQDtiTDBhhEm6GH7G?=
 =?us-ascii?Q?1ZGb7Pw2ldHjGLnSHT/+KIkuhwOqL4zE/s6/OVPDejMV2iJtybpKypFeD6aT?=
 =?us-ascii?Q?RugDf/lsIJPrR4BVuGV1Ch3EBYXh3+I2OKMON0yZLZ314IhAwuLZfzMVwBee?=
 =?us-ascii?Q?+7fFLQJTiauCIzz5yxv1BFRZNVYK/rb6C1vw8dWkXppMIitPTaD4WygB5XSq?=
 =?us-ascii?Q?g7z01p6bxYjq/WgO+PM9kvoC5hmmZssq69rn5TxTMRmW1m0QqBENsu6WZiEx?=
 =?us-ascii?Q?6UhkK9FLRnMmWvbcpex4nS8cVM8nhOY2W5tbqju6UDl9wIRbr6NcRMi6Lduv?=
 =?us-ascii?Q?+6/F9hMhjiJsqfogrKke1LKolRghj780mhdzqcRe+U5wFSyJfez1ptDogB4x?=
 =?us-ascii?Q?69HCsSJ6i0TgSKwh24C9CHFtrMWMWIxTSWL1480hSlAGg6RIk0f21HohR245?=
 =?us-ascii?Q?1JSq+w6/TgeQdZhpuLjoiJRoVsDM7IFxNLy2j1f4udqeYiLYoR+2Ua8PF1zs?=
 =?us-ascii?Q?iO8I31pu750lKbxa7//7W5JtyUb3aR/SxKSbCCfuUi96JjIDJG7XSkOxLb6H?=
 =?us-ascii?Q?DTCTKWLgq3Y1IAAHbDHmrrBSudQjrJUfXfTDnO2GutvaB6agGYPyO+BybyTC?=
 =?us-ascii?Q?sfTEOXFOh7FSPJF+J6q7KrqBCuhGVqP/Pab+hFdrEM1cNPbniWNnUZbgFIIq?=
 =?us-ascii?Q?7MHS7jc2/E2Cjhci6Y40731G2nHMKAXfn+GK0QeLFHHcKVFymzUmuY3kmF0H?=
 =?us-ascii?Q?nJmmsy1oCqfxo7G41fnH9u1XXtpHqnblTUMAGdifnnrCa4A6lewImwR3JksC?=
 =?us-ascii?Q?y0z6lAt8xpkmXkcT91P1yHbXTxq2cBqoG+rGDV9CZHkXpDHtV/AQiG0DlSCD?=
 =?us-ascii?Q?hS0LRnxOxOytnaQJuM6oGZ6huC4wPPZiQvQCWoQDv3GHhpJnTfT4vaCIEfTV?=
 =?us-ascii?Q?FnkOQ+aIUKTc01hGlbbjrk5tjxdHJJuKRipQzQzxNLVxDUbbdJOyIuoIQRVs?=
 =?us-ascii?Q?4RuqZWHCIFBifNSCJzsXU7TbwClG7C33fyF2sibNCiNhUuK9fVeMFHPnbDaw?=
 =?us-ascii?Q?QPYqKo0zbEETNlz3+UN75qNibqQ2iWpfsM+n3RTsiS6dn6WxznPRQkE2dozN?=
 =?us-ascii?Q?rCeSchlrM2mbGbfbatA6HcNz4yBkotXjQHwuGwAgPt2S6k8VC1Mij0xY3ua8?=
 =?us-ascii?Q?G4Qg9VPljTUxIS8kwR2o6h1nZs9UeDDjNLvNcROqjkLIiJFVCIODHnkWf0jM?=
 =?us-ascii?Q?Jou2xz4RsFy3Hd7awNCfYJrKy95abIQ/0HX3Ve1dSYH2yXNN0ZjdeiEmrUWf?=
 =?us-ascii?Q?FVhp67msFPzAqUW7n++1pA8wTA8Bl0DTHQqsaFe77/Tre40f1yjTeSsyIxCo?=
 =?us-ascii?Q?mZ4XwDMYy1GscZ+YXW5n1aj1JuEvwzcHTSjau1vtNaJk47yr7bxf6DXBUgiK?=
 =?us-ascii?Q?u4TW1s07T0Dz2BN0c0uotssFp1rqE/Njx+T2Ch/wr04NQ94nrrU5gYyIvBio?=
 =?us-ascii?Q?+1EfJu6/WBppFeFnOtVRqnRTNhX/lkWy9+XbIu8njwNUUhARrJq8?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418e4445-d333-47cc-af84-08df47b844b2
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 10:14:46.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWNnvMGDwI2pQILzVMd6dIK5dtIGcmt3bsqJGIZXvD+0vGJJOnpvjFxDt28EGFeu/5Z0Y91W97veoHuPxKNOmNWZBrLIwBkrFdE36HWUprkI75/6R5lwyHWJlL3i5EOB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1213

Thanks for the patch.

> Date: Sat, 24 Oct 2026 16:34:37 +0530	[thread overview]
> Message-ID: <20261024110437.2851275-2-lakshay.piplani@nxp.com> (raw)
> In-Reply-To: <20261024110437.2851275-1-lakshay.piplani@nxp.com>
>
> PCF85053 is i2c based RTC which supports timer and calendar
> functionality.
>
> Features supported:
> 1. Read/Write time
> 2. Get/Set Alarm
> 3. Wakeup Source
> 4. Generate up to 32768Hz clock output
> 5. Primary/Secondary i2c bus
>
> Signed-off-by: Daniel Aguirre <daniel.aguirre@nxp.com>
> Signed-off-by: Pankit Garg <pankit.garg@nxp.com>
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Test on the StarFive JHB100 EVB1:

Tested-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Best Regards,
Changhuang
