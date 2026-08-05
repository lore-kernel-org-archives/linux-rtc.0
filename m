Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013042.outbound.protection.outlook.com [40.107.162.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B833603F6;
	Wed,  5 Aug 2026 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916721; cv=fail; b=osonrm2tVSss/yygyQt1Xggak7/CZmF78ncTD1VDO8VJgJgYMvJbREME3Z5OObz8KEME0sYLuTCK4pES7qP5BEvnX9/fT4V9OxjZyUXpgBtdqmmwsBb4R45cvIGkFZMi1N74ytPz8WZgX9DbPdjLo89nTw54xOY+GvI6GmCmSdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916721; c=relaxed/simple;
	bh=5EQPN3y4yBOvP2KI0nVequKfuxjJGydQJR30veaVpdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kehuwyGwLRLm4pBdOqXr+gVwUoCZ2AHxY/zmMJWjbdvUC2AID8Okg4hTCVxsUAj7tnXzdCrw+l+iDNZF9qFOc9hheWSVZvKLSv9krb6pDK0xAycs6Sq3d8LTtCues4arr5K9H3aNEt+LxQmuMpqfCXJFuz79E1EzT9KIcGPlBvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NxTGkVC2; arc=fail smtp.client-ip=40.107.162.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NxTGkVC2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzSTlkjE7BQxlBMrtuS1hcH2TTKXaQ2OagC0JQwU3hiLJYxjeoO9cgQPPMn4lDAdyztvFv909dbNflFYEFosR+vCwN4y301a/pT9UF9Wg2GGl0pqCkv+GixNvr3hml8vY70b4LGQkfiF05tgLKKcU+cQDpzyzjIj4riTB/NDnvXhNUen+voYQ23QzeyoIw37CAwG7Wqck5Vo4bymobeCXpRB5VKqkpcgzERQTNpjvg/C0S39YAnaTS76/vMUq32i9HqQMg86HbuVrhnwrR/1ybkmU1/4eY0tXJviTel6u4w4mXgWaxD8ikT/sm8kjnhHm4aX79MKqRAJrpaRnxMmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOyil/NGwg0VaSdflx14NVa9rgx+efKsRRVNMmH6kEY=;
 b=NUyZGqSDOgo1gHTREadjJ5mWNY4OUVnZLf6vdenEnPHCSJg+eB/9XuVCoohBWsenE+Oo2Wp36xXktw8Kla+fIq2IgMEq4IRlK8aO1d9Z62iQtxnLDU/1YAr4KHDM4Cd10RUE3eUxhqV4UTkhKLuc7biQor7SYkWepDAI9opG7NHJuqkW4ay43wHT2h0qu9yuRN4viON4c6KrhhEpb4vrYmnrh3TY0sFRIMyTgiOdAFqJT+JVfuF/1f5t5L9DO1QRhQb2l65yC4Z/Er1eZnmKDyLkubHs6LQ7R0ldRy5B5bDYC6NJvo1tMwUpm/RV0mGK1B/Pb/Xb65l+nZXfNTxeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOyil/NGwg0VaSdflx14NVa9rgx+efKsRRVNMmH6kEY=;
 b=NxTGkVC2SBUyE/gMzqgu00Mcx0aAljaa8ZpXHNx81yM/hepzj/+OOyd7x4yYSo+dP+MeFqmzJISwLqMpmO6kpSij+9B6MQCcxLk5iNOcWy/l054Rx0zOwyWWrYgjrnjLSPtaa27LNDtpqsv6TWWD02rjFHx3ayRQf6DqTdCA4OasZZnfFeD4HakDkhff5rCcaTUrj1GrZa5T1Jfeaa8dLNKc6pXfpnWPxZKn+BOEcT1SHuU5ul/Piz0bz+X189KpZw/cVwq8wzL6BlUNfba1NC+m3s7rOonidQqKHF1JiyshogT/LpIuuVPW+U0x/4W1CjF4H6FxwH6Dd3c4iWjYqg==
Received: from AS9PR06CA0294.eurprd06.prod.outlook.com (2603:10a6:20b:45a::22)
 by PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 07:58:35 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:45a:cafe::91) by AS9PR06CA0294.outlook.office365.com
 (2603:10a6:20b:45a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.20 via Frontend Transport; Wed, 5
 Aug 2026 07:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 07:58:35 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 5 Aug
 2026 10:04:00 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 5 Aug
 2026 09:58:34 +0200
Message-ID: <493ce8b0-0d4f-474f-9194-d16299ee2296@foss.st.com>
Date: Wed, 5 Aug 2026 09:58:33 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: st-lpc: get IRQ via platform_get_irq()
To: Rosen Penev <rosenp@gmail.com>, <linux-rtc@vger.kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	"moderated list:ARM/STI ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, "open list:CLANG/LLVM BUILD
 SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
References: <20260714002259.1392655-1-rosenp@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260714002259.1392655-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|PR3PR10MB3914:EE_
X-MS-Office365-Filtering-Correlation-Id: 514cb983-0744-4647-9795-08def2c759e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	yACAWsGaAs5m4VCQxeHigXrIZbp89fNaU9ULnhxW+zOZRsKJNpN5N+ZsQBS0tWwbSci3fqGEBlbJfAQj22CbJ94b5oIdbCs4wXnTyddyh3JTJ5GBKzAu9qChVc6L5HqtLSpeFRg1WVpi5znooEWbmJIk7ruI+2x0ja4T8Tq0j1d6KTpb54f/npqh72pybigu7jJEDwtdz2UdsrPCeuun56fe3+f+XJ/xIDoRGxRky6qtMKg6I8dT+ey9cd7owcHQlJbc+/7juyIiWwTJjqrfRvGZbe82TE2QPrBaqZ1PjXiSYZ9oW/wnCXys0Zw8p8GqYCLC4yRJKM/sVbZaKkfh+ZHk2uDY3FkYhayylnVmH/wFw1OVNKlIpBxJ9lhOEh0nuRw6swXk36Mk7/2R0KIptVgwzV27bAk/zzS3BSYfEv/wGj/rIPfI6oQnrTP/bYfgLgM72t6aeism6TZO5VPrHFwecUPMIDR2qGH5W05enrvzqKFFg8dhhTmk19pGO/ixsLsaQBSlIvVtU+1GiIC9apepRv85ellS26yB7g18gfVD87P4m+/MKuhmFjZAhp2qRNswUvVntb5YLdlG2QzytEFfOTG6mexQt5fSvXNcdjtaShAGPBg0r27a24NBrffI4ojhMegEjYz852D2u/QM1k2ovlzY2Kc31BB6H9HWO7m7vQW/lK8z0gTxAzP1pSLwQJvcJC0cYPfGmKpQipsYiw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	89oXGZYSMIEtBDbCZZEVlPRuYLlT3GvVGngOEJEWKXh7DEN141MaeL++2opKJXnd2IQYIcqNlVdLmbsATFE6U25UBuJAiFouA3eTSZT7JzcLuZxYjVdDumwRGTs1SstTOyYILXHRrUoywFaLP2wxaRsZb1COkOrINA8mBcjoDqypMdkT5c43gkJ0kdFPVhRmT/RlV/I0b28jBobNmL42TfK0DzRC+/sHR/kpIkoLlWc8HLlt0lLwV4qIfTJp4/REwfGOdbyIe9Wz4ddqS320jOhPN5SkIgHsaNtTvngX00SURY4jDBHC5IBK/rkpekkeI290HXsXh8PZnK+kTblSt9jCwm962E/zaSZLYt4mQhUMIqx5U8qtS2J+XGIOF6Ddpy3KCSIrXRdxiL7qr/lsOq/4uifvF4+8+fvdT13cW/xLXZALbn3SBf5l5JaO8m6h
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 07:58:35.2803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 514cb983-0744-4647-9795-08def2c759e2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3914



On 7/14/26 02:22, Rosen Penev wrote:
> Replace irq_of_parse_and_map() with platform_get_irq(), which resolves
> the interrupt from pdev->dev.of_node directly and returns a positive IRQ
> or a negative errno (it never returns 0). Propagate the error on failure
> instead of the previous open-coded "IRQ missing or invalid" / -EINVAL
> message, so -EPROBE_DEFER is handled correctly. The rtc->irq field is a
> signed short, so the negative error code is preserved.
> 
> np is still used by of_property_read_u32() for "st,lpc-mode", so it is
> not removed.
> 
> Built for ARM (multi_v7_defconfig + CONFIG_RTC_DRV_ST_LPC) with LLVM=1;
> drivers/rtc/rtc-st-lpc.o compiles cleanly.
> 
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/rtc/rtc-st-lpc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
> index c6d4522411b3..ae79ddf24f37 100644
> --- a/drivers/rtc/rtc-st-lpc.c
> +++ b/drivers/rtc/rtc-st-lpc.c
> @@ -18,7 +18,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/rtc.h>
>  
> @@ -212,11 +211,9 @@ static int st_rtc_probe(struct platform_device *pdev)
>  	if (IS_ERR(rtc->ioaddr))
>  		return PTR_ERR(rtc->ioaddr);
>  
> -	rtc->irq = irq_of_parse_and_map(np, 0);
> -	if (!rtc->irq) {
> -		dev_err(&pdev->dev, "IRQ missing or invalid\n");
> -		return -EINVAL;
> -	}
> +	rtc->irq = platform_get_irq(pdev, 0);
> +	if (rtc->irq < 0)
> +		return rtc->irq;
>  
>  	ret = devm_request_irq(&pdev->dev, rtc->irq, st_rtc_handler,
>  			       IRQF_NO_AUTOEN, pdev->name, rtc);

Hi Rosen

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

