Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649164;
	b=qAHeGagWU++bcl8siJ6iZGNnhF5mtIKLTmRM7pB5pxE5Kkd9b/rmhUSbaxoQgLbwQdS2
	 +4T0QTe6t4RFAF2CWwvNL1D9OdivCfukbQ1gX3vUZDhvxjqKGvXVB1PJiuy5tKwKzKRat
	 a1FwFIcVVpuXghjBBfFEtL9BbQgeGA22jUmebUc7s3wgPe/IRrH4E+YT8LLYJWTX9qGVY
	 mlTxMZlNBH+OQDxsjNgNMt1L58cIWVv2B334jqaxjqXKFuEWUdU8gXV9GPHwermkz8cgp
	 qJIs5+pjOqZT1W1nBXQo1hA6H0MyMYyuoqQsKLQymMDvMKegExyCi8kPEGtZA9Am0BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649164;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dUux21q4cPFzrk4Zy0I0IDXAjBQ6onqTlomYLes+A4M=;
	b=qfemmRWJLa5oNy0ngSUuiaxZ+4oa3YXLmXe1yEVtnMZWTmefnfdcN7HhwKAWZGL3BWmF
	 xcjF3PyuN2Y/vrrZMTYfvrKI23TczCipM2KiS86lIXl4jikNX+SoroZHlm8QyJIhIFnL+
	 g7BpwEffNvgiEwsrPyKc1oDI/4R0v/4P6VbLiW5sz2mYl6RHUlluJe37kvQGonTVrUms8
	 eX7s5SCIf1XhuVtE05iQWo1s6nR5HaaSTmooRogOh0+5rrIfqSZKKWUzz8CihzjbGpGA5
	 VSucWWA2j2raGMgNIjsBZt4CQa1bCcSYCdM+EqajPcv6V9ofBKQDwdhU4uEeq9He43g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ETIdX3jz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hY+aqnDh;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38871606D807
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 19:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38871606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ETIdX3jz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hY+aqnDh
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2HP3sH1333174
	for <linux-rtc@vger.kernel.org>; Mon, 2 Nov 2026 19:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dUux21q4cPFzrk4Zy0I0IDXA
	jBQ6onqTlomYLes+A4M=; b=ETIdX3jz2PnKgSLwmvQdODohKsPhIoWDci0X3o2B
	EjcdMAXRSNXoWmIWVBVt5cZqNjL6o3NvwoJKLL/+s60j3MYUGFW4cJs3RQeLVoTV
	HhASkB4HeE1Nk7S8o8cYeHH0xcmcUcMmA2ZH9p/a0VZzda1C6rNmAafL9E4F3DXL
	jC56FyZ1Cl/wr4DUtafoQGmIC2VZ1a4G2HG8OOJq22wrkP1kSlXi5/2Lxs808K34
	aO7s1/G5gPXmJlD9e+MS/TWEfOQje7zq2UNJ2065ttedy0VEq+Dy3/4iZflwQBQW
	Sq2XH1r7wKgf0F8Qy/5xIBDJ80/y2VybLvbP+0RSZCELTw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1uhc6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Mon, 02 Nov 2026 19:52:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso7703013eec.1
        for <linux-rtc@vger.kernel.org>; Mon, 02 Nov 2026 11:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793649162; x=1794253962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dUux21q4cPFzrk4Zy0I0IDXAjBQ6onqTlomYLes+A4M=;
        b=hY+aqnDhge/cdeYiYLcMt1cZpa57vMaHYDNYl3S41+cJw6x2GuCJ96CcaH2QKlpaeD
         M5p9cQZi4StS67f1tUh42/SIYJkmDZHv7n43d2dGpu5TMG79/w2I3mIOCtlS7B4dQL2q
         55EsuodQfBP+FYsX3KndiwsCSUFxCgkD3sO+B5GLrc7DdURQ4PUXk4iX4rhwzGxmeMJb
         Guq2/YmPXnbU99CZlG9MazfLt+uyFO7KoSeIYHeZtkwCwgdSIPEB+d++7DvQvGJZd1HL
         Y3jwi2XvVnMT5xgvkXGnj4beaK9Zt16GXPcERlVxdUiA9kIfBM//zWRl/JNU5cJ09Pqp
         UgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649162; x=1794253962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dUux21q4cPFzrk4Zy0I0IDXAjBQ6onqTlomYLes+A4M=;
        b=iO5kTLg7htBTJXNuy0+DfJZT2GdSLzXwlrY05sbAJpDshVgVy9Z6yT/Ow5ZM2uViPp
         e9Ql2w5zpWrcDe3YladdRAjfRNKYBa0TrD0nKdlcjNlsdRbeqPm9WsNxRHsWZLehiiun
         alaM4UMf9VDLItdhXhJ/WScP7McoUZxlejC4BcKJvpdGUsG+HQ7W3OKQyVv9x1Rw80xm
         R4ZEHeIJvdqOhe6FWY66VGLQnUAnv+YmEl4Ile4S99RF1cCazKdse11L+f7WSSfzSJID
         Y/L+7A2pWl6cY/0KpsxyfxqYUFxIlxi6wcr6SDnTAk1pU0ItipduyZN5G9aeUsDI4hZP
         8+Wg==
X-Forwarded-Encrypted: i=1; AKwUvByGnDTPeCGRTzXXXwslDoz3NWQ7QjSjcgFkszLZxPhsyWbkwdY/uSP+D6wC/t1d6rdRwGBfZwXj6n0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zallSx2vMas/cjV1LB2rs2J2P+P0BHbyO00BNysSiNYM3metc
	c/IqYmojCD/A8flPsKt59rOWxOkht3YKPRDH+JeV9QlBtG3Bv0gA/CNNwVydUJK5meqiZDxq1db
	5rG0/EbkIPyfp9AssjCjHyX1A9uHyP/yYjJjYBgExmnrlYTQE5JwIJlxo+pfm0VM=
X-Gm-Gg: AYBFou0JbgTZvFjY2VnaeghXuquhF9IFHU1eYS+RCFXzxC0GK3mkskfunhMZ9PskK4C
	1rOwx8Vqbplf77s7RKZoXa84EdyJx/q+P3Vl1w7leuhogTjbriarA187CnpW0Xr5rf0+prAi8s+
	9yXI23XwUICw7h+CSVGVBmwByhbumaOAzBT9v42E+0wY6xmuybiZ48iAOwoKu91B8hlWb3Ycm5y
	nW98H/IDqolqLNd4wQxc3GzXSBLtMPWG0Ds7a69HFCZkB4B/TQChEL6bz0710dVw7JWRjpDj4Ox
	HglIj/utqJ7kvw6UFej10V0bKO5Ob6fPyApCgyqPgQzrvyythvrMVElRNGmJrG6lgFM5kqFwtZv
	c1pWdh12gXCvtUhy7xYYrsdHNBBwxsWHyMUXrtDwx+DqSTc9+lSpnnWntK2psbdBZK6jU4XfKdQ
	M8
X-Received: by 2002:a05:693c:41d5:20b0:368:d0b6:b231 with SMTP id 5a478bee46e88-36a4239256emr15924170eec.10.1793649161577;
        Mon, 02 Nov 2026 11:52:41 -0800 (PST)
X-Received: by 2002:a05:693c:41d5:20b0:368:d0b6:b231 with SMTP id 5a478bee46e88-36a4239256emr15924124eec.10.1793649160998;
        Mon, 02 Nov 2026 11:52:40 -0800 (PST)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42952e1csm42317392eec.20.2026.11.02.11.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:52:40 -0800 (PST)
Date: Tue, 3 Nov 2026 01:22:33 +0530
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Raj Aryan <raryan@qti.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: qcom,pmic-glink: Document
 RTC client properties
Message-ID: <dv4mnrd2vrmoucjje5efyu2hl2u2zljc74eaiihzfwcsb2bblq@ri2ouch4uout>
References: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
 <20260807-rtc-glink-cleanup-v1-1-7801e4d69c4f@oss.qualcomm.com>
 <anUemwQJgHJP7iOS@baldur>
 <2yndadk6urzktzbb4mg7rhnywb3lxi6liuw2afdee6tswhnl6h@tqvt3n2r4qkj>
 <6079c72b-cb98-4a38-b887-962a78be2877@kernel.org>
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
In-Reply-To: <6079c72b-cb98-4a38-b887-962a78be2877@kernel.org>
X-Proofpoint-ORIG-GUID: fPfDKOf3FisOyI47GaDiB92lA6FNYSIS
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae8ea0a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0277vH5HcBAn9Oasa0YA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA3OSBTYWx0ZWRfX3+M1GaWqzc8e
 c/kdIBYe2xTP9CbpZjT8ytpOCNBBzKAeVNe0I67gMMp7buUvBklds/BF0OlbFv1s+njtl0LCNIO
 8eV8j0EPbei4Ze2O2kcoMw9Uy5ZyfmXugwhHt6NLZZKbggyTsDepVOvu2KiDwdVZ88WL64QhstL
 VGFPLX3ua6Jo/F/5ecSLr61y50hZN4B+shoPwu2zlg3SnwQsuDV7eJZmPE2YpDdxV0i8AAukt9M
 r+hOGRb9qb63BbEu20Km4PyZDUUGnW5fxx/VTcsu2qCWfGWyGdY3MHLfMlGiaK5NachuEl0Bj34
 AEpTqd8+KhfpE9FAXZZwXYVAYQLaMpW68gVrSWl161jpLO+2eONyYOn4D1Uc//pmwZQE1ZYPrnm
 K9luTDFAp2JF/ubkJWMlNX8RanP1D1TUzCvdFkZurSSSgmRakkqyK5DwtyKkM/YkXFL6DTCa6Px
 ldUrSFLBhX9EmudFSSQ==
X-Proofpoint-GUID: fPfDKOf3FisOyI47GaDiB92lA6FNYSIS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA3OSBTYWx0ZWRfXwvrDtw8HODqM
 zuGMFVcIZ+4owZ5uSBqsuAav6WoqjlOWUYc83/c/4Ip0hupNPPhtsanRmb/CIL1ddhg4zNN6EBi
 WxzsN+FUlG4dy08ILIx4eYsg0GIwtik=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_05,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020079

On Wed, Aug 26, 2026 at 08:11:36AM +0200, Krzysztof Kozlowski wrote:
> On 20/08/2026 21:23, Kamal Wadhwa wrote:
> > On Thu, Aug 06, 2026 at 07:02:44PM -0500, Bjorn Andersson wrote:
> >>
> >>>
> >>> Assisted-by: Claude:claude-sonnet-5
> >>> Signed-off-by: Raj Aryan <raryan@qti.qualcomm.com>
> >>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> >>
> >> As with the driver, the author/s-o-b chain is wrong.
> >>
> > 
> > Ack. will have it this way
> > 
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > Signed-off-by: Raj Aryan <raryan@qti.qualcomm.com>
> > Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> The original SoB chain was right in such case. You sign only once, so
> first one is dropped. And this is what b4 produces.
> 

Thanks, so will keep it as-is.

> 
> > 
> >>> ---
> >>>  Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> >>> index 16ad4f5698fc..38db1ff473c0 100644
> >>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> >>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> >>> @@ -79,6 +79,11 @@ properties:
> >>>        - const: charge_limit_end
> >>>        - const: charge_limit_delta
> >>>  
> >>> +  allow-set-time:
> >>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>> +    description:
> >>> +      Indicates that the setting of RTC time is allowed by the host CPU.
> >>
> >> What property of the hardware/firmware that this describes would cause
> >> you to set or not set this?
> >>
> >> Also, what would the expected outcome be if I declare that my Hamoa
> >> hardware has pmic-glink with allow-set-time?
> > 
> > Actually Hamoa firmware does not support it yet, so it may get ignored.
> > but if the support was present, the writes will cause the system time
> > to go bad, which relies on the RTC time elapsed during off state to 
> > calculate current system time, incase network is not available.
> > 
> > this was used on rtc-pm8xxx.c driver as well
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/rtc/rtc-pm8xxx.c?h=v7.2#n622
> 
> 
> It's a generic property, so where is it defined?

Thanks. That is correct, the property should have carried "qcom,.." prefix.

seems the orignal property used on rtc-pm8xxx.c too has this problem (as i
copied this from the older driver) it also doesnt seem to have the prefix
added.  I'll raise a different patch to fix that.

> Why isn't it implied by the compatible?

After thinking more about Bjorn's above comment about this property describing
the Hardware/firmware, I have decided to drop this property for now, It seems
unlike the rtc-pm8xxx.c driver's case where firmware actually blocks the
writes, in the current case we were only adding to prevent the RTC core's write
(with the current system time value) to the RTC HW.   

Having said that, we do have usecase where Time service daemon (in Linux
Android) does need this time to be preserved from any writes, as the RTC time
offset is used incase there is no network time available, the time offset will
simply be added on top of the time captured before shutdown. So it seems, we
cannot handle this without actually blocking the writes to RTC time.

But since this time service does not exist in upstream kernel, so can you
please guide what would be a good way to handle this requirement? As we would
prefer to use this driver in Linux Android as well, can we add this as a
default disabled property still? something like "qcom,block-rtc-writes"?

PS:
Very sorry for late update, We actually wanted to enable Hamao as well (along
with Glymer) in the next version of this series, so testing and firmware
updates took some time.

Regards,
Kamal

> 
> 
> Best regards,
> Krzysztof
