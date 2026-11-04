Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781397;
	b=3RlCsVLDxvvpK0evysYMo1PDplTQJjapW04JiopAGVveiHEEneQEzMfSaR3xJlSa3l+f
	 AeFzcyDc5sCjcMjNPnAIntMKLYAXu6XzaSItqgZf5pjQc9ogv1Y85KbQPrSwPBoM9UV+f
	 RALK8IRktg4z9Na6q5VaxIb//IlL3OZW4AdxamBgnM9TTEPV4hIdUs0CHxtpwgEk6fQwB
	 7mHEumc79lc3NISEft6xf6u0SXbV5xSXzy5SbWKL3JZGWuW4cdIXoM4xSvyvHa6vjU0x6
	 7nhcoYj/jZNdRy77YLkENNxvU9B7+CC/bgHDmrE8w9dzg/9b/gcgReUPugylYaY78VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781397;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PQ4LinK6QHDjKioOmPQ+jXCD4vkH5b3yBrfQAIAIVJg=;
	b=I1GsEHkdw0T6bKGDpvt2SskoETHYIgilKT8oiGTdkVpsOmK8R5nElh6QuOzrfYjPDJM2
	 3AVHriN/93Pe7VEmpI43Otnn9n9R13jW4S6USduYXKvO6zPLobJ8hvvUL6oEErXpzYBOk
	 6KzYahzXsUGHrr9AJ/hIqTUTZPJFcpP1QECoy6Ief5xJ/nA2UC0U61tda0X7Yi/TUBTlB
	 jCeljHlqGU44Ml2J6E8MBzhC7/yqJhyTj25WHJhsEyJqfhamnQJkUdavXLUD7mMmLoPpr
	 K00kBjwgDLDHcMjgKPWqk+fyauPOkqFs9JMNj2ijls1SPsMk8AKU4dmR4JOgBoobFTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gbhK8BM8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P1yVSKWu;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CF606A326
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 08:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E56CF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gbhK8BM8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P1yVSKWu
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48L0Aa1274969
	for <linux-rtc@vger.kernel.org>; Wed, 4 Nov 2026 08:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PQ4LinK6QHDjKioOmPQ+jXCD4vkH5b3yBrfQAIAIVJg=; b=gbhK8BM8tMhhuj7k
	+5bSBMqQ3ZjaVWUje2lOUX0TsYEi9w/9QqWznoKL3Xkn3WkmMHiERtpA5mZUTvF1
	d2qksPWt6NNW9wQgQp5W59THeO9ULGUn7pZhP6+2CsX1GmpwMj52S3EhotynXLYp
	u6lDjkHiqcTW8Ha4RdJGaUi2rMQZVSGrEMUwbagcleLdiRwxS4TUuMigzje0cnc2
	ZgZAGt8G/Sg+e8TiDYMwGq3kBpLjW91MUFmi1dMdbeTAXNsCYcp6VztA3Q3icOyp
	6EALMXfDWHbzk/pLTYEtQrk/BILC+3GnlcqKLjFZ65FFeeHJsCqBW6cPmSePVun2
	K2UQhA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqhypm1kr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Wed, 04 Nov 2026 08:36:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-536708d1a3eso1380341cf.1
        for <linux-rtc@vger.kernel.org>; Wed, 04 Nov 2026 00:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793781395; x=1794386195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PQ4LinK6QHDjKioOmPQ+jXCD4vkH5b3yBrfQAIAIVJg=;
        b=P1yVSKWuHPn0I9HTe/wdzcKBD8CUwMCUAl57+2hUBxkFfMK6x76WWAh8AcrEmuusDM
         l7ER5iOb56Cb1mWOLllxFuAermXM70+FaCC3D8P06W9hS72yn+pkpqaJB8es+XXUa/kj
         qN1oLxM0zCd3ktcFjGVPZQQJisR04C9GVPaBKd+G/v3xjH36SHsiSScKQAkQMTh+LkWy
         MI5TDnut3RTn/n0lMa0brE0d2sPgKkHeE2AC85v0b2Eg72M0W37rZkTRlpO4UttTZqEy
         koqx7mXgdOXqVylKeipBKchZwCfIp9lDoLUuU17ZYu/Tv7L4CyZmselQ7fDvS2YMdU0+
         up4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781395; x=1794386195;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PQ4LinK6QHDjKioOmPQ+jXCD4vkH5b3yBrfQAIAIVJg=;
        b=x03QlvbuSpKlbC8QRjhbghGeo8qu37B4EM19vGElPINjgoJaOpQrtdJkinCGRs39T8
         qSfG4ggrm3EM0I9KFx6dOd2qGb60kLJkg2p4iYKmlaajr8NGqWGmjmRBq1SRv78ky6Qu
         NSWg4PIXSPE/W9PuigZHXAk8oXvVPGP5xm1Yv35hAVDbQWb4/u+sKkh0U06T2GWgEN3X
         4cSe/U2HCqonT2bqNjjb3SOFLf/GBPdFZqSlcMmhNdyCFzgryS3VCD3gpG7VcJAa/2sW
         L+DHYjHjVRaPuAnaJkDKUDpCM2KKnXqH4Nz/xPhCavGOBOUjnZ7KltoOLbP/HUEj7jUL
         6fLw==
X-Forwarded-Encrypted: i=1; AKwUvBwFeD6JsZwk0qgT+AxzDf1bVhUaT+5hV2UGP2nh8cxbWJDHhhcnEz0oyPk2NfY26uvOW+PMNqlxGlc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sabp3AAQ5u3rVFAnKFNl7Xi/nmACgqCBRR+R8xWYzBK9W/gCi
	kn4jyHAhupy6GUbzbmIzKEB1vg40FKWjI/+6zu/5PAW3q+tARjR7sVDXrNTRauYJ1RjxB8zwZAb
	DMyHp2yd1hIxSizw6dzpZuat6izQ6mNEC1t7WKq8h2/QLzUeZaPbuXHgSO5ILHWg=
X-Gm-Gg: AYBFou1QOyQll5IaR7Fyxc6eF2cB+qaXmCnZwgamo7zIQR1hX9wsh72PWzGSLpmosg9
	pH5IRZkhdJlCnwBx15eRl+U4L3e6gECI9t1zAIZzjOWkv7xCwkzDwXlY+tvYHEyEeAtEQ53u3mY
	siKgTny5MUH+GPRgxDbNobVn8XDiFxycKJ0NRzoDgR5sIKvebIl9jeJF5h+WtmVaNQMrlpiAu7T
	4RDZPoZkrDQPH271D8o6dgKx/qy8LTxVU/QuZw17S1m10RLeNISbCpC/1nacP5hL1uA7rnM4P/N
	HgdNIGTd56ljYsd5n4Cwy1s0zjbtEXRdrixdgTTdzEypuzufV9RWFJcDmgZjd7fvgyWg0H4PLyP
	2qInurEXZPGuAgjC6gxaXiDgoSgKQNgd60BvvNt1ZMJ0O4c/HHyw9z9owOo49Ge/8Ke0g
X-Received: by 2002:a05:620a:2319:20b0:945:c5b3:6356 with SMTP id af79cd13be357-945c5b36c93mr785273385a.2.1793781395204;
        Wed, 04 Nov 2026 00:36:35 -0800 (PST)
X-Received: by 2002:a05:620a:2319:20b0:945:c5b3:6356 with SMTP id af79cd13be357-945c5b36c93mr785269385a.2.1793781394523;
        Wed, 04 Nov 2026 00:36:34 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e424c34sm46273066b.13.2026.11.04.00.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:36:33 -0800 (PST)
Message-ID: <ea308aa2-8a2d-468a-ae5d-ec9a8ccdb2d2@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 09:36:31 +0100
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
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sc8180x: Add Microsoft Surface Pro
 X
To: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede
 <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20261104070441.74127-1-val@packett.cool>
 <20261104070441.74127-3-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104070441.74127-3-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX7IkBld1cef8s
 V8qXuq1Ig1GDiE48UAeFtezbNOKkj+xfXJIThyqfEu5BOgxvoqh27n2QBQBIduwWqXN9PRx9TF0
 +lOhyabmp6vrhinmo2aUu4CzrsIO1Bo=
X-Proofpoint-ORIG-GUID: atOYKf39ATGmMkt-uXpoPCfH5jfwhM_Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfXwO+0y/JRuezr
 5FUhyMQ9M1OixjDkdqv5BjHmBpEY1sM/JVap4vwz/TXQEQP6Nj1sLFe7Ze6TUNhdAR2DEYPdvod
 2wpyVDXTxEBgpAheOWPXL9uk8hYD0djFMuBdIZ98HVEkknoxtU0m+14dNTh04LoOQEy3LFzesv5
 9mk+bNRyRNQgki2/W84DDS31eLyuNgBwHKEAQbu7EhljYR+RO4wTVYU6kd2dPp7YONuajQMt6YL
 g2yPVrmDbYcMlGnK8Da4hsN9nq/BbivfZC2v67nvCNol4EHAG0cmxPN2HHuj9zPvjmKrI+NomVd
 QXDAYMDkMqXUERv0/XXHJVDgonQqjOxxcz4XXJSxOGRgyw/+s+xgA+YgWlPAuCnXKFvgU/oz4sB
 VSlWsAWWjK2OrChiLTZqqZiEdU/4OYXm2I7A2iQwLe8ycXcP8Sg3YgptbKq9YIYOcT6p+NvP8Vt
 ykruW1jUDOwcMqFBOEg==
X-Proofpoint-GUID: atOYKf39ATGmMkt-uXpoPCfH5jfwhM_Q
X-Authority-Analysis: v=2.4 cv=T94Z3PKQ c=1 sm=1 tr=0 ts=6aeaee93 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=S4lLRux2dGMH_Q5bArEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1011
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040034

On 11/4/26 8:04 AM, Val Packett wrote:
> From: Maximilian Luz <luzmaximilian@gmail.com>
> 
> Introduce a device tree for the Surface Pro X tablet in all 3 variants
> (SQ1 with cellular, SQ1 Wi-Fi only, SQ2 with cellular).
> 
> Currently working:
> 
> * Display, backlight (eDP panel)
> * USB 2.0
> * Wi-Fi and Bluetooth (WCN3998)
> * NVMe on PCIe2
> * Embedded controller (Surface SAM over UART)
> * All remoteprocs (ADSP, CDSP, MPSS, SLPI)
> * Volume and power buttons

[...]

This needs some sorting etc., but let's tackle the bigger prob first


> +&mdss_edp {
> +	pinctrl-0 = <&edp_hpd_active>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +
> +	aux-bus {
> +		panel {
> +			compatible = "edp-panel";
> +			enable-gpios = <&tlmm 130 GPIO_ACTIVE_HIGH>;
> +			no-hpd;

Is there really no HPD? The pinctrl above suggests otherwise

[...]

> +&pcie2 {
> +	// XXX: pcie1 and pcie2 are multi'd together, for now use just one
> +	num-lanes = <2>;

We should be using the new phy-qcom-qmp-pcie-multiphy.c driver I think,
I'll try chasing down the right magic values

> +
> +	pinctrl-0 = <&pcie1_default_state>;
> +	pinctrl-names = "default";
> +
> +	// HACK: Remove "global" interrupt

Why?

Konrad
