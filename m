Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5B04B0CBB
	for <linux-rtc@vger.kernel.org>; Mon, 28 Sep 2026 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595887; cv=none; b=hV78kOwd5dXjmkwGx3HnHn1uU2+wyUF/0hMGZzx4HUItkxcozTZnNdDnQathuM49/FPq5xxLzuQFqGkMc4Y9z/ThFAvBR6yNh4uwyt15zQ/51z7/Y2jpcsE0SQ1mFpHkM7jww9IBqp2FICqbUxhkGFVl/9FAV4KE2O4jM2AYz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595887; c=relaxed/simple;
	bh=/p0VSccA4zU4DeQiVeywobz5EwNE5arEy1oLTPc55ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVUCXoKLolbwMB3h0pMym82YCRTfqqPUd1bTSh587J0LZndUidEMGMxPo+wlF0Z5FyBAqbehFQbTvfZf+hn9+zBSKYLJOlOSIIAMejCFQdKAY5f/Rz9J/Aj/39l7y7JogRgeft/ingrpn/6KcJEYNW76141VQkIzdUJ5nyz5lBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=au6rqKpD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dmTG96KY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="au6rqKpD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dmTG96KY"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBA4ke1433615
	for <linux-rtc@vger.kernel.org>; Mon, 28 Sep 2026 11:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+g1gQEPVu6NTWa1Scj5gCEUL
	9c3gDqxk89YzewKsiV0=; b=au6rqKpDwMLbn4UyWq13uFvqH3CuRYWGBdBmzyFi
	gFptUnmPRcaA3d1TN0z90zkM01FPZK7J3dGUQePMrIyCT+KrFZ41i27k6EYPeTE2
	RC3s8L3gqOFAWBNBnbV66dcOrScRa60UNF7BBEeV/71Kmoyaf1/nbfz5ZyXf6JSP
	oUKCDk15cwEuYyUxTpFSP9PcGHCEAV3dwHz4KCjGBsSX0nfVL58wwYLYz3B/uayU
	R3oPJ3DQeis/NxChU7QBaOMpkfaxZWsE5Axbn7jlJ3tv9j3qlegZpeVHXkfmM7Ag
	SxHC3XvuM8FbnDYAfWPfTapKMcWBHBtC0kaiA0lSpmbYwQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s1bhy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Mon, 28 Sep 2026 11:44:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3425098ae4bso2345079eec.0
        for <linux-rtc@vger.kernel.org>; Mon, 28 Sep 2026 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790595883; x=1791200683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+g1gQEPVu6NTWa1Scj5gCEUL9c3gDqxk89YzewKsiV0=;
        b=dmTG96KYmReOxFSyA5ANZXCQUEMSYWXaYcW8M9d6x2h/CrEYJ/Ir5Wzx4+VhpHfpLQ
         i33GJEibt5h5zflf4hUvuLgOOfDIWOjE9iwHbeRAJITlBqZrQDVFlDKOhQ5Yqtmop3cX
         nDd5DRx72NHw0qnVxbE3xmFojFGPtVU+DIp4UWQ2YCjDgQAxQSAGFn5annpE4ZXlPn0s
         qyTmwsUyUFXsUIbh0meu0hQ4rH+y10YIawOVP7wzUzXKou3ymx9W3wq9LnuNXQJ/idlS
         /WJv7pePAhvGzjh5aCVT9jemWP3bCw31QWJFJO/Q7RZYgQBIfcb4t2QrL9yf4G2Rke88
         Z3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595883; x=1791200683;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+g1gQEPVu6NTWa1Scj5gCEUL9c3gDqxk89YzewKsiV0=;
        b=kOC864GqKowdJusiKqz/xdFnbKohmbu9bu4vuRGrmY4Lp6v5gdRHlqU6DK/kumfIT7
         +Vl6dYT7WULHkcYMIes9bZRq1nUPFawLQP20ttCxCZ0VDOtF1YMWScdy3FKiftS8GNa5
         mlFkMiA+TLCGDWFl8uO6kMmJpgkMbc9+OOSOoQFxK1QUpu5mzCDz1t6DdM7jVCikgsc7
         D0JdRW1hMjVqTokNmtBWFatDRfMRwkVpqHqCmBnKeUzCiUsOtYwhsSKDCjDLIy5Als+X
         Rs/d2xGzCL1ruJBCmCpgxSUWLrVKJ+n5nrdIa8w9UMV0VR7kSTZIS7C27pi6jU6f9XuI
         VYdQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1xNV7iWU3zQ/6Xa3FlRBkvCIjbVG12Yhva2l3Pts2oqVvhNQHG8CbLRLjopw1DkTizS+D1k+X5mI=@vger.kernel.org
X-Gm-Message-State: AFuF++n49qQMJpE4C580uktEUGahVG0/s2tCKBCbzEuPS/Gv+/ML1eLX
	iuZBtsdK+0aQ7Vu+kPgOCMgJquy91VxRqS3wtAS2qC9oIOVdgpOOH4IqftYCnbXAFGg9hb+XUkF
	2Y0BAIaLwld8OE+pBAypiHPucG/jNf+MrmjfmWdytC1Ls8E9rDTDbSZAVsrsymho=
X-Gm-Gg: AYBFou1gCtGHjoXb2cboAQXiA/fFAHT8bkP7wAGhGvi9TEeo6wD9012wV0CITGAbsNz
	stz3dJD37sh9vpbi6iSejszjFRxw2fGfx5rvZP+egP3cFzLQIW0wmtEtSa10rielfSeWfeYZRhi
	3UjIdkrRzKwSkOCPSwME96S/h24jiGpoFONtob0k72IcaO02h9ZEYpSxn9HdUa3Nv2Y/5SxO9qK
	KCb/LeC6y11OU3xB/A7V4qWoZgdf4nH7faNZFkhu8SLh2JqXXUPR4eQoxYhNhWTqiawMADPOIIC
	DExX7Vi1JuaKbZvOvq6jCIRuyOUWzTkIkST9AJcqO+QUsm9zlxXSjDIUYBSl0oPrt4wIctg61c5
	4dRYPxJhy2GErtHqVvupuV6vWuyApGqa6iRqnsH0UGw==
X-Received: by 2002:a05:701b:4591:10b0:143:1bb1:3305 with SMTP id a92af1059eb24-146d0871d4emr8380067c88.22.1790595883166;
        Mon, 28 Sep 2026 04:44:43 -0700 (PDT)
X-Received: by 2002:a05:701b:4591:10b0:143:1bb1:3305 with SMTP id a92af1059eb24-146d0871d4emr8380032c88.22.1790595882565;
        Mon, 28 Sep 2026 04:44:42 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34a1f82e33asm4457920eec.20.2026.09.28.04.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:44:42 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:44:36 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: qcom-pm8xxx: Document PMM8654AU RTC
Message-ID: <arpTJAyDAAuAzPrv@QCOM-aGQu4IUr3Y>
References: <20260904074541.590485-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904074541.590485-1-shengchao.guo@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX0vaeIsP8FUdq
 tVWaCPj8VvTP1nL25YEQZUGVsG06Ske7ShwkOCi0L/rZIQUvGFFE68JuWR+wvsryyqWaM7450wf
 tgH+MVfFCIHzu11xz7UFycWw1y5pSJ0uRc3o/QrZfqJUaj9gR4KSqAv1uHsZz7PrscvGrxiZG/t
 tVAYkngkuGJa/Eh/w49jmC0G2D5sweN3iF5e75CumKw7Io0KVlBTF+W5gJkRpJY1DSNRXB0Oh5E
 9uMpZ1nrcoGz0MpkhbXaLfEGfhE8f82+85663rxWu6RAUfyF38WxTI0e3qmWofdeIumb+jZXkop
 jaLzNKHqxmiqBEcjVDvXhoQ2we3sLKBnTjeUf6malgFbMNJ5HOxSCt1EON3c7zXzdkOHWyy2wqP
 sIYKxPbQC2SUIiKQIbNA4d5N2mMfmnpJZmM/vERoecO1oSRDXmBV50NrbeW6X5rij2UqY0uYtSc
 JPceOcTwPh+ZxKLORvQ==
X-Proofpoint-ORIG-GUID: CeVrxAadZ9pFQ2w5XSEhFgexlPBraM4X
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX1OdDv3qxcIau
 O+aNu3h2CoRhOwGx6sIyZCdRHbDplJn89zDpuj4AiRljbutJM0sOek48RQd9OkF935kCTJkHkIv
 itAVLzy8Put99CYE/VLaFOxikLEUIsQ=
X-Proofpoint-GUID: CeVrxAadZ9pFQ2w5XSEhFgexlPBraM4X
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba532b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=YW182EFpsI5OemYN5WYA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280046

On Fri, Sep 04, 2026 at 03:45:41PM +0800, Shawn Guo wrote:
> Document Qualcomm PMM8654AU PMIC RTC which is compatible with PMK8350
> RTC.
> 
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>

Hi Alexandre,

I have a DTS series depending on this change and so that being blocked
for weeks. I will include it into the DTS series to unblock the
progress (routing it through arm-soc tree).

Shawn

> ---
>  Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> index 7497dc3ac5b2..78fa1d5ed028 100644
> --- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> @@ -17,6 +17,9 @@ properties:
>            - qcom,pm8921-rtc
>            - qcom,pm8941-rtc
>            - qcom,pmk8350-rtc
> +      - items:
> +          - const: qcom,pmm8654au-rtc
> +          - const: qcom,pmk8350-rtc
>        - items:
>            - enum:
>                - qcom,pm8018-rtc
> -- 
> 2.43.0
> 
