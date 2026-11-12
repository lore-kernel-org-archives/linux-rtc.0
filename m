Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445871;
	b=0OrxMuog2sXNBbtkDIBGCgNSwE2GjWU8jcZqT4fu2s89Ugh/4cx0t4EU1Zj8LBlztdz8
	 5r+F/9hL9f1e91Pnzq94Yf72whWmyd+k05nYE5nZio+RaaLEmN4Z5QpdIZz+pC6kzMMmn
	 a798JALfKVRygU4E6l6K5XtPQExe6sQ9fw4tHfOhO2Tuj7XduR01ileAtC6UViELboNh8
	 Wh3hkqDKtjOUq1kK4SxU4F0c0o1xuk5aCkqFntTiBNQdPSlSFe8nNYVsw6S/aRXzxDF0D
	 uYkIt82ExZm/iecpx/d6D6jBzUpH/q94xJtoNHj5/J6ZDRrJ0NKwBxPYjWmnX55mnsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445871;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QmrHElBsf23IMUbwK9YHUtTfXyB9Wnisafg9C2Jpagw=;
	b=E4OD7D37XbcSSyUicHY/AjYLCJzi6c/iMjQ8rvm5Dbai9UYpoMUcY0PC6xtOBsOF9+ud
	 9RgzapzYe6kpiUk025kU2Yyt+FdAErOrsufQAjx4ANCsiX9DPt5sO3dq/H53NiLF3VpDc
	 CIy4RC6GpQxgHvWF5x0vBHwUiJgdgGm5PQiO4uvy3tIutQxdUaF+byV9iHhXAPsxz6eRg
	 19QJqeEZ8rUyg/8Cxw/ufx/eSQjhrKfzzclWwfkVFKxL8ABGTe/14FeUIABVv8S/TgTGI
	 lCyQvY+Kl2PUVdKZzHqVy07UBluurlBrONlQOr3jzcfkKFeLPeG6bken2usffm4mYsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KXt3r1WY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bXZmDXUW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6187B606A32D
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 01:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6187B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KXt3r1WY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bXZmDXUW
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABMaItx395248
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 01:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QmrHElBsf23IMUbwK9YHUtTfXyB9Wnisafg9C2Jpagw=; b=KXt3r1WYwM/ozZZL
	Ay7X1bna03Z/ceKESF3colMRSF3IxKL1iW2kMg6D9V8i9pYAApbObGZKvVfhPvjn
	SDgWKYRaPRptrDd1RTvsZG12cZAxQ4a6ku7gl5lGlKnOa2L4S94KvRYXi1CcRq1n
	5T94zN1qm+HX0v4SyTENGIY1HghsOfRP6AmmqWbhmOQ9ySE3Nmf48aoKlowz5N4m
	2xD+FuaWWiwQBak7CjbMJF1qx7yFArdnf6u0j2X2wT/2XGdPa9JITB6Zwa+2xwir
	XFxTVBsue0t2VJclAbm9ACypiHoMgmHii41Z61NnsfkDZzlK1eE9SJCzGyr4zBKf
	9MMD2Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1uaa52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 01:11:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ea446ea8c9so2760405ad.0
        for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 17:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794445870; x=1795050670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QmrHElBsf23IMUbwK9YHUtTfXyB9Wnisafg9C2Jpagw=;
        b=bXZmDXUWo0WuBsS5DkZPCcFvT9bPNWGXwTvu9wMrthjD5EptbLqVzFQsIbl6SzZ8NA
         L3MjFYFV2B4FqxfY9FxsKdUV9t3sm0oLQzFrbnJi8XI9TPSg0WHpdsSiEPgm7lp/2fr0
         Q7xnCAR8a91nurUhIr879Y+ot7IDtN41boB6Om0FDgulCjaX/qj038W03OFqTjIbTP1A
         Lt0pBO7dk0DC93uEvDEqBKaagJnIalCOkZgenw1KG0M1IDreE5iEoOlpwwNpXMYyqJ8G
         j07H+i5TJg89BlKPhrXIXkINKrYDsG6N6rlEvJQECrVt1+mIQ8t6BQSWWbzJSRz3NY7u
         zKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794445870; x=1795050670;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QmrHElBsf23IMUbwK9YHUtTfXyB9Wnisafg9C2Jpagw=;
        b=HZqIX2PJKHbsSrjw6SWtHUzeg4/TP/ePa89SeQCXATke7PWrhOTDlkvU+AR8CcOZ/w
         Pp0pFRF1K5NSYXH7Ji1TKzqYwmx50dUBNXs//ep+LIlveWHsiZfI1e8I7QMYb/UBRegn
         brxNCTmVkqfSt+v8kOY+qJ5gyzJ+YTJ/swBUCUsIARrzreCQQKcj9rybngj5QH2Cd/Em
         ytiLFzowdQ7qZTcYDAYwxHaEpRHMRmF6aUw7dajp6M1HWMJcbVxueMlDy8TfMlh6By7z
         ZAppwH03iXEjg5cJt2nTJpEgbYYNRQPhA/bIbqaKHJnyE62huzpjeSZZ8GvzsKwucJnM
         vbLQ==
X-Forwarded-Encrypted: i=1; AL+hErG46tBgSqp/GcPMrYL5F2Vu/UWITAQ7hnoO0mRUUKIH1SHB4PhNhrz70ISDcDc6F3rjTScH+tizQ3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/keJLx6yhHb31/c0yv3IZv81VxJFujKvrZmvBYyvulUQvJlS78
	qr5Xs+gGGcBvnkD7MYI+CdBTA2iA3RnhNgysNgei2Hi5gMB4Up0BeW5GSJkxcNh8WXb1OuPsJWm
	bhK6cQAp6TSOwdUy/n7BuFzsD2AYMHW8ts803VDJbX4JovaCNHISd3UXO1YQVyWw=
X-Gm-Gg: AYBFou0yznE9h+qGr7KTL6vWJn4UqTD7NQDahDp/mlHIxgYDfCGkAmZO2o627GtoyfQ
	l4jIwFJg0FjyXRrlhXzUIkSFEaNA2JIM3GOZGFGn/iY8zqen8h0spQlofs1SzFdEziiibVxxe32
	Mw0gp7zN4qJJjbYdkpVrKU0Eskoe8nOErJPccS2FB45Bkt6zbM3WTA3blwe2SiAKrnUu9B8oQ9O
	dWqt25nNxzsLtUu3kYYgHrYFp4GX/+rH4dyWATDKwcdWP0NEiZ6icsejtnLSrm1YspceIGS8p78
	IxEnpMHmc6F7zdw+lB92XSG74TRG8HIHPfLMyN8wWRlFACbvyLT+fL+ee7KhZtFUzHk01N+A6er
	IEte9RKaCytuprkVhKkBoYhNJ9if1CPZEGsEKJOSox/jRZA6pU1XSfBZOp8IS/9pUamuJXeUKso
	c4S+tJTsftghjDHOOdRn7UKKhtakZgiQ==
X-Received: by 2002:a17:90a:ec8c:b0:3ab:330d:6e47 with SMTP id 98e67ed59e1d1-3b197c92162mr618423a91.10.1794445869786;
        Wed, 11 Nov 2026 17:11:09 -0800 (PST)
X-Received: by 2002:a17:90a:ec8c:b0:3ab:330d:6e47 with SMTP id 98e67ed59e1d1-3b197c92162mr618411a91.10.1794445869284;
        Wed, 11 Nov 2026 17:11:09 -0800 (PST)
Received: from [10.133.33.225] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c768e8sm1599325a91.11.2026.11.11.17.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 17:11:08 -0800 (PST)
Message-ID: <0fa09b92-3855-40b0-af6d-2c763235b15e@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 09:11:04 +0800
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
Subject: Re: [PATCH 2/3] soc: qcom: pmic_glink: Add GIO pmic_glink instance
To: Jeff Roach <jeff.roach0@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261110-gio-framework-rtc-driver-2026-10-12-v1-2-e4164178183a@oss.qualcomm.com>
 <20261111131424.51869-1-jeff.roach0@gmail.com>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <20261111131424.51869-1-jeff.roach0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAwNCBTYWx0ZWRfX0pnbjqxO1BhT
 iQetofctihrGMvLNjU01nfZWLdsOaPDQxmVHflogsui4fXfc/68eo29CrAzufACld3Hq2ksZEvL
 qfH4Wbw7j316dsgUnZDhz+79vuv5ieY=
X-Proofpoint-GUID: 6U9SdThdA0dS9gemXWFv__LNbT7I0l1T
X-Proofpoint-ORIG-GUID: 6U9SdThdA0dS9gemXWFv__LNbT7I0l1T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAwNCBTYWx0ZWRfX9p6MawjL2mDS
 MOx8x4ZkVZGAPzLKGVJ4RlccJFD1Bqt6ew7//c2OgCGbnlXVbmpmG7+b5bLBpulRfDtiu3ziV8m
 tYhy+SwoM8eomu+vViHlbf7kI9JZcLtSSiX39VmJOlvP72BrDakAGBFKPEYZP5FwNqdf/0iIPIr
 t7eZOOqVvX2Sh3jSqDGflXpI1RMdX9mfh5IQRDa8M/MEZ3CNDxGMo8pokndwdBV4sPQWPyDfIgt
 45XR2tdUXIpxLJoVDOi6gFlzCV6NLMim9pfbq3+Nx2xp3L1YfSSKElEi5jVrTN86DJ0aYkg95X4
 OQIRpgZKF2OP7JVs9MidS4GrAN5p0Jq6GC2iJ3BHFaj7p+QpEHWbjiBuScc/6U1gkLbzHO6IO04
 00spO7Tz8x5FuBMlVEBGNVzvvkiDngvoJ5mlM11ThXQvQ3fu5mlMrlYRX+JOBuSWEbmKUu3WYqq
 leAayMOlr3hJAopYnLg==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af5122e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Xxzc40YL-po_xb4s3SgA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120004



On 11/11/2026 9:14 PM, Jeff Roach wrote:
> Hi Fenglin,
> 
> I tried this series on an HP OmniBook X 16 (X2 Elite "Mahua", DT boot,
> qcom,glymur-pmic-glink, 7.3-based kernel, firmware F.04). The RTC part
> works: rtc-qcom-gio reads the correct UTC time.
> 
> But UCSI breaks when pmic_glink_gio is bound, although the commit
> message says ucsi stays on the legacy interface:
> 
> - pmic_glink_gio loaded at boot: ucsi_glink fails with
>   "error -ETIMEDOUT: PPM init failed", no typec ports.
> - pmic_glink_gio blacklisted (patched pmic_glink still loaded): typec
>   ports and partners come up, plug/unplug is seen.
> - Same boot, then modprobe pmic_glink_gio: the RTC works and the ports
>   stay, but UCSI no longer sees any plug or unplug (old partners stay).
>   USB data and charging still work.
> 
> Happy to test a fix.
> 
> Jeff

Hi Jeff,

Thanks for testing the changes and reporting the issues.

I tested with all clients switched to use GIO interface. I confirmed
that battmgr, UCSI, altmode worked as expected. I should also test the
hybrid mode of only having RTC used on GIO and others left in PMIC
Glink. I thought I didn't push those client changes so those drivers
were not impacted and they should work as before.

I will test it this way and get back.

Thanks
Fenglin

