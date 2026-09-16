Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF944999F;
	Wed, 16 Sep 2026 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545012; cv=fail; b=bZS5N+dEtlhNw9vqpv6WCvqFrrx/ULWR62aGQmwUciDx0LN+Ko1ngXn2eWsXUII1kmRYc0TdMmipofekgF25bIH+mHVK/mawX69r5y9ERrB15JkOjeMVPXdRkXtIUeHH+k4DmtydAwfxdKQ8Z0G0Wtqs/kjs+3W4HVy9H29/zWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545012; c=relaxed/simple;
	bh=h8OKSRDRWsryUNd9de2j/r7okLSQONw+qKcCQrO6hFM=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iw/ntc3SNO7GylDNuCVGCdGURBXyzZTTdkyuar2YI43fjQN0rBmGBMl9D51eAg4z0kRkprm4iaQVkuOyZrP91ZJQXjK5kv3jGfBISyI4VpZgPK9Vt3dqNYfQzvuDJZWIePDGnQF/aBSD240REoqEatqV2JtTP9OlgnOg5ZFDFG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=HpsNMwU3; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HpsNMwU3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBfKjg4Z2uTBJ792yz3ITxjQsyrq5ZMN/T1oONmWTnD34Bf+giMa5GO3xc0CvantPNr/c4bYLYJ/s2AMBuqndZHtWHjTWxdvoR8Lwe8sk3p3wDSRDU/pPpUwOFfdPs7cPYdDV46Zomlhs83qstl8tOuyIcvB1Ru/3JZ+bvgiFnup0iNgoXbgFrjlON5c+ImkEME+njZo/DGjl4rwx7R74+kQrS/sbG08csUgMHh/kONK0gsJlZNLOy9Nl4pQsa9XImWLJNGfeu9M6vgmWWvaYP7pfaxNjkWupSVAGO6eAjbSfiLzHUkwyo9OdZHQP9Md72E61ItxwjXdqlt3FFIvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8OKSRDRWsryUNd9de2j/r7okLSQONw+qKcCQrO6hFM=;
 b=HFb+UotQZr/OWI1ZRR+cOLTWXk3RZcWXGUCFBjGmPe5Hqd1JQFFcvYl7ViVwN8llMQH/KQIotZ/uaB/m9O49jZz3p5sznCUcwbHxZzJ6S/n+wvG3kBp13mWsZJClatZ/RTbgJXeU+STmFXsF14RcKjTPWQZqPE59LUqNwrbcJXyE3+lHzfm5VzNhiC0MxXyDaGzJjlgbgbCwXid+b4K5McbJQkT1pMuGmToBTuqn/gT9nIy1U2MOwv/UUDAumEppKOBqzeN+FZod3KHLGC1v45ZeVHk+BYcuTgEmpA3zBPwHoz7oz+xrDTtf7CeG6Po3ownbDEOPZlzKAMw48QO9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8OKSRDRWsryUNd9de2j/r7okLSQONw+qKcCQrO6hFM=;
 b=HpsNMwU3ZTPzDGdbEKlWPwkjM74ymhyRY5cDq+nwl5jiBDoi44MkUIyCOmelfv8AdYNl7P7O+D+MZNVmLWQ2tr4mhDLXjmXCLHy+mfpKW3JNDjxrVDe+PGb4zRRlKU/j13lk3IAcO9pUO+ijPp9wM2u3EeH4ZUN0M+p9OHcMvNmsoTGXEoVSCqjMWmXSmjyWUpcUEJ0RzF24EPx3qynZkrcuunF06tJPjhC2+838Ybs+cLHDX4glEjb/b7/DYKK1oyre38ssvcZoMkFzgHaEesxcHnt10zylyfBU0GPgmNYrmcez7lfgXtTDVL05cobfA+x82hyc2AUYPwiiANms9Q==
Received: from PAZP264CA0066.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fd::23)
 by GV1PR10MB6610.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:82::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 07:49:50 +0000
Received: from MA3PEPF00000405.eurprd04.prod.outlook.com
 (2603:10a6:102:1fd:cafe::9c) by PAZP264CA0066.outlook.office365.com
 (2603:10a6:102:1fd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 07:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MA3PEPF00000405.mail.protection.outlook.com (10.167.241.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 07:49:50 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 09:55:20 +0200
Received: from [192.168.8.15] (10.252.27.207) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 09:49:48 +0200
Message-ID: <42229fe3eb17bbd7375fc84d1c0509eca8bf2aaa.camel@foss.st.com>
Subject: Re: [Linux-stm32] [PATCH] rtc: stm32: fix clock leak on pinctrl
 probe failure
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Cong Nguyen <congnt264@gmail.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: <linux-rtc@vger.kernel.org>, Linus Walleij <linusw@kernel.org>,
	<linux-kernel@vger.kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>
Date: Wed, 16 Sep 2026 09:49:46 +0200
In-Reply-To: <20260914132914.2371788-1-congnt264@gmail.com>
References: <20260914132914.2371788-1-congnt264@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA3PEPF00000405:EE_|GV1PR10MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 30690346-ea92-4de8-0df3-08df13c71646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MGWFqH8gY6avVvGcbhXKkh0/2FGyJA9pfchKYpqWoWdmEtKqM8q/9HF0ExttdBQeFciJI3V0qQe7F5NBYTKcUN18sf8xbpqdWRCJ5CZkZKbF1Bwx52ttR1JI9tdz2rvwwgmP8T+SUMKF/CShc99PzXVZXannQrpFJGfMJJ03eBd8aFd51ogcGprvJ0pzyNa3/Lh7k1MTl22/hnOMQmBudv/UgXC0sk0u4+X9EY2J4EOYjw0GzfIFGYsZcwO2v1GTBK2rXus+WG+NQR1TQdAcE6dCX3Epo82cVn2umnAi9N0ymOjZb0NQkBJq0sc1ikI8nRpl8lBM8qXBnpkSdC6iIVsWGsL10hd1XLGXDqOTo2tC9I9HU41lyc1f7QThUpN88/SgssahlOTwgAGX21rkLVtwu1ySrQZyMZPWH3cFG59qRd+9hpPTsNhq6daJCQm0mBiIm5Mc2pZHQGcF95orJqnItLrlwYXrqMnVI0dnlCbEp7+GQsD67GZUq4Zh92z6LSPVeq13b+NpubH3nRZGJtU9AMNaEIG4LNsSBOjZtlCdcNotGlToO+Mw5QxPKJZuBDeYJSKZb+bTaNoaezMyqWBJ4FURxichMwpvLt1gsYd/C+gungf7Sn/O85FBJXH5eRSV8wMbVe2AIEbpkPxJSZVL7b52wS37pS0Lu8UwXjdD6EMqQbjK91MjQzuX3MG2ZGVIf8EYtwvYKNaUVqBKjg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	229HNnrZiqgU9XiFZ5S5uWpUqAfM1QjypEsvSrYbDk8ng6scXKbnW8mqDfAjIpmoovox+hAeh58uEe1aVQlh/RijQCZ2QyxfCROpLKCVr1+luWG01kP+8cbXQpHSl5pxuk2xaeZ6LdKUr/OwdRUIC0idO2aFrXcaiNmv1kWJ0fQ4VtxiIHdyM65mAso1NInr0V9mkSla1T3tOx4s6F2NSfXjkC8zYTX3jTc3yWDL0/BXoa55mogenLewVQejKMW7nnL/EiU15Px6Lnf6Dz3itDGStzJQJTTpn97kakBCsBcExQz0xYCITfARknuw3CaSDApiKnW75BK0ecX5NoCoBvYLfbx/i73TGcG/0zWNIR9RBMQRNQjfTh8d4nwAiyeYxZleVnOwyzG/ViOAUKR+j8pMb0rDhryjKOVWC7AuCh42l+w8MaNTZIz6gIsMTjX0
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 07:49:50.1756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30690346-ea92-4de8-0df3-08df13c71646
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6610

On Mon, 2026-09-14 at 20:29 +0700, Cong Nguyen wrote:
> stm32_rtc_probe() enables rtc_ck/pclk early and unwinds them through
> the err: label on every later failure -- except a failing
> devm_pinctrl_register_and_init() or pinctrl_enable(), which both
> return directly, leaking both clocks. -EPROBE_DEFER is a routine
> outcome from pinctrl lookups during boot, so each deferred retry
> leaks another reference.
>=20
> Route both through the existing err: label, matching every other
> post-enable failure path in this function.
>=20
> Fixes: 16ad2bc09efb ("rtc: stm32: add pinctrl and pinmux interfaces")
> Assisted-by: Claude:claude-opus-4

Shouldn't it be
Assisted-by: LLM
accordingly to commit 816d9992d9ed in latest
Documentation/process/coding-assistants.rst ?

> Signed-off-by: Cong Nguyen <congnt264@gmail.com>
> ---

Apart from the comment above,

Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>

Thanks!
Antonio
