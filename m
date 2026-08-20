Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2545FFAD
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787243907; cv=none; b=sFLBy+MEGQdBxzyYhfCKu3CYkDQv4l296+dodd12aowV6xFm9RKP5iCjKgDR4BacceQdLoPkqkSYRw0q9/lgHg67ISsEHsa6Yrs0a1zDMSmrj00Qo2t5asZuZQBZHjgzqX89d0vrwBgoT5ei0xnlhg514ebgfPnQkNzKve8EvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787243907; c=relaxed/simple;
	bh=3wJW98XflLtaOT9jCkfJCEzdj2hb2N4cu5BJxkHFG68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7TIgmORORkUpCpRYHbkR2CPtjS5gJtTHJbGmS4LmPZBl0ZYycAg6gfojebt/phrfMeQjb53nJYPYPoQ8k3nDoeNwG1G0tAnnby2ceX2oblONapy/QNnB41D3AAcwaG/9W3xPACy+nfmtJYfrwRYwOnSlmPstfZY8xLvoXcZBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bK3uWMI2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SHVRrOS9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bK3uWMI2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SHVRrOS9"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KG74od062675
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 16:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ql67hRddUguykUiSPbDbJEU5
	3SdkjDitCjeD5xqABPU=; b=bK3uWMI2izKg1W79iJxY6edtpZnHtmgjevQzRz5t
	0DENnDWqwBGch6HBkYfnhH82DduA8Uzf3GqZjpbhvti67Fev562RkHVDCzhTPkpK
	ULkR1kYz3qTL9UhwO8y+9dMxHn7NxKCVSH9UoDIQgWNMdrWqMfZ5K3DpJhDa39hz
	K2zBfV5rhlDDgOBnwEsRco0DotXc3D9wi/GhdZLTej5J9yTTDCpN8S1T9n4FU6PL
	OOULQMso6tD8fsVJ35Xhfqr8GAkgfKgKmbhfRR7Y88cw3sRRqH5RbF/rxm9EPSlT
	hFQmRoTO+7WUkBAsy5dwbIj7QM0V532VaFLxsWex7w3vBQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg89q4b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 16:38:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3931cd2e4cbso3097663a91.2
        for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787243903; x=1787848703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ql67hRddUguykUiSPbDbJEU53SdkjDitCjeD5xqABPU=;
        b=SHVRrOS9+DEup+j9p5VPDUccWXYy0GmArBXfEDnNg8TY3p+orfQXxbwCmdZDM7lXAF
         fdprAVJDBSePZlwg5XaYEyelrgDKXXQ8gsEAxPcsfYwM25+vr12veoTwT0RhRV97wHsd
         XcNon/AnJvTQeRyYdOGgayA27IObVIIBoecPKMYAiMqlK1utXFtr1S+xJ81kWyf4bGx5
         HXZV9sDpZp5snBf2qAbfk4F7nZllmL25RMtQtayaLLeZDZB1hSO7RUQiRjSViCNRs5/1
         tQBEuI9iWGIKCODY1Jh0dcorQLyAOINvt6CSF5KxPMx4qR7aUlwPXkIkmQbf7CxKR37w
         lGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787243903; x=1787848703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ql67hRddUguykUiSPbDbJEU53SdkjDitCjeD5xqABPU=;
        b=WNSgdOQHufjHkpfQj3IXSvJtQq7SnimnPswNmXJ8+bMdjng47Cdd0NnbPFDjgXHczL
         N5pnArxorw8sKFNpmc6UbXl2bHWDTck9/sFe21O0f6iWJH509Kmpxp7VJ8E8SkhZYPdb
         g2t/ere4zCfkyjCDJP5+6mQ5lnbYk1uKtjZSFIA7Z59xCLotMSDg1lOeCr8ncgQeHg0i
         lhRHsdZtaMdZxYgYsR2weemphCrMwIQCydhXQNSjOWkGWSSBrPK1S1Q6MJJWlC8J+Mkk
         D5e8BEWVxwXSxL/6OT7ea6VvmrcIilPt78SiDOVgmvqcIEjCBQqT2MAzUdlOLSpQl37r
         MMaA==
X-Forwarded-Encrypted: i=1; AHgh+RrbtKoEgnv97XxIzc4Gn/c5Huyu7QwGnE/8kbIZoF2tcDQizlqwHsK76w0wNpkJymFZJ4BR+K4YW5U=@vger.kernel.org
X-Gm-Message-State: AFuF++mZCa15bhpRiMp+G75Z8gFXJcA9g2JaTB7AMBvEqW2mL5Qo0oFb
	IQ0I81zo+uIjX41Zwxp/KUm0IvDyFx2hdRsO8k11nR4DugWjulu8Lk5DWrl8gmlySSKCKKIIsiD
	tLoPGn6pNzYMFlO5I1Ndkcxm6Pb2WqAEyQti5PPsnRQuny5ZKruQMHZHxMcMOwgo=
X-Gm-Gg: AR+sD133XUrOoNEDKWqU84TrI2RCM0C1j7K3RsJ41h+DDzhLjs4t9+g7jkgX6tpW8Zc
	d2pzLR+ZhxNuJprViBaUDbYi2GHwaZOLREge0ZijM0P0+T8CJO9cd9ZZcOhMP3zItfAFmedFHd/
	d+ujvqWpULGmvyfFgNviCmIh3q73FfXNOoXX9Q4YdfOsMReg0rd/SqrFobZa65/6soRb9s3kRpT
	kRTOc09Q7z1N0Hge1wJY8qxFYS/5+3zFZxwjHPAAJOob0dJLHjiTpWymYVkLYFtOyH95UQlgXz4
	ndsG1kfrUOp2qBNK0SJkDQg2q2Ceb41K+t3dGM9/4ftGAr90raL/7+l7Lm8IwLP1uPD5qFWSYrD
	M8zBWBTjct0NajBAziqRLl+fWli2cKg==
X-Received: by 2002:a17:90b:3145:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-395810af13bmr22648328a91.16.1787243902689;
        Thu, 20 Aug 2026 09:38:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3145:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-395810af13bmr22648206a91.16.1787243902175;
        Thu, 20 Aug 2026 09:38:22 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb4ffb4sm6972093a91.5.2026.08.20.09.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 09:38:21 -0700 (PDT)
Date: Thu, 20 Aug 2026 22:08:15 +0530
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
To: Troels Vognbjerg <hekatombe@gmail.com>
Cc: alexandre.belloni@bootlin.com, andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, raryan@qti.qualcomm.com, robh@kernel.org
Subject: Re: [PATCH 0/2] rtc: Add Qualcomm PMIC RTC-GLINK support for Glymur
Message-ID: <hb3jvyuf2j6sl7pjimnccoj4hsmqtxdq6s7w626sbmpbcqw7t3@wzyo563dmcle>
References: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
 <20260811121012.7046-1-hekatombe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811121012.7046-1-hekatombe@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyNSBTYWx0ZWRfXzj94PedrazTi
 kxtWRft2jS1y0io3e5vOavT4Jmz3+ACnhtMnip4UCiUFkRQl4yqadWjVcCfI+hPJjdV8AVic2MT
 BBlkW3O6FCxPY9qivK+d1gzQQuIMQmc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyNSBTYWx0ZWRfX/v7YUL7wRni3
 p1/zjJDfqQoXR4siIKzbfXwNrevTyO3MjR74KRkxqfv+VFWpfC5PPSIGvbr5ZAzaHyF7KLPASy1
 WSiXF+DEvMqaX5GJALFYmcKZYkWM/+cnVFOJiy9Lu8pnfJXCsfthEtv2TayHDcylBs/i3vDV3Zz
 8rgZ4+86EFS7uz/XWq9FZERjrxxRF1wUmKS7tB+byxhe9c4tpKznle7TStBbGDSHO5asG3US+Mu
 bSFK73Ti3kewgLJhQKELMGY7AlWKVIQD9mIb98FBInt29SdoSSLy7pg1JrWaiNVr/p4o0CFJTek
 TetKD0bVona+Qkt/ks4Q9i9NVewXBDl42XUD4cscsLp8c3mP2teV02oTj49YdxatokFIJbYo9xr
 1UJhyFGlAIsnd+IyppDpqPVWQImg7fR88qWF7eIzXPR4HS/ibiWbwkFUenFc1yYQgQmGLv8RuVv
 BY7lPQEZ0ZCbe5nzRWw==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a872d7f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hkoF_9UkUv8IWmCfoxQA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: GHM_x2PXPf1CgqIszhgBWwhJSev-v0GY
X-Proofpoint-ORIG-GUID: GHM_x2PXPf1CgqIszhgBWwhJSev-v0GY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200125

On Tue, Aug 11, 2026 at 02:10:12PM +0200, Troels Vognbjerg wrote:
> Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com> wrote on Fri, 07 Aug 2026 02:26:29 +0530:
> > On some targets like Glymur, the permission for receving the RTC
> > alarms is routed to charger firmware running on remote subsystem.
> > 
> > This is because Glymur boards have to  support MSFT's `TAD feature`
> > on the windows OS devices.
> > 
> > So rtc-pm8xxx.c driver cannot recieve RTC alarm IRQs via SPMI on
> > Glymur. So in order to make the IRQ available on the Linux kernel,
> > the PMIC RTC Alarm IRQ must be routed to APPS via remote subsystem.
> > 
> > To implement this, add support for a New Qualcomm PMIC GLINK RTC
> > client, which will request for RTC set/get calls for time/alarm IRQ
> >  via the existing pmic_glink interface to the charger firmware.
> > 
> > Also, add a DT property to explicily support enabling the RTC
> > writes, keep RTC writes disabled by default to align behaviour
> > with the existing rtc-pm8xxx.c driver.
> 
> You mentioned this patch series applies to targets like Glymur. Does that include
> the ASUS Zenbook A16 UX3607OA, or did ASUS do something different on this
> laptop?
> 
> The reason I am asking is because when I build this as a kernel module,
> I get the following error message:
> [    2.241461] rtc-pm8xxx c426000.spmi:pmic@0:rtc@6100: probe with driver rtc-pm8xxx failed with error -2

This is a different driver error, this is for the one which works on the SPMI bus.
While the driver that i have posted in the current series is based on pmic_glink interface, which relays the
RTC alarm requests to charger firmware running in remote processor (which implements the Windows TAD feature)

do you have this `qcom,no-alarm` prop defined?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/glymur-crd.dtsi?h=v7.2#n565


> [    2.499556] Modules linked in: rtc_pm8xxx aes_ce_blk ghash_ce gf128mul sm4_ce_gcm sm4_ce_ccm sm4_ce sm4_ce_cipher sm4 qcom_battmgr rtc_qcom_glink(+) simple_bridge display_connector
> [    3.277788] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> [    4.318666] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> [    4.319085] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: registered as rtc0
> [    5.359404] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> [    6.400331] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> [    6.400496] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: hctosys: unable to read the hardware clock
> [   25.447761] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> [   26.488271] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> [   27.517573] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> [   28.560114] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> [   29.609224] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> [   30.638629] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> [   31.677524] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> [   32.720749] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> [   33.757662] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> [   34.808360] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: all time sources failed
> [   35.837651] rtc_qcom_glink.qcom_pmic_rtc_glink pmic_glink.rtc-glink.0: 0x68 failed (-110), falling back
> 
> And the error message keeps repeating every second or so.

Sorry for this, i think the firmware needs to be updated for this feature, I will fix this by existing cleanly
if the firmware doesnt support it. To avoid repeated messages.

Also will check internally how you can get new firmware (if you want to use it?)

Again sorry for the trouble.

> 
> --
> Troels Vognbjerg

Regards,
Kamal
