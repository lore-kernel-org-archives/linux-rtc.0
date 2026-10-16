Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37398364052;
	Fri, 16 Oct 2026 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136484; cv=fail; b=bko2zKAn6gIAthkaq91ysRY+vh3Q43u7hUTwkJZPCxsc4F9LoCHQYfDR3ZbvINiH4E6jGbBjfdm4YkexqS2tVxMtBcezr7/8vJASifkoZ9O8WXWT7d302xpoHxoKnOMrhM7DKZ10KWG0wqY1uXn5PIOT8DymY9HF9AIL8uch5rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136484; c=relaxed/simple;
	bh=IA9a4+EjF4kDB7uTnmBirAW78pVCQ4wJFVZH/JnuUIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aTW15sSQGi+n0FtAbXhINHFslruLfTR9xYfgv/2jT0NuwLDoqbsMbCd8paGWk0MTCmxmvu8kTwrU7pQfYd03Mfw/eYKqL/w1ok34awEk/rqeik/0+N/U6uG6VYFs/ydOBmy3t4q8xk2TQmKrKhdxlO1ynQns07hQsNhXVg/lFeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=AkCFxIIE; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="AkCFxIIE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPxxGza1gjV6y5D4CdFxd0i0fVcWpBNM66O+uBV1zaZhALsSDuae9Xuc7NIC9ou02uqeKcCtYr8mKIU7tcnfn57I49jRDisDXbszPjnoXzXo6Ww/lRvNlCgtVYDTuBYfSDV4T7EizKLW3mLTxwHJMu/I69ZKLoK9uZbYe5PbCUX+HcjumP1+lg9imh0fm5uefVY0rRKh1YVKG8lJZL+TZaFiy22JRRbCxSJQ4uo1OR8mpgYAx+L8c8e0GvmQ3ZYjbBZsLQqwOr1MvKYio526YRq8n7Fk7FBSHOyiZ4Yd+6CNeMQwQNcIUooJlya9SkeZinHVx/eRm3FMVvya/wkqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dltc9RZsbtEym76LXISFCmx5CHXnHKsrh6hrIgb3ao0=;
 b=QKd2GiqHDYQUeBGgFta9n5pjvU8stNKS0pG5/qCg+7khXPYCGYa3mXvN+uV03BOaBZVV3Rv2ocxq5JMAPypGWKrjl/V3ZRzfSMEuhvk/1AYwCpcoejSzcG9r3vtaByoZqHQdVhiaL1chouqu9its+WMWwr8zFwHXDSTe8WSt3pxNhgfNX4BSiXsTOTYsH5qdBdNI+SZfa1yKGf10/3hn52SXOsH+QxIk02F0f3pP7nJZljvDlRv4B3zIifZQ56A257opkz73jd1cHz4rp4fgipxU/fmlR95LZvP/We6mEbR/OJ1k1obT8dT4GiODB5hn44wzxscjYaBCTYS1cHPseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dltc9RZsbtEym76LXISFCmx5CHXnHKsrh6hrIgb3ao0=;
 b=AkCFxIIEouZoTjlZQlCt/ttfubq+iNv48+vx8an1SO+hnacmusEmxwggirAtgh7cLUUe4IUbd71gY09kfj5oQ8EcuFRidRY01v927eKxYeBOnK/I7QSwN7YkYuKhq3k/A+uQaZLjgLreu3yO6aqCusrNTWrq4Pibba4jYbyxxCg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from PAXPR02MB7344.eurprd02.prod.outlook.com (2603:10a6:102:1c7::8)
 by GV2PR02MB9590.eurprd02.prod.outlook.com (2603:10a6:150:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Fri, 16 Oct
 2026 07:41:17 +0000
Received: from PAXPR02MB7344.eurprd02.prod.outlook.com
 ([fe80::f0f2:8c3c:c869:c51d]) by PAXPR02MB7344.eurprd02.prod.outlook.com
 ([fe80::f0f2:8c3c:c869:c51d%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 07:41:16 +0000
Message-ID: <f3fd611b-920f-4539-8edb-ecb173f715b0@axis.com>
Date: Fri, 16 Oct 2026 09:41:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rtc: ds1307: Add driver for Epson RX8901CE
To: Fredrik M Olsson <fredrik.m.olsson@axis.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20260629-ds1307-rx8901-add-v3-1-302dc3cbb71e@axis.com>
Content-Language: en-US
From: Fredrik M Olsson <fredriol@axis.com>
In-Reply-To: <20260629-ds1307-rx8901-add-v3-1-302dc3cbb71e@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::27) To PAXPR02MB7344.eurprd02.prod.outlook.com
 (2603:10a6:102:1c7::8)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR02MB7344:EE_|GV2PR02MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: f046ee3c-62c8-4dd9-b200-08df2b58dbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|22082099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ygO5a2a51IhXeX3diXULS49iLX1fuiQkpzVY3nNL4i83jiUv+X0pRVy0fPbdcvrjAGPni/ShWQw/N1KN2f0RVhTt7y+jeH76Z46j7XFEowj8cwhRs7RDczesU/yJRceIRAVsmM4JAVNKWiBkCQtyal/f36UPRnjWEfvU/PXM/ft0gjDxUlCgzQFzKDJ93eW0O9okvuPOLTUyYBEd4Rti9wHexUH8vysnhDsqITvh7/kpjuYh7aW5V+hY3NqEPIdKsTMOlVPSdxIsXRzelGJk+qv7AqTAUGEZvo2y2GhWENJdFRsp+zBocS/UGPIKDjL3OUQGDSoNBoXSiNYLeiMe24rGMN4Oxn4eYDiA413h4LHTWMSamuZ8XzwsLmeC3lU6IwrHFeEBWYT7EY/ohoH8P3J87rlZxiBvOgpNJ913LAAfbOwfgw45aCW84R10r6NhlIXRzzGo2mj4FYpO0Sc7l2vjtydl7nZzuTxIpphz//M/dRxQJqo18FbQgn3K1crDzeVDEyaTVRRZdnzF5n/Z8xYqQI5pOUm4MRXuFy80NYacsOoR+UZmPqJqkW4C9V/uM/lr2tknH2jPmNHBG4M/PkpHhkrpslZZkIl0eDWBKOxjOjo8OZJLyUd8A8zJBUht
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7344.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0ZnSml6UnZTREpEU0prTE9hN1ZFOWxRYytyYUcyeldLVDVqV3BacGhOYW1n?=
 =?utf-8?B?My9wSVl1QkJ6OVMyeHNZTVJuQWorR205U2N0NmJhZjh5VUt3bURYbEN2N3p5?=
 =?utf-8?B?MkZsUkphMjB4akhzV0lmblNqRnNzeXMvZmwrdFpKQ3VOcHdPSnRyL0d5L0R6?=
 =?utf-8?B?UTRtbzJqdExQSW4xUGVHMC9BZEplR2k0ZnZlV3ltZXJsZE1wLys3ejhyWkc0?=
 =?utf-8?B?RkdWMFd3SWRWdGFpZlZUWktGMVk5aWhXcGxEcEJqN3dXWnFwdWJUbmdpTFZF?=
 =?utf-8?B?OEtCRzlucHhvRklDSXVFREY4bzNBcG8rVG5oWi8vZXFWVmFiUGFIZ3libmht?=
 =?utf-8?B?bHNjRUdxVzVySWZVdkZHSlJCRU9mbytYSXVBQkFpWDFISjJPaTdIQXpwenR3?=
 =?utf-8?B?aHJaWDdYVHFCK1hQWmFhanFSM0lQWVFwQlFUUXVFNVpZL0VZUGpKSFZmTUVy?=
 =?utf-8?B?ZVRMMXlSSnNpc0xUczRuVDl6VTdnTjBqZDJCQm1hL1pNdENxRWJySkM4eEhN?=
 =?utf-8?B?M2g5UlNoN3Y2K0hybjVTZlh3V3FGbDJkUmVkWVAyZCtBMHZ2UzBVVWlhRWlY?=
 =?utf-8?B?aUpTMlorWk9saHhRRTJDZ0hremJScFVVR3BxMkdwTmd4cXh1cXI0Y3dyWDJq?=
 =?utf-8?B?ck9QaEhZSjNmeXU1dDdLNnQ4bVBCcjArbTZCaXVoYk5ZS1kyTnNqMllWUGxE?=
 =?utf-8?B?L0FXQ1QyMHJzbVVKOXlLK0p2SHYraVFaZnFMQ0V3OUczbmt5MFp4Z3VlRmhk?=
 =?utf-8?B?b1BZU3NEcEtDZmNuR0tFV1MzZXIvMU5kRXFsamsyMFhONjNxWDRkWjZqNm5B?=
 =?utf-8?B?RDJTcWU1MEhhUExUR2hUWVVUL29oV081OGI3NVNvR3RuMFA0ZUdmTUFicVNE?=
 =?utf-8?B?V0Jlc2pLUS9CeFdwd0EwcmszRFl0WTZhNGpNZ2JCaS8xUDg4YjFNUjJxV3dy?=
 =?utf-8?B?STFYd2xRVWFyWWVMejdUUG4rcHVJZGNxRTFXakpyYm5saDU4TkhhbTBxRG1a?=
 =?utf-8?B?ZzAxcENaQ2JJNzVxWXY0WEdVV0EwVDFYQkV6Uis5QUhQMXBJQzFSRlg4dHNU?=
 =?utf-8?B?M2dWM2tGT1BmYmtxME5ZNXEyZ1RhQnBxQ1JFR25PYXNwM3NtMExhUE9jQUkz?=
 =?utf-8?B?SG9OWlQ5WWhCNmQwWGJnT0FIZmdWWis5SU1VWktoTHNZREN6Zk5MM21Nb0tM?=
 =?utf-8?B?VU5kL0lXWGJoRE1nV3lLRk9LZ1BnZ0Q3VDlidmRuRzEvRmxuRWxhTmhPN1I2?=
 =?utf-8?B?WFRIUnFGSGVkcTRjUnhBU0pmK2pBS2dJYU9wWVJzbVpWRzNOSis3enlXall6?=
 =?utf-8?B?YU4vekxjR0toVWc3SndLTlJTZ0svRkQ4bkgrUGl2ZW90ZjRlbTNCUVVjeTNi?=
 =?utf-8?B?N0VsZC9RVm92dys1UVBOYzZSLytVK3ZFQmxYZy9ydVhpUzFUWXV4UXpmT2VE?=
 =?utf-8?B?aEFZYVVPUVRxbmlJUjRmb1AvY3Q1NDNnSDF6SHZ3a2FKU1RIeGxQOEJ0Vkhn?=
 =?utf-8?B?ejJ1L2p2YjcxeGNoVkFaNWNhcWorODcvZUk2SjdZMERtMmN5SHJ1V0NtZm03?=
 =?utf-8?B?OVdWWXhpYXNJNW9aL2pvSlJOaHZxRmlXWG1jRXFKUTQ2NExWSEt3c281YWJN?=
 =?utf-8?B?QkRyZm9zdjZsYi9JVEo0UGdRQzBuK1d4clQ4dk1oTVhSOVZleGJ0QlpXa1k5?=
 =?utf-8?B?cFhpR05UamQ0YStjVFZrUTdSQ01TTUhVNGRzVVJSS3lNRzdwZjRaVW5SMDdn?=
 =?utf-8?B?amVwQ3ErUkFoUXU5R1dHdEF4b2RSZ2JBVmx5WEs3bUlwbkpabTErUk1sWXBL?=
 =?utf-8?B?aGRFcmRNd2RoQkVLQkRuc1lHOEJzTUp0Z1hVMTRmTTZIRjAzbUg0TGxxVmg4?=
 =?utf-8?B?azFPQzYrL3VCZE83VnBXaENmMkFIMnV5bmZGU1RpOTVjYk56d3RPNlpRMTdp?=
 =?utf-8?B?NjZEVmVrSCtqTHExOFk1alo3cnI1MFp1U0MzTFc2ZVdYdnNzWnhJSzBZMFZO?=
 =?utf-8?B?K3JjckM2bXBzL0d4SXhiMVN2QXRsSFJPSWc3Q1MwelMyeWNKVUc5RDF5bXVE?=
 =?utf-8?B?TGNleXl0aXBMaGVIUUU0dlovZjBxT2E0UmFKM3dnUGhicGdZbWkxRzBpUGlP?=
 =?utf-8?B?U2FQdVFTaXlOTjVoeUp6Qkp1aHBJVi9hS05KVTIyV0p0NEJjTWo0UEQ1NVVL?=
 =?utf-8?B?UmJJZU9aL1k2WHpTZks1M0ozMU5MbjYyMmgzaGoxUHVNNHk4dW1MZ29qdkZY?=
 =?utf-8?B?bG9sRXA1Z1A2OUsrM0NGeSs3RGRnVGVsWWRRdG00WXIzaE5UOHovd0lSdmFn?=
 =?utf-8?Q?1G8jYcafsVd3VMEXLH?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f046ee3c-62c8-4dd9-b200-08df2b58dbd4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7344.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:41:16.1342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frVHtk5jAap8uwrVsk8nR45u3RtDKj37UeMtgcSLsTgn64B+2sqH3jjsgN5T7benKT888nD4Ze0nRc+Z8AC/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9590

On 6/29/26 17:13, Fredrik M Olsson wrote:
> Adds support for:
> - Reading and writing time to/from the RTC.
> - Changing Backup Switch Mode (BSM) to DISABLED/DIRECT/LEVEL using the
>    RTC_PARAM_SET ioctl.
> - Optionally enabling battery charging.
> - Reading the battery voltage low status using the RTC_VL_READ ioctl
>    (only supported in LEVEL BSM), which also reports invalid time
>    information if the VLF flag is set.
> 
> Signed-off-by: Fredrik M Olsson<fredrik.m.olsson@axis.com>
> ---
> Add basic support for the Epson RX8901CE RTC.
> Datasheet:https://download.epsondevice.com/td/pdf/app/RX8901CE_en.pdf
> 
> Also includes a bug fix for an issue with reading the weekday from the
> RTC which affects both the existing rx8130 and this rx8901 driver.
> ---
> Changes in v3:
> - Clear CHGEN when trickle battery charging is disabled.
> - Link to v2:https://lore.kernel.org/r/20260520-ds1307-rx8901-add-v2-0- 
> e069ea32e1db@axis.com
> 
> Changes in v2:
> - Squashed the Voltage Low status patch into the driver patch
> - Switch from dev_err to dev_dbg
> - Implement Backup Switch Mode (BSM) ioctl instead of hard coding
>    switching mode.
> - Change the prototype for the do_trickle_setup function pointer in
>    order to make it possible to propagate error codes from the added
>    PWSW_CFG register read operation. This read operation is added so not
>    to override previously set register fields.
> - Link to v1:https://lore.kernel.org/r/20251219-ds1307-rx8901-add-v1-0- 
> b13f346ebe93@axis.com

[...]

Friendly ping.

-- 
/Fredrik
