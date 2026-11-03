Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697180;
	b=ShyokWtdlvyz/w5feBXhRb9/ntWp1mBH0BJ79oRZ0mQmo4kk98KQ8jBmPy2B8InZxra7
	 O5ftyQFkQdFg7idpR3i/3JTxjlRi17gGKsyh832uyLtf/SEIwYIYyYpQIpnLKk3xPkNXN
	 kx0lF6yzFAOMgb6CgeRorFwStR4Fcc2ypxvYeQaFwsb/7lc8bKk3vkUlEcNO0ZaSQljRR
	 zY3ysqIe56McvH29Cdb5s1jEz2oARSxJ4k1l+OFTX//CGtnCo9sJyMtvYYbDyXm8YWiH3
	 +XNd7YIGXkC0RmlCPWEhLe6THVxWkUGPWLyqN5Obmd3WxYFPLnH6fNLTMmmp8s+cTSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697180;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9oFOp0yBXC4uh77wsDuOcoqxLQK5iMsPJrZNKlEEsr8=;
	b=huWp49YAP7fWHg05EyFLaNzrs2i68gjXE+7wG3T1FhPKnQWQTBQqm5/GjU2kuch/xZAr
	 iNX1Td0wdDyB72ZPSKrIDUCmd6M7QHfjoz5t+BbmE0h95kS2w27xkpFwBIMI2mc9iF1n6
	 F2Qw8MWnlGC/GqaBsVc2VlCXgawqrnA9xBxYOOMiKf/VXw6RpDes93Cinq4Wob2sPJEd6
	 gPl4XyzgyUI8SvkqmDOj1Qh9l37uGQbvoG21fQxOYtr3JdCCe/rIiFdNyC3KJPpSkisKQ
	 UZTsIH6Ssff4HBjPob0LWU3SuvPCwSMjIf/HlPgyJq9cJ+BCPPircy02QCjJ7aGqpzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DCz8XUD4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P95CNyOB;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87E606A32C
	for <linux-rtc@vger.kernel.org>; Tue,  3 Nov 2026 09:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C87E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DCz8XUD4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P95CNyOB
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A37wiRE2402921
	for <linux-rtc@vger.kernel.org>; Tue, 3 Nov 2026 09:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9oFOp0yBXC4uh77wsDuOcoqx
	LQK5iMsPJrZNKlEEsr8=; b=DCz8XUD40mdjSL1obAHtWV6sDJkw2cAjiH7qMdOc
	fE+CHwwc7C0fM3V5/YrN22mx0LNY+OUbJdY0LK0yEtWlzoP6x8Cmgwks37HlDiPu
	HGWt3m2pYVn9I2Blx2CNv6BXe33USiTDhZl3JGmgXWpWYLoV/rzBB8yi/xnvevZy
	8AzcAq2ffmTT+hVqt3ChhJ5MFOi/G/JI0XaUNddvoaABzW6DgFYE6yvkoCDkdRCs
	kQKQIvCmAQAstP/TsGD2BzCvT1hhukKFxBAmp4vPjQtmtReTO1LV9BcDQsT8nfHS
	LLxqWAVUZ307ioCe6ozrg7Jys/I+tkLMTYJH2ugdN5TN/w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq3uy238b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Tue, 03 Nov 2026 09:12:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ce7a85f04so774522585a.0
        for <linux-rtc@vger.kernel.org>; Tue, 03 Nov 2026 01:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793697178; x=1794301978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9oFOp0yBXC4uh77wsDuOcoqxLQK5iMsPJrZNKlEEsr8=;
        b=P95CNyOBj9MQ9wzuPhrHO5floZZiKhdlnYX/cqiaNtE2iyuNIal1i2xLQ60SJg2YY/
         zBwqd4LA2sRfQBDo56QFIqhey5iRFrxPPoMCSJC7AL+5WEOl/C+lExgTvKs9z7RTR8GG
         42j7AZBBDl8ZQo6Hi0WJCIOBWLD0rGjywiGPvcp0bSkJoqppGaqt1tSftzmozvzh6Vx3
         agjwibh+CU29t4KD4tE+/GYo3VdARO4l/DRstB9l9CoEPDLLd+ZmxiNoenb1ZiojWwG5
         OoBc2BerTrgbg/2dcqvk7nEBYDs/ucDNpeaHJfnv7IE04peJID22QgGTehoHz6iOxwC4
         OloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793697178; x=1794301978;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9oFOp0yBXC4uh77wsDuOcoqxLQK5iMsPJrZNKlEEsr8=;
        b=G1YEou+nbSwhTz5Dg0NohyY4B4vcmdV8h2e+dJ7WS6JK2CXE9Xcq/e9T3KpbDARISg
         4AIR5jVP+/cona8sp0JIiYMpNleHrrLbdskl7nQ6iUlxHjtFj28nc9o9wgU9Ijjl8Yk+
         LLK0oYHyfxTcVgCORoa/nvDsBcwUhLkOdNVeB0y4HOe3hpKs6eMcE9hp0jM2Iv9HTpX/
         XLfDqGeyYGXJNUqz+ZOJbxeMrqbTYnHUDWCtQR1lrgRZVRKyido+sfSCqy+9E3AlnBg2
         2O57V0Ig0WLPdhMrtfx3TdR1IJ01uROm5PtrWZGUeiYjZAvXrRAnv2OLMYRDzfuYvEpJ
         oSWw==
X-Forwarded-Encrypted: i=1; AKwUvBwc5cal0S+7n1nSBPVAUPEbPecU3Hx8x/ey8KinjI8gMlWOH31HqUPtxoPL2ia9GjbGvI+oUqwvmEo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zUn5g6sDU7dFuKcwmhR0T8gojoaabyaehtIME6WWjoRHd/z68
	uWYPzYmq+EfpJLzjRGOs+IZTz3Q3baewqy0BeutU2zHtmnCeGOz2OqZntrr44trSKd/JHItmRdb
	6B5hPySEReR5G1KCCxwbbNIIL6SlRmTejc/oGKYOrccUXQovd+7wVdLrg5Jz2H1I=
X-Gm-Gg: AYBFou0qCeAb3ZYDGf5CLx3CgHyBKMWCE7jvo3gG0fazU+Kx+fOscNc6Vp0DWXHOPL6
	+5RwPGtMK53d+fft66+mZgBuaS2R/y5YwdWJu8WOmJ4w+MoTYecmLHLbhaw26igbAyYw2naW2Uh
	Y1sX0kLDt+1vRF1KfKSfsJSJykRbYrMip76RpGmeNlKSp34ng6j7ANHLz8Dmw9hS3kRbRr0WQE6
	PVHcmV+XRkcB+ToywyaWWKJFsxz1Dw99HmheD1iy+5QadxmkWvCxAbQr6MZHJivvPo9CHc9cdxW
	Hlb6p7kJLWaMo1IrN3CWb1pAW9xCem5/Hqn+563wDalqG0uP1w88ttkWIb1n/NGIvTryVPz2ubW
	qK5rHIi7wXcQNWGFB9egHDTwk5hXvSGFwMGzytH7kkSTN3UVyRLW+uQpxSCoVcbc=
X-Received: by 2002:a05:620a:838b:b0:93b:d7a0:d9e5 with SMTP id af79cd13be357-944217c8512mr1958704685a.63.1793697177419;
        Tue, 03 Nov 2026 01:12:57 -0800 (PST)
X-Received: by 2002:a05:620a:838b:b0:93b:d7a0:d9e5 with SMTP id af79cd13be357-944217c8512mr1958702485a.63.1793697176814;
        Tue, 03 Nov 2026 01:12:56 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe7706516sm215839755e9.0.2026.11.03.01.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:12:56 -0800 (PST)
Date: Tue, 3 Nov 2026 11:12:54 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Raj Aryan <raryan@qti.qualcomm.com>
Subject: Re: [PATCH v2 1/2] soc: qcom: pmic_glink: Add RTC client support
Message-ID: <ko2v7vgyzqx2lj44syzky6fnyubhlhaimbeyvko2exujtpriv7@gv2m5xtjxlgh>
References: <20261103-rtc-glink-cleanup-v2-0-895eb6e8d890@qti.qualcomm.com>
 <20261103-rtc-glink-cleanup-v2-1-895eb6e8d890@qti.qualcomm.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-rtc-glink-cleanup-v2-1-895eb6e8d890@qti.qualcomm.com>
X-Proofpoint-ORIG-GUID: jEqAq1r-v-_MvddjE0qvl_U8pQ2KemSE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNiBTYWx0ZWRfX1OSmu7/FLR+5
 llcs3+2Yqo7nH6f+695Tz30Da7f/QPPPmgWKanNzktrAQppU+ukrcJ6bVa/rOVrPXbqDb5ZOaie
 2/EZcYH/90bAw02+nmJgokA45qwA5vPcQfoZ2fxNyguQXOwIr0VT0O078dxYEwlWD6agZtvOx/9
 u9z8GMda7RpQEcG4HYC/wnMbKO/ex/IqkuIghPshR4zh2Jj2yBMaIv+EMBtc10H8oeFo/lFsEGm
 14IJToOrJVQmWQVQYPXT2DtV4acTOsc6jtCUIhZrKYjWfMsR0fKE5Y6XWo6bweLSOOTAYLBjhIw
 Z9EiZTag0ZRGysvyOfskdMWi7+XEM48pAZ7jUEzccyYoeq8nLWNorFQTw+YjdkeyScn5opWZ5Uz
 6QNQ2lJHwYzXZWrDwbzouXUblEfOVKPoUUgLfCmtU7K/2/wZF/ef9RBgNO0mwh4jPGdVlUngR3q
 jp5PxBpuB2kLftl0+/Q==
X-Authority-Analysis: v=2.4 cv=VoG2kO2n c=1 sm=1 tr=0 ts=6ae9a59a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=fuBDp3P7rzG2D-Ll8goA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: jEqAq1r-v-_MvddjE0qvl_U8pQ2KemSE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNiBTYWx0ZWRfX4taijybirk+q
 MVHHmxOjlbHh26o66oOEil657zbQujGQzn6a61xI9IoYLdDVHNck7jtStxBlC+SVLjb5XCWylEN
 LJGqLEaxqaSd28QeA1p6uVMuv0fpLvI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030036

On 26-11-03 04:12:17, Kamal Wadhwa wrote:
> On some Qualcomm targets like Hamoa and Glymur, PMIC RTC is only reachable over
> the GLINK interface, so add a new RTC auxiliary device ("rtc-glink") to let the
> new RTC glink driver bind against it, mirroring the existing
> altmode/UCSI/power-supply clients.
> 
> Also add pmic_glink_client_unregister() so the RTC aux client can detach from the
> clients list before unregistering the RTC in order to avoid use-after-free issue
> in a scenario when an alarm IRQ is received during teardown.
> 
> Enable the RTC client on Glymur and Hamoa/X1E80100 variants, as only those
> currently support this RTC client from the firmware side.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Raj Aryan <raryan@qti.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
