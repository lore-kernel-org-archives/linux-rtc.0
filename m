Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699AB48989A;
	Mon, 21 Sep 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000556; cv=fail; b=kZtao4lv3aMVnjku41t0jtj0ag+Wy8P2nfoXriir+mZcKoFO0wYikInqwnPd+x1LhgzMP8Cb2X4m8/4+Ars73CLD62i9bIEnsXqGL30ujkfk0gScfKtfby3QoUGZqffCogVExTNOvyTMCVbn3VWVY+ke4grsPwwzxPV2o9MIJOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000556; c=relaxed/simple;
	bh=Fi2OhI67TdY+nMCmqgfkOKveWbhbnR8K0mPdNgQiVXk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq5zRhMcHMLQHpCUy73SUhZKuCIfmFZ8mZzci7vpvHmuaE44sdCLvlg0BfnSZ9tyasSwI1TRKYTI3ZN5ju6jo2ezHrenjbvSuPhpmlSVoQepxvsETKNsNky3c8jbapA3fg0wuDiNeXT6mDjA2Xi8cXEwnJ2Pq9ZyNYrlJg69jIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=QkJHOfPo; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NJionOeq; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="QkJHOfPo";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NJionOeq"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LEL3Bk3839515;
	Mon, 21 Sep 2026 09:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=9rwZp41mkfAvFUB
	UlGZ4g+GbX6WjUGhqr9KFQ8kpgoQ=; b=QkJHOfPo84mcPORkK/t/nh15r6OmX0c
	QKH5dnlhRTUsScdZcIUU6Kqn1s9jo6bb1tU69wIiBjne6RKcFJR2GaIBLk0YZPnG
	K6pElqh10ftbKw8FX8g7ddNCaGMz7VNdFj9xfp+Pdj57p1qMbUtfTUSQ0DDkW5Co
	bg7zL35zj2N8UhfnBqtMbt4h2bE74FeX66JqWd2ViNuRtrSqLJMnDpm9YMr0RBax
	kEdsfbt5IarJcXU51D0nMZAwlV+BPKSoTffCaY6jzR5NbHjfACE1LGY74BhBUQQN
	d3asYHBuPJas3NSbWrx5IVjXQpQzOHWM88gdkSku3MbUO8n7//9J9ZQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gtx9fay6a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:22:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ncf7z+mAitj3ao1h/jCZKsk//G0TC7sXDJ+7Ymnys3L2cLQfryjIYOQYwM6RbG//j723AS2npVv8N/FXTXtbAwUQwcCEQRt7b8/ks4+jYFwJ7yLgzjVbQEP6+a+AgrArnSC5Rd4u3oFBPkfZ2aFOyHEW8GY2a2PzWdnFPmCqHxvA0/PxkA2vS0ry46ORyMa+kfww4LaxoxTGH6iA1zvHw0Tm2aDzDLrf3qqCd4sWHmOGadQVGOZmf+4v7i38XS/hQqfGhFMyIekpjvrwOzFmRRg3XM7oe9f1XVT2j+k30XWcQBPj8Uo6ENkZVIrs79ckKZQgJpLEqHSZhyZq/Qus+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rwZp41mkfAvFUBUlGZ4g+GbX6WjUGhqr9KFQ8kpgoQ=;
 b=wPT/DhfrhZRH2NMR9D0shtMzKTHHFqQcxAXOBRya2gXBnCm/7XMQIF4oHAPBvXkvjTR4Ax/VvVeYKymmsS4z93EV/KUBT6fB88KB45NX1/wApGXaPWYykx2Gw1cwM6zzhRUFQEhOvbRe2716lw832wJy/yUTg+V6+L2ZCWZC0BSBegi5PNX5dWtxMrZ8fpttAD0cifE0LMdQEdBnRHULYJ93DfX0Xesms3PD87rAxeA+A60f4SAEZsoxLO9qIjIrw3kK+PjzRsHaAUTpx9+Q1L+2iSgxw0Vxc6nbh8vQL0elbr9KZcMpghdyxNrKkIZY0jY7Lr7Hw2s4ZajLC+caeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rwZp41mkfAvFUBUlGZ4g+GbX6WjUGhqr9KFQ8kpgoQ=;
 b=NJionOeqGc5N5q686Jv1LOyZs3LW4Rkiu3fRHaQ+B8S/nNHLfuuG1WwrFOONPkpzUHArJNzqIcgin9SlSKNz6as8yQIv4yVyNHXo9RaIT6gQLbFI1pGMkSatT7TN3Q7MEgcPArA8dUT675/f4lVln7UpqQSdh32RyW9prLTBHo4=
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by LV0PR10MB997637.namprd10.prod.outlook.com (2603:10b6:408:345::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Mon, 21 Sep
 2026 14:22:14 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:e7:cafe::57) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 14:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 14:22:12 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 09:21:16 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 09:21:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 21 Sep 2026 09:21:16 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68LELG0L2225790;
	Mon, 21 Sep 2026 09:21:16 -0500
Date: Mon, 21 Sep 2026 09:21:16 -0500
From: Nishanth Menon <nm@ti.com>
To: <alexandre.belloni@bootlin.com>
CC: Santosh Shilimkar <ssantosh@kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] rtc: omap: remove unused argument
Message-ID: <20260921142116.sj6omirlxkrrjtgg@babied>
References: <20260917142654.2576889-1-alexandre.belloni@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260917142654.2576889-1-alexandre.belloni@bootlin.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|LV0PR10MB997637:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5b0e4d-ef9c-4169-6ce9-08df17ebbabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|22082099003|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	xXD6Q7xgtyPn4wUg8NUdr1ZpW6F3wcUyvH/gU1NHd9jxgEi4dKSpTZWWtm7kjEfw8jfJuxJjXSy4cf2n2S64FwA1LSfu+kHKrbnBh9OmchY55mxHJ8ZQ8zgu5M1vljEnC6lksL74BwGA7QOh4RIs2bRKW4E8PsSz6jL1d25ARHePJuGNI5wANgWVGrrtLvYsx2BYrw34ieQc0gTrAY/rg7aOJemNzN9GMe5AjszdQK6ZnNY9Mgab9ku64Sv1KbUIiTA8BvthH8Etc1UoS6qDgYw7MsazNdZiQDGRw/Xk4aYxUcDwfti2aiju3z2YJGI13RP15/x+ClLpsdhuqyo/OQRFkxASyd5RV3KPgyfV+toNGugMylUTig3ZuM3/4uopy929CPuiOWM1AtO/6WY1yCWAnCIi24RBJ+0TYw3puoAFogrVBpvIaNRPHfGdnFS4toirYAP35aqjfjaLgSBYoOgcoN8E1YcFR80gjtYrVPRnPV7VdnCK8Ag2Y1qZhIlxN+2gS3N8urPjVaMHQJH97PMwDJmUGcSW+NAWltmqVFRtIf5/QEK7lW7UGLsvWVO77MlAMpzd8Ayagt76h9TnHXLOBilM+oFMyt0N2AmzzKw9KNHgn9hxknUtPh9yMcmjpbJrHFAKt9mdPHQ2xWby6r+llc2J/JqpLUspUDITJUPcKZc31PL2Bq3AhwiqMihgmq0Zm8wDAQsihQDkbNo1QQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	803AIFCeI7OIF33eGUOfbGGoQs0REpB7f2np8eEQNQciMjBFs81Yr8Yc6uXAqSOdwaOeicm0M7UqLWb/Luqqge1e4pG2U7HQ1g8s7hjB79PJIXr3gdSkc4Y6x9pzqlK2S6ZW94Ot9rZyKOSqXgW+8aK1/3nXOfaZtG4jEkOdYO9b4RnRXsmy4ph6QtbWoUm9Tv+s6sieNsQ3Mig5O0sAQdKETaapqeAs0nlLlHifdvdMfqvnLs4id7UshW5+EGL4hond3y+cTbkwxAAZLt5zG0fcGPwWbijOfdJktIyHqhek/in03vDtzGPDlZ7dl39l4CoLfkAmyBnqtRCO6jVCQ+xbeAeUQnuU25kBsjugCk5K1SgvV6yZi7Ar6kpgLZejip598ItaVrkOt/xX0hsxLDkVkPf8jlUoHFeZyoJSAgXXh5M3QlNexmD7n6zUNepm
X-Exchange-RoutingPolicyChecked:
	o7dBhU/LKj09WxoGwBxqfpyS/+zKOBrlrF4WRxDtHdn65k9SybrMANNX9XhLHhPxEbFjamkvpAFiadRRsUtUdb5m8rTRZ6oCe3g1arHY+v8XwB4gcs1t1ed3n0Yf1d51OkWOE6Si9ZhhyA3NFHnWa4js5vzdEWUtrntF52cwGeYJEnOXMYkdqFNGYalisV/ufN71Ly35T5hOzR1kPy/yFbQ8c7pE7zI/T/CKpXwM32WcsPTCaQL5n9m54lh91Qzq/BWBoQVL4na9kr1Ntx0BJMOPNEcblQKoHHG2mtMdcp0dsXtvUyhxVNs401QIvFWWxE7eoDxZFBpICozDTgMHBw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 14:22:12.6386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5b0e4d-ef9c-4169-6ce9-08df17ebbabb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997637
X-Authority-Analysis: v=2.4 cv=Vou2kO2n c=1 sm=1 tr=0 ts=6ab13d9a cx=c_pps
 a=H8U4Gh8omvmqDI9iB/RWMg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=P-IC7800AAAA:8
 a=HiZL1iFsVPCgs9e9-FEA:9 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwNyBTYWx0ZWRfX7CMlXGT7+eU6
 BNjYl+SfVgcs7RS5GnIvF+/a1o4Oos2v9YEelpWVB9i9NfB/VE874UVx7VMrkfGF02hjhuOx42l
 YlzcBHy4n2ZcdCDZxaP42sQKgE2dJtGMzZWcAZ7pFg4HwQjCQFPS8ABx2cEviLoFRqYnN1WjWqQ
 OrAQiFjpP3E3kqKG0qnRiB2mKkoRQDRPmijkZ0Cn7kYT7cybp9kSFXC41VT77jRXhac8GF/b7vr
 l3Xjm9jmvl8jBI4eoj1uppJnmWnFdzXl3LILnvscAIP1k40WZ8pyLCSv6pIJsmDSl/rHmpFaZXw
 N67s7Mg6EdqOvJsg2vymezI+fL6oZk48zG6KZBfug0JKOyOz2/VtKVSypddZbtVKOKdJs8qKKGd
 Mh2XwP0QOlsiVuIiRsQ503qCjYmgiXpgObkiNMcD5DOFixAyaLoFbhjxAzS8fs8J3EHKFovxzo+
 8I+ITe5fx9v2UanAntg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwNyBTYWx0ZWRfX0945OQvpt8Nk
 Czrfonw4GCfWHhc59BxQouBQdWFjKoMognCAeNv1ZKkPtymEBA8Q4Xlsn2iDmeXrVYS9mQF44LA
 rNTtIRmnm4JgmbIhzShQTvQQNypyS4Q=
X-Proofpoint-ORIG-GUID: 3EksvaR-tjricPiFxz_nVZvnT7EbmPlO
X-Proofpoint-GUID: 3EksvaR-tjricPiFxz_nVZvnT7EbmPlO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210207

On 16:26-20260917, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> omap_rtc_power_off_program takes one argument that is never used. One call
> passes the struct device of the rtc but the other one passes its parent.
> To avoid confusion, stop taking any argument
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-omap.c       | 5 ++---
>  drivers/soc/ti/pm33xx.c      | 2 +-
>  include/linux/rtc/rtc-omap.h | 2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 0f90065e352c..18492165a19f 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -408,7 +408,7 @@ static struct omap_rtc *omap_rtc_power_off_rtc;
>   * generates pmic_pwr_enable control, which can be used to control an external
>   * PMIC.
>   */
> -int omap_rtc_power_off_program(struct device *dev)
> +int omap_rtc_power_off_program(void)
>  {
>  	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
>  	struct rtc_time tm;
> @@ -481,10 +481,9 @@ EXPORT_SYMBOL(omap_rtc_power_off_program);
>   */
>  static void omap_rtc_power_off(void)
>  {
> -	struct rtc_device *rtc = omap_rtc_power_off_rtc->rtc;
>  	u32 val;
>  
> -	omap_rtc_power_off_program(rtc->dev.parent);
> +	omap_rtc_power_off_program();
>  
>  	/* Set PMIC power enable and EXT_WAKEUP in case PB power on is used */
>  	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
> diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
> index dc52a2197d24..82979122417d 100644
> --- a/drivers/soc/ti/pm33xx.c
> +++ b/drivers/soc/ti/pm33xx.c
> @@ -174,7 +174,7 @@ static struct wkup_m3_wakeup_src rtc_wake_src(void)
>  
>  static int am33xx_rtc_only_idle(unsigned long wfi_flags)
>  {
> -	omap_rtc_power_off_program(&omap_rtc->dev);
> +	omap_rtc_power_off_program();
>  	am33xx_do_wfi_sram(wfi_flags);
>  	return 0;
>  }
> diff --git a/include/linux/rtc/rtc-omap.h b/include/linux/rtc/rtc-omap.h
> index 9f03a329e63f..d6ec7c4daea6 100644
> --- a/include/linux/rtc/rtc-omap.h
> +++ b/include/linux/rtc/rtc-omap.h
> @@ -3,5 +3,5 @@
>  #ifndef _LINUX_RTCOMAP_H_
>  #define _LINUX_RTCOMAP_H_
>  
> -int omap_rtc_power_off_program(struct device *dev);
> +int omap_rtc_power_off_program(void);
>  #endif /* _LINUX_RTCOMAP_H_ */
> -- 
> 2.55.0
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
