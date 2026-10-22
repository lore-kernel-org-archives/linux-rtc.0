Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792667821;
	b=3gkeJISE9yvAYGfTgFwd4UMMcGk3+AhMheUhWjN3x0qPn95vqJxFG5LwWbt55lmg6i39
	 5ie2M0rm6U82hI3+AWjEfJB/uOCjCFPjpe3oVCTaI1YIKXMfdQw63XhFENW57T5EHEEaJ
	 qNzS3k3pSGh6KdyaI123Q7CpdS8UEPL1BYZMhd4m2ok8fhaSeRjIeDlKfRwbCjOTiZQI/
	 orKJFw3CJ632P+79FY5RGD5ILF+BBo9bLmkv/4VI7bJyAEusvbAW3HiNDjXyLySw0Ibux
	 ndZnhAB+9BQoa9+dEqNYpopyvt66lfpUAgvdFwB1ht9i4fH+Awnd4PMWYm8MKYiyq+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667821;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
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
	bh=zrSdJXI0fyDD6hWUVp89xFxcypiOfz1nsHq36opR//E=;
	b=jgM1xq8xOf+85O+rqXheZwQQmXoHZAEmwDzmutz7cr8RMdmRNCa5mhtbSkh5dyntcRHR
	 G46t/Ns1cxYJo7wgPEcdDh06WUd/7gtVpFNpYHBJHx8K/pNQYdZ7RsuNcx2cRiYlTaUcB
	 mMMq9qx/YPgXl9WHD9G49WiQ96Qgjak3a9v+URqDP3mX5jhcByFQq/5jqhOpVWD2zJAQ3
	 LESzU4ofvpq/oWRkfq4b9hkiqupw4mN58i4pGaIxd0GnV13sPE+CpWtCNQol6wcm6XhyR
	 ZldsjPrJbpzWNU5gZ26WKd0RNIurjERxpH5S2BIX+Tbcbn4PDR3pmuQhl+XqfRsqMbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=E0AwbR91;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.39
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634E606A319;
	Thu, 22 Oct 2026 11:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C634E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=E0AwbR91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIaJ0Uf41wGhR8naNEsAQ+MXN6VntZ7Mr1JO6au7kkNUudrf2LJMOtaV/sOgQ6hI+3k1a9DacQz8gU9TNct7dJJ2E+uB12y4FT2JcH4AJl6UpXZtXaSfarlZ/hmT0XciPvY2iq5ON6MCKXopBqo3F5IAinEtLV7inYlc0OFf42i0K3HMIl1XrKgTxN25TtpSq9VhmjLMXhIvoUjv9pROqwBWHoP/wK5D6RL2KjhXQFYdJr+aNuAiUtX3VjSBOfCCfsiZ2i3Uc5WZoVQopa//693B1lgaSoJ2wUMcSDBT7Dl9w9gTFfOApSWCV+DQZLxCmsZA2gL/pAMQ5yD0FI5Ydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrSdJXI0fyDD6hWUVp89xFxcypiOfz1nsHq36opR//E=;
 b=fm5/vnOLJWWbSZyD6v8gHuEiU5Dpu6RXC9kr86duDrJ4hDUbdn6qhJ18bHcz5Vrga5xZQTXhXII1CN32lpyZRKXRaF/AaUhm5QByGK931b64WzPKmLXchi2uQljUxd4atcWor/+kauAdz9FQK20Q+yN93oGePQIJsqyj+JQCn2iQus+eDOm3GqZbS19XBgh0JSf43xM0wM47ka3PdHclVALUWASHc61Tq3z0lo0T3S3R4exrOIHggY5d7d36PbK1Z+rLZf8ksSZx5CnEavBfdbKPzicf4XBVigfM+tcBVBvADoMKkmR4HP+my2Lw4a2ITyBD0zQL82KezNYd/9kkuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrSdJXI0fyDD6hWUVp89xFxcypiOfz1nsHq36opR//E=;
 b=E0AwbR91uszpPg0ZhXWvFfLd7h5xcFMZKzeihmGFug9o72EgA7tzMKiiuHnNLzo6MHVvMUbQG1DesgjFWhQYZUheSsnFkQMWrIJnp0fmFMVJeNdJYf/Mb9/XDURLxrraD0jGc9Z7IlJJ3lDGkpEwO5NgPoD5kUPVmpRimyq5lIY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from PAXPR02MB7344.eurprd02.prod.outlook.com (2603:10a6:102:1c7::8)
 by AS8PR02MB6952.eurprd02.prod.outlook.com (2603:10a6:20b:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 11:16:55 +0000
Received: from PAXPR02MB7344.eurprd02.prod.outlook.com
 ([fe80::f0f2:8c3c:c869:c51d]) by PAXPR02MB7344.eurprd02.prod.outlook.com
 ([fe80::f0f2:8c3c:c869:c51d%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 11:16:55 +0000
Message-ID: <6a54d7f7-ae22-4ce7-b417-ac9efc7464cb@axis.com>
Date: Thu, 22 Oct 2026 13:16:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rtc: ds1307: Add driver for Epson RX8901CE
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Fredrik M Olsson <fredrik.m.olsson@axis.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20260629-ds1307-rx8901-add-v3-1-302dc3cbb71e@axis.com>
 <f3fd611b-920f-4539-8edb-ecb173f715b0@axis.com>
 <202610192034497aeb0da5@mail.local>
Content-Language: en-US
From: Fredrik M Olsson <fredriol@axis.com>
In-Reply-To: <202610192034497aeb0da5@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0079.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::12) To PAXPR02MB7344.eurprd02.prod.outlook.com
 (2603:10a6:102:1c7::8)
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
X-MS-TrafficTypeDiagnostic: PAXPR02MB7344:EE_|AS8PR02MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adccf70-8c70-4dae-9e20-08df302dfb23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|261021121427099003|3023799007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	toxKbmEa8zbRe5Aj0PlSuXKpI+df2U4S3W0T38OyQRi4jy/MfWfwrX2GBYztaKDm/JZGQfcuMBVyL0PqT0ERnQ0LFt5vNp3N88AdXmy7DMI9j0hl2FcqgJ4lOkF2xIS6nhXvTfwyMPdWFexk7DTsWI8tpMQxF4abWifHnmjLrnlIJqLKvjLq9tFloOdMbHqh9ejwOLvDjQ4tpSCnBLLgNpy3JWf0XsYKLdWCY/p5+XnHoLxaq5xpv8g782Sb2xOQLKLtek5Sk2OpguKQhObeeune2yNtjkCSpjbymj60WU2ir4p/NyicztPguBrXMq4VN4WvdC+dZAFGzlVTiBc0lAfQ311xjDBeK3G/E4eiQUX12MuKoouwX8P24J32ardT4rr3c4X9Bk0gc+cPNIHk1mbVtRbJjy0vwooVrKHK74vmQrgskppPtcLygkF+/xrFsYmk1rt9YKk9facQReNvFiXpQF+6WPLxcFUj25aseO6b714zMqYOMof/Sge6reM8PQkpGOudmOgRZG5Cqrt90kxxuh/Fn2QT+CagbuqzDmt6ZOqKXRdGtXfXXbUjmBHgVXR3Dk4RAyZNxnV2NjoitIC8CEW0UcRS6rixPa8JyimjDTPamIFEwGTmXH4qkI7g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7344.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(261021121427099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVhNcDVMemxaT2tKVGVqa3dtMUxWK1FvU0RhVFRBN0p0SHhTNGhya1k2TFJQ?=
 =?utf-8?B?YitOTllGOGRqbU00L2pGYkVEeFJMMGdsdy9VMUlzSGN5WlVLOVlBTkVhbVp6?=
 =?utf-8?B?WkJxS0N0U0xURFh4bkZPVkZCNDQ3cW1qeHcvUGhtaGFmUUpIandhRzBTL2Rm?=
 =?utf-8?B?Ym0zYVg1VmthTVo3Z3M4L3c2djd2SnNQUGNna2doOWo3ZTVicDdMeUxLWkNG?=
 =?utf-8?B?NEsrVmdxVDRhMWVFcmswbjVOWGdsSjV6ODUrdWZyY1hjV1VOUDJlRFhXeklK?=
 =?utf-8?B?NkZCU2t3U3JEZmJRL0tDWnhRZ2pmYldSWkZYTjY4SGcyM2owdnBzMTk2MVJu?=
 =?utf-8?B?cnlSL1IvV213YTFncFpBNGI1bExnWTN5QTd4aUhGK2greEw0NWJpZkpFaFBk?=
 =?utf-8?B?L3o4cWwrTCt6a2RYUkJHNTkxTXdhUGFrb241d25pVG9RcjJGd25DRWNLT2dm?=
 =?utf-8?B?cUw4VVZLQS8zN2c4Snh1ekpkQmNnbHkwZXlwWEhsdnNUbloxZWtYVVN2Q21I?=
 =?utf-8?B?dUZyRnNWa2VNVzZhcWRydXlDTDZEM3dlOWFsdFZocjk4dlFtVFYzZmlIS2Z4?=
 =?utf-8?B?dVZKUkJlamxDcjhJS2tQWHRSancxcE11U2lJVmJiL2x3c0pqZ3ZJYldtbWha?=
 =?utf-8?B?UmRzTWRMT3ZzOUlTYitWb3QxZklFRW9vSTRIeGpGNktDMHVpWlp3U1AvTWNN?=
 =?utf-8?B?VWV0MmVxQThCU1VheWFEeTBBNFBTRklsYXRaSTZGNzFPS0pnMlNEMy8zYnRN?=
 =?utf-8?B?dkpLd3NwcVFWVElMSGJuQ3ZleGIzeDYyaVFEcDNnK0h3OTljcmcwb2psbUMv?=
 =?utf-8?B?b2hHakhwVlNyeUFoSHprUnErTnNBMU83dTF2S0FOWW1JWGtwZTlKbTBSbnFI?=
 =?utf-8?B?ZjQxWEpLR25hQ2E1Qy96VWpiZXcvUHh3WFpqNm1WTU5kNHdabXFqdWtmeERG?=
 =?utf-8?B?N2lwUHM3U203L1dieU91ZkJweE1YUmpGMG1JQnZjRU9FNWRnSU5SS3N2Mi9V?=
 =?utf-8?B?VXFQQlRXN01kZ096cTViNFJzL2FoTGVKYjhaVlZuazFpQjFKVmRkRlFnSFZx?=
 =?utf-8?B?ZytmaksrdUdpbm1iOU9sRGtYQTlVVWUyZXl5MjNMb3B6bUhudkJ6SjMrWkRu?=
 =?utf-8?B?cWVPanN5NGgyUklBdU1nNk9FN3B4czNMUVNJNGlibFFwa1FBeE56bm85dVRa?=
 =?utf-8?B?VEhCaTlhTDltZ0dCcTJWdzF5Y1ViQXhORUs5d1V2ZnBjOG9JYU5jelFLQ2JX?=
 =?utf-8?B?N3MrclpmOS9NbmkzMWNzZjc2YnNpdURCS0d6azZVRHpiZkJUNk15SjRGVVg5?=
 =?utf-8?B?VEYzS0ZVR0tJQXlhbUF6YnZzYUNwVGtGY3dQck1CWFFtaGFBNzYzSWxSU0t1?=
 =?utf-8?B?K2o2NzB4azhFMlVqRjhvMkV0L1l5RUFWNXArdGtBZjJCYU80YVcreHBCa3dG?=
 =?utf-8?B?d1VrRkUxRzJWOTZLVm1rTDNZZlZNNlpkWTltd3pIVFJLR0RvQ05pSjY1eE05?=
 =?utf-8?B?L0F0eVE2NzJDSTRWd05IT0xyVCtoS2o4MzVVdStWSjIvQTdKajhneEF0L1dv?=
 =?utf-8?B?R1BGL05aWGNoQ2c0NkU1LzNWN2E4cXgzNTRERHRaM2tvbzBxcjdFb2xCakkx?=
 =?utf-8?B?Vkc2VktHQ0p5V2ZET3F4YlZvaGpKVTdJWE13aXkrMklKQ21IeFdpNXFOZUZP?=
 =?utf-8?B?V3ZJMytaUzYvODJDWUhaREhXZlArVkx0SWU2ZzVVSDM4RHFyNDFOWmJEa3FF?=
 =?utf-8?B?SGFBQkVoUnowQW91TmJiQmRSLzRjc0VmREI5S2dJd3FHbDFJeXVIRk03Nnda?=
 =?utf-8?B?K3hkcGFWZkRublQrS0NmOFdMa2JOeHJwVnh2Y0JYQmZ0N2d0M3FUcmYrdlVN?=
 =?utf-8?B?MmhveWFnTDdmUm1RbzYrRHdJQ2Y1czNyTUFzSWhaS3l6RWtjOGNLekN2cVo2?=
 =?utf-8?B?TlRmN1A3Zkw3SDI0Q1VYMG1FT1hKNk9IRHZVRnVvU3Zya3NkTkdCMUZ4ckF0?=
 =?utf-8?B?T1h3Q1M4ZGtXODZGUmZnOXVuUTRpdGZ0Z21vZ3FHcWRrRlBHVDZMUGtqdC9K?=
 =?utf-8?B?cVh2NTBoU3BDVDc3RkN2bkhzeGM2aVNGTXU0R2hOd2NmM1pZNjl6NzIxRjVZ?=
 =?utf-8?B?dVNZbklRMkY0WG1tbzY5RmJhKzd3YUpIVDBrdWtNaHhJTml4L2ZkNlEvN0NU?=
 =?utf-8?B?SkNPenlBV1d2cEw5bVJINVdSWWlTSnhTVXpVT3dnYmpXbXp4YjdzSUZHMXpj?=
 =?utf-8?B?UEloS0lCakUwZkcyZ0lIa012WjlRcVNWdjZOWU1RcURzdGJERVI2RnR3d1gr?=
 =?utf-8?Q?SjNmvZhLoeKnxyIRdy?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adccf70-8c70-4dae-9e20-08df302dfb23
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7344.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:16:55.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quUnzeSE6xAMCWR6j6T3HGHlK7RS06IUqPA6xJiPJhMezpvMCqrjuFREZnvXHIVltBOsk0+8G0KAZgmBuw3PTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6952

On 10/19/26 22:34, Alexandre Belloni wrote:
> Hello,
> 
> On 16/10/2026 09:41:14+0200, Fredrik M Olsson wrote:
>> On 6/29/26 17:13, Fredrik M Olsson wrote:
>>> Adds support for:
>>> - Reading and writing time to/from the RTC.
>>> - Changing Backup Switch Mode (BSM) to DISABLED/DIRECT/LEVEL using the
>>>     RTC_PARAM_SET ioctl.
>>> - Optionally enabling battery charging.
>>> - Reading the battery voltage low status using the RTC_VL_READ ioctl
>>>     (only supported in LEVEL BSM), which also reports invalid time
>>>     information if the VLF flag is set.
>>>
>>> Signed-off-by: Fredrik M Olsson<fredrik.m.olsson@axis.com>
>>> ---
>>> Add basic support for the Epson RX8901CE RTC.
>>> Datasheet:https://download.epsondevice.com/td/pdf/app/RX8901CE_en.pdf
>>>
>>> Also includes a bug fix for an issue with reading the weekday from the
>>> RTC which affects both the existing rx8130 and this rx8901 driver.
>>> ---
>>> Changes in v3:
>>> - Clear CHGEN when trickle battery charging is disabled.
>>> - Link to v2:https://lore.kernel.org/r/20260520-ds1307-rx8901-add-v2-0-
>>> e069ea32e1db@axis.com
>>>
>>> Changes in v2:
>>> - Squashed the Voltage Low status patch into the driver patch
>>> - Switch from dev_err to dev_dbg
>>> - Implement Backup Switch Mode (BSM) ioctl instead of hard coding
>>>     switching mode.
>>> - Change the prototype for the do_trickle_setup function pointer in
>>>     order to make it possible to propagate error codes from the added
>>>     PWSW_CFG register read operation. This read operation is added so not
>>>     to override previously set register fields.
>>> - Link to v1:https://lore.kernel.org/r/20251219-ds1307-rx8901-add-v1-0-
>>> b13f346ebe93@axis.com
>>
>> [...]
>>
>> Friendly ping.
> 
> This was dropped from the queue because kbuild reported warnings and
> smatch issues on the patch.
> 
> Also, I feel like this should actually be a separate driver instead of
> growing ds1307 larger than it already is.
> 
> 
Thanks for the feedback.

I will look into the kbuild warnings and smatch issues.

Could you clarify what you have in mind for a separate RX8901 driver, 
and what the main concern you have with adding RX8901 support to ds1307? 
Is the concern mainly with the changes made to support BSM handling?


-- 
/Fredrik
