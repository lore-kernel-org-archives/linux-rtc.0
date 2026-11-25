Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795643547;
	b=wtvWUawTlmD5217ahAut8QAV9OHBIru5jZnQzDZQ2gS5Micz7ueKrqdlV0XR/71AscQa
	 BRJvuXL+ZkllaHyeeU0+4aYnOYrJTF/x3IPJQiRJHktPb0mPh7DQMLNd5B1wCCPq51C0k
	 peY8uh+7L2ti6fMps7+W0spJUYfss9gSM/imfqHAj3ddfQLbfO59//+iVD2Fmx27vPFDt
	 yOu06ItDIgeRpnmVfkqvAiYYwKun56Zrj/oD+wbhh6KShhvIMaEZFvkS7KYxg7hKEukd5
	 KnGx0dWqJQoeQA2Q4cFuuxQP5ohBp3wEl1AYLSI6QoBr0vY/SrSDsjnMJSDg3Z1hrzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643547;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GI4PMYGIENUln3O4iRu4fIBiiO8dSGxaHvsGV6kVfdY=;
	b=o3GlgJRE2anJO8ne8o6i4bGIbjFagcEEKRKQSnq63cxI5d+A254r9auMRuITC4RWdble
	 8kR9XOu06/q22fQyonR1yQBYt6jLBuj4v+Eq+cM9nh/nMwaAMpqnPzJutI9NSS3NhLzNp
	 5RxKznmYpRztEBuJgO+zXax4HdxjVXvIcGWMHc5QtN8aCH4Bqd97qE03g7ftQC/KMuORo
	 TMdLaRl5b1vej58L1Qyz4oZi196F6FTJYCmpnOviVzFB1q8zSH9f/XlBwGrgGcz7oD8v9
	 p+Lf8tTEvzJpQP2uhiyM03zVLTfAn0GkeXDkpgJgRbNqZXdjRLk3LRok6H8QvHzflpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RkEOunLr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.2
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BDD606A31E;
	Wed, 25 Nov 2026 21:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3BDD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RkEOunLr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZHiUvlRHPPz3L3dyiWIj1Zun1Lah1Ar8PC1+ZMW6pCh31cQvRKDb4fb433hfg6pZjwpGHP6lRBG/xKr8vfB+/I5XWVy+vyGRm2hsZFryqDZgw8aRyyMtGV0rV/Cyq44n84Y/OGXeqsiyVS/F+m+IwIwcdPk/EIfa3K9KfyiMXLi9zTf6m6GWHuVm8A0460gB5CY/P5DDUm3Oc02/d5yiiniFOg+f3i5lPbT+Mivx0i0EFi875C9spE5n2QOmyPhXsa6KSl79pnKDmiEAxkb0KHMVZQkEoYbM7RWdUjL2yRTPrD1HHWRWSTz8INJHc5Po2E/iMymd/0lo0PIKAgakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI4PMYGIENUln3O4iRu4fIBiiO8dSGxaHvsGV6kVfdY=;
 b=t5DkBI8x8s3jTAukkNsw5MFCHHq4EcL1gsu/Q2paNxBDQVW3Mymt0NpA/9L97Xlh3SRTqxgAKnH4YuPWCml0U4wQegDu618GvUtv9hmOsKRIZwdsGIuFJUZLtjBxH9Hti3l9AiFKJ51KEfY0YHhaKRpaj2s4I903WcoprRHiwePylBVl9azImizaY4zjvMFkxTD6hnjDN8ltLP8L4Xvg+YWLO72fiZXlWfdD0WRTvZ1i2+03ddXWnfQfK6QHSrf5+70K4S/sbOWctAiCUU9UMGgjg6iq9+ezTDIytPbH5idSE+nJM9t5P4xuacANQO1xHac2wpHQSGEhrSLzDYJjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI4PMYGIENUln3O4iRu4fIBiiO8dSGxaHvsGV6kVfdY=;
 b=RkEOunLrqRFz/AachAkDQrungF1MdjmAEwpQOYhF6soqf6S9hZ9ngG8YOkTmPZZyqv80cpSC1GOHs6M3f5JXckcBzjJjpjthvd3Ka22FK40Zn6L08QGhFgOQl4C8nBprKbPi06Fn6GdwloOz8n6K/W0y5jdFAvJCgrUkXQw2eKB4dSzqtp2AiXEuo0J5qlGbB47D7IAQF1QcKKcjG9ANSpYAIlY6vLKkQmLJfkQzDBqBglsy1Gy5trUMjOoqoMiwZRCmKiLwRXdvZngZCyfMfw9fggib5BJVY54Y6WGS1tOLpa/SuyVY3VeEJS+AqUjrzKGjfeAmFLr1rTUSt00y/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by BR0PR04MB205366.eurprd04.prod.outlook.com (2603:10a6:2c8:44::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 21:52:23 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 21:52:23 +0000
Date: Wed, 25 Nov 2026 15:52:10 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Prasanth R <ragaprasanth@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Paul Cercueil <paul@crapouillou.net>, CL Wang <cl634@andestech.com>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, Prasanth R <prasanth.r@lineo.co.jp>
Subject: Re: [PATCH 04/12] rtc: mxc_v2: clear the wake IRQ on unbind
Message-ID: <awdYin-gfFlMzm5K@SMW015318>
References: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
 <20261125072026.2997493-5-prasanth.r@lineo.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125072026.2997493-5-prasanth.r@lineo.co.jp>
X-ClientProxiedBy: PH8P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::23) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|BR0PR04MB205366:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d151d4-ba99-4a96-0152-08df4b3e62ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|1800799024|7416014|376014|261026140227099003|261022105027099003|10067099003|261026121527099003|261021123027099003|261102123227099003|261021121427099003|261028144727099003|261009223027099003|22082099003|18002099003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	XK+jxcczERCj1rcx9PHJ9kecxsMxC+IoDnpApT9xZ7T5r8dwm9wByiU/vbq108SCsJwYVLXMPlimWO8Mh5qqaLxsqSG0adaeWsoG6HBSafABL1WtezSjPffC8z6451VifBnWQKL+To3si5ScfkdgNRuQHprVyWDDkNh7aTZwGqaTEzHVFD3CPYZKUaPQN292HpnHCvmOV6b69eP1q9tzOSBKiZezmur00WBxvIUQGn/Hgx2zctlG6eJwMPsH9HU59AmwumyA40jWkhixXmoMjjVC9GA7yfAjru+Moc1YlUR1eY+yPRAPJXUx7obBve/WAnBVRR+Y3RAioxFGy194QomwS9w8CnL0SjKkK5aJd6TQ7fWh46pve+fLg4KcdvT6vwDhbEZBvlx4MxWR+ErTcRkJNomm0hcI4NLi+TsP2qqMXI3whSelVzSPmj/9QijQRRCCAPMaMJ0etpW35/NSH8/L+1rKfBjbH5EO3KdT9WXktjI3Cy/Teom0pFfJr7x6iuIWwQrfDBGySEoER5bKiT+qPJxl0GIitrSq8NRL8zwD+z6n5CGv/Rq1T3VrnEJTWMyxB7PcmHLloHso3tQvxiuuAQBNcJtx8sBkmfj37xfe2bJOgtllSzioBElfRfzHD7juOEICdsXotKYQNWbhi2+eEqoV0w4SkD1/qUN2HgE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(7416014)(376014)(261026140227099003)(261022105027099003)(10067099003)(261026121527099003)(261021123027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MqoCKZ4Bl1ngBHZaAEK0hRwapU4D4UQ7ROhb2DuNXGmBG+x8F5lHZL48wyOk?=
 =?us-ascii?Q?XTNdJhmOOr87K1TThO6xtrNmS/U7DFpooGKV+gMRYhxZ58LMJhHEX5V1uied?=
 =?us-ascii?Q?tng6KU0/bULMLl4x3f5lIwwYgG4uo740dixFVD5+Dq8svMXPYRwDtzKyLxlg?=
 =?us-ascii?Q?83OeiLGXSlGwxBIKkcpdtBYBGiQtnuH4vWmFGhDcHE9yE03ButZ2o0qp87v+?=
 =?us-ascii?Q?OtRPUUhMRTCSURz3c1uJMPZ/Srm8Jh1Mu4Plazj3iNyeK+DCTJ6W323VR7zV?=
 =?us-ascii?Q?LE9X0gxjPSCyO1VPBrChA0H8WGRLNLY4OBf+ch/4yZ3uSowA6j8KGn7gDEoL?=
 =?us-ascii?Q?RaYCkraQxXf+oXhYbHA90eyXRGhAo9njQKQlBoEXO3IXqNO4nb4275mMpTBa?=
 =?us-ascii?Q?KCMx2qFrHTrz8p20irAEVvTsbMmUfHmWRTarZjlM26GIpjRi4qHQeyOOHLqF?=
 =?us-ascii?Q?pBRktWAvjUWy6Oycfoj5Sd7wU4fQ7o5NN5Q0aT4VAnnHp2yu045E0fu9GAvn?=
 =?us-ascii?Q?PoSvrpUHJ8hllCwEjkYvQQ/6s8WoTdxDypEf6P8gXds0cU6Lf46Hmxxz3TFq?=
 =?us-ascii?Q?f09Rnoofqgi3PkXsXyYVNTmMrz5T9/J3zRll3s80lvf8LX7JE/1Awq6ZkqeE?=
 =?us-ascii?Q?W6tto+mLwXig6jZrJW2DruHZbUaLqhG8AVuKPimtZ8d6eAj9du6YaknJz+Ts?=
 =?us-ascii?Q?DM4RI6kQ0bfd1WZK/KXdzo9AhiCNXJ+RYH97JXOqiacmzkQWv+UKQugFb4Ns?=
 =?us-ascii?Q?b6qXXoU+ZyADtY0NnuDKACQW6JP9TxN6nCDDpr9ewTLXf+h31MjSOgns/FMw?=
 =?us-ascii?Q?rdTnl8TPHCyO7bedBhmsxc8glT4oxZ2zRIfYvLaVnGP0AsuACxwDB4Vie0gX?=
 =?us-ascii?Q?RAhPV+fe2zB5McHI7y5mt4V4PhHz+0r7gIeCuwd4gjZeSnUrvPoWSUWAz1nb?=
 =?us-ascii?Q?U973pm/VE1Ywq4dQO+lxl+dFNFN7HCDzl61cSgO1cKL/FPA3TACBMMSmjz5Y?=
 =?us-ascii?Q?NLhftATptkLd8bcwCRrxIynE9k5B3rRlOypXAT5L+fN70Z8ki+darykDvOa+?=
 =?us-ascii?Q?cwjQJmdD2AgrMELKvH742lfFkRdDuibPhGAzFbUWRMrJoDTPGTpLWF3zhaud?=
 =?us-ascii?Q?gzJB0YQV2cw9xCDNXZuVg6u6Ctrjpxd2Oww+mQLyLgr3ROIR//ACfKxp0L9T?=
 =?us-ascii?Q?/kXjj7nfFTh4FgTyrqdHtcEIRO0LEsXsXI3Dgm1TU9UOuZMFfkW6gxgMZhBY?=
 =?us-ascii?Q?1QMEB4eCN6DAYc55+zQtZ8IFHnqr20TDdHfLqbk7B+6CGVKJo1l/4jwPKLUx?=
 =?us-ascii?Q?2LpXsMbTx6Ero0KKJ3Fr3zNhW4omr2RY6cMvJqfytdn9NP3zZvnIHHZDFDxN?=
 =?us-ascii?Q?2up6TUJ17LgRu3+WYkALEL5NRv5ZODNwbwhMkbiWIz0st0kOljHG3rbLIt01?=
 =?us-ascii?Q?Kb4TChPaceTbAQi/mcruYnhnYEOuBegAV+diPSPiY+8qA4LAdTei+pPH/JBq?=
 =?us-ascii?Q?eblYgMZISBjNqe7GiX/ik85EGhXvIB09lEuCPPF7AJ1VoQRzK2amqNYEO9U8?=
 =?us-ascii?Q?INbx9XuCzigChwAD37kL0FNi3bscsI1WLBZtrW0HmL2EdYbvn5cOFY2zIxBC?=
 =?us-ascii?Q?S2VvK6o2kvgh9lmwM4pdw93nmFz9ZsRiRSyhwcBNzLD+Ny8+GYBrSuXaTPRi?=
 =?us-ascii?Q?UIpkpdSZIRVu7dZgA9u3Zj843elWSdFg3tX+uwTEY/t5io6wmOjJLRjZ1/B9?=
 =?us-ascii?Q?uqjtBz89ZIle+1nvF2UCIIUEZ0fIEoMGsORPW72nrwEBGrHdHXzC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d151d4-ba99-4a96-0152-08df4b3e62ed
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 21:52:23.2300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5/E7ccUly8axc+jaSj1nHt2ggIYUTI4pLnf1c+U1dpCud7E0LnECtzs0sjK5DTx/htP1OY6RWJEvb1gYWCmQ+xFbLKRaB/8pmLIQToS50WY5topUCpXcRRccqA7EeSn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB205366

On Wed, Nov 25, 2026 at 04:20:18PM +0900, Prasanth R wrote:
> [You don't often get email from ragaprasanth@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Prasanth R <ragaprasanth@gmail.com>
>
> mxc_rtc_remove() and the probe error paths do not release the wake IRQ
> set with dev_pm_set_wake_irq() or the wakeup source enabled with
> device_init_wakeup().
>
> When the driver is bound again, dev_pm_set_wake_irq() finds the old wake
> IRQ, warns "wake irq already initialized" and returns -EEXIST, so the
> driver prints "failed to enable irq wake".
>
> Use the device-managed variants so both are released on unbind.
>
> Compile-tested only.
>
> I used an AI assistant (Claude) to find this and write the change.

Needn't it at commit message, you can move it after --- to tell maintainer
you use AI help.

>
> Fixes: fbc5ee9a6955 ("rtc: mxc_v2: use dev_pm_set_wake_irq() to simplify code")
> Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
> ---
>  drivers/rtc/rtc-mxc_v2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
> index 35a18b75c..fe3a55b00 100644
> --- a/drivers/rtc/rtc-mxc_v2.c
> +++ b/drivers/rtc/rtc-mxc_v2.c
> @@ -301,8 +301,8 @@ static int mxc_rtc_probe(struct platform_device *pdev)
>         if (pdata->irq < 0)
>                 return pdata->irq;
>
> -       device_init_wakeup(&pdev->dev, true);
> -       ret = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
> +       devm_device_init_wakeup(&pdev->dev);

all devm_*() API need check return value.

Frank

> +       ret = devm_pm_set_wake_irq(&pdev->dev, pdata->irq);
>         if (ret)
>                 dev_err(&pdev->dev, "failed to enable irq wake\n");
>
> --
> 2.43.0
>
>
