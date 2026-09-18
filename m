Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934B52268E;
	Fri, 18 Sep 2026 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760791; cv=fail; b=YN9L/eWH5P5AoJZSedbh/q9c0/gSF3h/qnvUJdNnX0H/s+2tpL5s4SFKxLWxNUkbw9QJCTUmUWibo0clZ3y86TW38pSE0iM7TDOQbBLVoIhePrdu5IqGQytTuMoqt9xA1FbGccuLwBaVcVOgYMWPe1mxcGjfM8PzSh/a1QBAvgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760791; c=relaxed/simple;
	bh=rIXxRAIrMuDAQ+YHqXAKsf6iYCMESTPnRXOT8VJpGrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rbMXYgkCwwbslki6louI7kTdqZ1p2cEq6nlT8EvrOuXrmkcOAPMVDqMyYelzrlHykmEHKy143IWO0Zd5uSabl6cL7pApSBH+mpNVQSiwiSxehjKSPzE5OqwNfu6tuUT4rZpLj5iyJ1wx9XJJ8PucLiN6fKEVHbmVuSGBoA3UiA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Rsv8pzFe; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Rsv8pzFe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wm7KaQ7Y/ON8O3R/CGnUqVuM4P6d15bk+JqKDnyIJbEX80b/j9wVR2qqKNIFVb9cfzgPSltEKRl/sO+Qskj+IU0G2ZubnzQnTXIsNenMz8UvMTDcmrFl5HxXxABsZ3aC61IDwZVduqcmghplkOUUAI9aKjKg3ARralQNRaxKgvUgF1+j/TnIx7jl6jtUsK+iqTlHdaYzhDMXMbbZgk2gDgYId7TUmpFAbDg2qSLNb/8xQwEaU5J55LUO/8auiAMsjWBlqsnkMO3V1G81/VFsorWTN9jy4xGi3irR7xcY/GiwI6gUZJ/RFTBd8wySUqNg0ZLgZV5Ow4X7ry77Sc2mBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xy1jb3UyOGQX7I5I7kcC/vvJXMkLS4Hwbo8xmgQcSvg=;
 b=K6gJijtWBgiNAVyJ0+/nK+ZaG3FYw7hkjSYG2PXfuELeMwvIewzsZVhi04VLYdddO3RLEVx503jI7U4DXZNQV8hlBfyFSSBAzb/eXFn59LdXCiUgRB2U4q2199B5xRcBAtlikeiOGko4576D/hXIfCRuXw7MH9DrR+6CPPiTIGWkRo6yfVUDGAqxnYhj4K426m0R6cscs7aO7OHnsuTze3aBFjqfVINTYBUOWpeYtEIPmVDt7L3hyZXwPT619pWhnA5dXbEYJgwKuI4O/FN1Zb6+wshYhdee92Fm9cFo2wHBbJsuuzXr8uiVdTCMLdoVJSsanR2k+qkDlG7mq2Q5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy1jb3UyOGQX7I5I7kcC/vvJXMkLS4Hwbo8xmgQcSvg=;
 b=Rsv8pzFe5CnBIzeVtz4eu/UCkMWmmnRgQNGQn+BmR70NBC/R81zxkLpH4BdVkNvgbQiaOXe9gjl4kXe74FDIzc7dJCwk+DvKMrW0i4Yq5dlm4aXCZIX8iXB1kwKR3q28zoVp6I5vdU0Ut5tuewzNPQCRLJsN7Xctdm1fHduE+WCYOtbBeLOZu/x1WEceXLoMGcn/PQNlumOc03qfXyKHeO7IqmodhGqxjFU0p4xTAhROVUe9tP4udn24kjeIiU+gQRw2qFFEnEYZzBAVVphAHydy4FPZgqlmcKO4ZqOEz4io5hduRP74RH5SFqVNG8RdM4St58Z9MaOqb6POOoIVCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8530.eurprd04.prod.outlook.com (2603:10a6:20b:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Fri, 18 Sep
 2026 19:46:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 19:46:24 +0000
Date: Fri, 18 Sep 2026 14:46:15 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-rtc@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: mxc_v2: fix wake IRQ leak on probe failure and
 remove()
Message-ID: <aq2VB-_XgTTWmsb5@SMW015318>
References: <20260918155429.2549137-1-congnt264@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918155429.2549137-1-congnt264@gmail.com>
X-ClientProxiedBy: CYZPR14CA0029.namprd14.prod.outlook.com
 (2603:10b6:930:a0::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbcf09e-68b3-419c-a3b9-08df15bd8583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|1800799024|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ShXaFiXrGmLNPXAVcKOK7gOJw77V03nAuqKGbhCW1JeLiZBrzUepp1C32QZD/Iz0c+W/atFfGB4V+EQyVK2ta4ZnHwfV4LjOp9bHXCH9Ct+Z7Y8TLcQpIcauHpmlNjBpgHpViurB8MfyeEEmY1iIHbCKliRHHhNHoZlMKT7QR5YI0Z78ZmXmpWvD8a33DRXJkwR6ifpZ+vCsrhZ4U+OgG2hiWf+VbJP+g7wjUCOreDXSqnXS8hkRTgJDua9kTnzn8sveK5BVoMvi6iffbYLtgMOFuSnVfj9k/0YWRrfOoUhkv8K0xXASzKQNjjseO3CYw6FljKClJ5G0dDHXsHdYc+YMnA8VfoFLHpFLRSawIF3oxhbZj+yUBSbmeAz+wfgwmlcPyC8YcMiyQTjv/h9VOTlXNW14Zhv1AXpe7QgagO9LSYvc8g+XTvLc8n5UP0ISkQSxdrGkO0MxcaQpHWvZBQHnczi8/lyRlSUR1MrKgEyz0V14JOT8ek8OXtaLHELz6tjicocez1rIsZQSv8j5A4WowhPPLGXnfJqpPW8kEoaJc3ZWHjGeSnFY4v0X938OCSQarvF1H6w7DUaPNaKJQOBHzVmrl9zHglc+wjb/kujVTw9RkF3rvVpYSUuhADR/GCvhz5Uy0vHZCcoJBJ+aj5HHNDsdXLhBFhNwiJ/kRxE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UAKulRsV+h8s12ZKaSnxXY8qv7pqqZk0hPtQ+LxW6p5Wgoky4/n0ADGCQOHx?=
 =?us-ascii?Q?WQEFrbIIlcPbODUwLKdD77A5Iqwgs986/nB9vi3DF+81cRMaRbk6BMrS93Lr?=
 =?us-ascii?Q?ikG6EGZaIjT4lVgdqOrP/7LpsyGxNp1ChuJzotp1OZb7jParstt26VB+c5+1?=
 =?us-ascii?Q?XynJTJ0smoCTC1g/wsiR0P0xVbeq95qMWm4zis+dSlo1i0XMEVsycf4uGyb9?=
 =?us-ascii?Q?WzfZPLrnXg6z72QjerQ5WZ2clYxsvYjoMzAEgurTr0W3GppvhVuuSxDuUTZV?=
 =?us-ascii?Q?vAUMpYHndtpnXqfaI9UyHSK48Tcjpmeteq3IOXIY4Dw8iMfUu6c78cHusxhc?=
 =?us-ascii?Q?W88ecPXPVdC003G4SnTOVfqAebITKj5EdYxOTslAuanRR+u1VaLITdOkUa4y?=
 =?us-ascii?Q?9IgqORPPEnPmBYgLPZ62K6JzWCwwnB4eV9fjYYujUlo6n4os1S62M0D3/ej5?=
 =?us-ascii?Q?wHKoTP9Co9+C7bbOBDmFZ6ye4UU1qjz2HXSrPacgBtTVOUFlVYVFSDePWs9X?=
 =?us-ascii?Q?wC6x5yXmVANFxg6b7fGwKcc7SECeUnapH4sVQzwLdYPmtMXVxAXoTYfJoVPt?=
 =?us-ascii?Q?3qIFhC2tE2l0KN9j1b6hbVKX13kz3uNl6JyYQrm5aaKlUlWfr7yBiNYbv+dv?=
 =?us-ascii?Q?6d9vzkHi5nteaDp4uY9yOzKDvcl3H82fA/bCDRzD/nD759hUbKLCoJ3nWNE9?=
 =?us-ascii?Q?PHngT2nj3kdGaFQ/WFbtPRbyOJ5hiviJMJbF21CJHqeub6LCu9f4jPagxfi3?=
 =?us-ascii?Q?w6LiSaJnPjXWlmssQ/A0P81povar4YBrIJkUG/p9W6QGMZk6xOkiSM9DkL57?=
 =?us-ascii?Q?kWHP+VaEyn6ShiTuQBcKgEQ8qwmqMbAvqoFMK+tWnP0WSf8l0B+fCyVDB1ae?=
 =?us-ascii?Q?y8pf3kaM+joPkD2CzFhhbbriZHgI0VH8IP6EpNga9KVYDV7n/JMaF/KWyhp4?=
 =?us-ascii?Q?gThZPa4LGbVysBXJLNg31FtXq/2oYyvve3ydV/f7PXPB2TY4ookQWuUIIB3U?=
 =?us-ascii?Q?bMrwFpM4grgmGpIBV2v6urYY2A2lPUkntEIXpPl2UaUaFKl1g/bnjfvAzOkm?=
 =?us-ascii?Q?6HXbBEUHwshQoeNdA8rQzfPt34GbBk89Ul/ZtvxQUbakRo52wrmaq0EwEVA2?=
 =?us-ascii?Q?M145KLuXBEe+wNzzN55yZWF22Pmtdkh2GMVAWZEJIy4huTaOyXaelp9FDin5?=
 =?us-ascii?Q?tPH9GTGPHBKqxMMVsi2jJFMUeCH0/ouRCymX/DLqq9IC+30wSs86ML2dGoEO?=
 =?us-ascii?Q?JA++qTWO0fQm1bSwxt+MFdH6k0vWsvuJUoE5BqcRennP94PumysWpLyNwccA?=
 =?us-ascii?Q?KS1I/ehY/cckVce9Ypt6lTVgyeM/Wj9DBijHG1MtTeOinGFgTgJFwU/2/l1p?=
 =?us-ascii?Q?+p8Z2RN4JiOB7TaH8X5YwBDqeKBOhcWmSyHCFSOtFqcMxWpKpYrHKEzvVE62?=
 =?us-ascii?Q?GdZL7m6QUw/8AMv52heK8hDO+yGcfJNO4KoBkxIvOVMN+FV6bOSYE/u2UafS?=
 =?us-ascii?Q?/lHQB0KK9UO0kdrzJSlzDqUj+hRMd/1ByvJpMhY6faqpQWzTHQLlg1VUyojQ?=
 =?us-ascii?Q?3DlErxSXLKHwtvFh6ywiHgm7WYPSDIPaBfLuPZpDpfkMJBw2EKJqthTSG+5c?=
 =?us-ascii?Q?PBWuOqulPRT8blshFIImIc0IWRXxgHZsPEG9N9dAU0lgt9vYerP7+DXP7CuT?=
 =?us-ascii?Q?KD7SsAtVFMGliXMcDnA7WvTicW+W2+E14f83CD0jw3l8N7espGdxAOxHHOM3?=
 =?us-ascii?Q?wirS4N9K1i9dMSSzD56Vn23+ol/VMHrWWH5Vy9WrQmDvheB4mo9S?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbcf09e-68b3-419c-a3b9-08df15bd8583
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 19:46:24.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pnkMAV0n0XjDXiFQZQpy57hMRLUv2GlAfyJS3WKtNyEcvAsY5kN34Q50G02NPdFcR7C+mpd0/Q3dJQcZkQ+FwRFcLkcaH8TgkDjq9R5Kt0i62rKyqtVCP+3rUo3z1FY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8530

On Fri, Sep 18, 2026 at 10:54:29PM +0700, Cong Nguyen wrote:
> [You don't often get email from congnt264@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> dev_pm_set_wake_irq() in probe has no matching dev_pm_clear_wake_irq()
> anywhere -- not on later probe-failure paths, not in remove(). Switch
> to devm_pm_set_wake_irq(), which registers the clear automatically on
> every exit path.
>
> Fixes: fbc5ee9a6955 ("rtc: mxc_v2: use dev_pm_set_wake_irq() to simplify code")
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260914134826.EC26D1F000FF@smtp.kernel.org
> Assisted-by: LLM
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/rtc/rtc-mxc_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
> index a07acbbcfaeb..7080aaf9ffa0 100644
> --- a/drivers/rtc/rtc-mxc_v2.c
> +++ b/drivers/rtc/rtc-mxc_v2.c
> @@ -302,7 +302,7 @@ static int mxc_rtc_probe(struct platform_device *pdev)
>                 return pdata->irq;
>
>         device_init_wakeup(&pdev->dev, true);
> -       ret = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
> +       ret = devm_pm_set_wake_irq(&pdev->dev, pdata->irq);
>         if (ret)
>                 dev_err(&pdev->dev, "failed to enable irq wake\n");
>
> --
> 2.25.1
>
>
