Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467465;
	b=INUlZ9jhPuL+y9EnloWo40pzVnoXqDlBcIQOdqGZZyXQwgFTOAVlubIAmSf0YRbq0r49
	 1sQMOE12XFK591uFDVJLpCvNCKyBf4lO8ybALi4aTcYpbDTCFgI+u+L3LtDb3SmQDIAAX
	 uubuDLWuxoucSX+ELKzg74SV4UBIyVH3fkeeB/rJGhvV2zLBwy+MXmZ5QrTqvFmxsvEyu
	 ua7oIO8XbZsuYRaha3qUGqOU0h+VgHqVPiG9MIUsiRyJDTcXSBPqEsVzIvMV3jvWubUPM
	 Qx0tO53YOqMRjqhgCKtZD+Edlf4UE714TPVk1Glmy94thd4mHOaK5WZHXi+loHhoI/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467465;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5TGycPLZoXXrJEQMzNiz1GIKN0kmsKgEl+tTw+PDhm4=;
	b=KPGXwZOXp1rX8KKsHz54JzqzXNgwAIV2B1yAxs3/2rmbhe3gr/GEb7qClB8h0hjna/WY
	 v5KOSwzsG8NE/CmYIu1EIB/aZHcR0hPkjGJcl0y3ISmS7Iufvku+2y1q3aqvEaWlXwEHm
	 LlWngd2uCdRmP6FKK0G3PCnDGIi1gS+Un0bv47p6fXrRe9GUlRVapRFh91Gvh3UjsAjHn
	 9xotINkhq31TQQGHXJ+vnB/ccplyvCxhekKRWeIXG56mlzO+1kIETSHHKWY1+qm7wG49c
	 LtSCLxu6MQrMl0pqYhSN2YHcCR1UrE4dEXjfA3JhKjM3ASFrbYAUTq2pVNHn1bagKGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IYZ2As59;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J0LzT43e;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272A606A33A
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 07:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C272A606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IYZ2As59;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J0LzT43e
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZUOP4149276
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 07:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5TGycPLZoXXrJEQMzNiz1GIKN0kmsKgEl+tTw+PDhm4=; b=IYZ2As597Nrm9s+E
	njEYQIvr1cEN0/3mwFtZffA7VIhx+mxJM67qACl2xV1cTcQkGdSbH1ygkKnLCgl5
	GFFx3B9GBx2L7d/+EPEvIEhruXcvIwjOSYJXoWRWspPOqjHBlvnNpAdfCSM4Xerm
	i0k7yO9WhuuVh4rHzOKI0Qe0frMte1Vnd9771ozbSyOtrS8z4JLi6EuuDUlGwKse
	61kYFjf2gr6z3FI8lZlO6nUOo0swkoutyE88jwyZv3N4wLuRjrI75k2cJbz+Mioo
	YGLL/dubq88PvDt48I7rZ1vwLOdU2L+URGYHDwL/kwU6y1wZOJ0GlizqIMZ88vEL
	Tl5wOA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvxc628fv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 07:11:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad704d4760so4584965a91.3
        for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 23:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794467463; x=1795072263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5TGycPLZoXXrJEQMzNiz1GIKN0kmsKgEl+tTw+PDhm4=;
        b=J0LzT43evjkjCTDmDjme4gT8il4OlkZ+jkqqB/4JEF7PTwHLiGHxFIEWQPKuOpzsGa
         Wpq8hA96Z4l1BHivwdsNjs+QAOssqU0FnCm8ShSW1JphN0yjNnwgQAwGIifOxtjs6oa6
         LXcbE92wdQrgtz8sOS10fPFGEv/Ed8VLwgLc0gqMi82n3AoUuSFpjmZZ4hPlL8agxY4D
         GEQgpFwDWGce/DfwCUVIhafmc2pDtEq2RgBOhYG8h5S3JunMjiukXWhF4jxhEGMOQRno
         IKo3k6FsIY6rz4gv1mFObJeys24AfoUtMJvnvrkkPc/JrGyXgOfmaOC41o+SJ+0ALxMu
         3KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467463; x=1795072263;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5TGycPLZoXXrJEQMzNiz1GIKN0kmsKgEl+tTw+PDhm4=;
        b=TpCfVGWcT+tTvX8xZ2dfYGqqqZpOEDbDg1rMSNiPXEzUcKYidws/pHdQjxSN/pdmzM
         fs/8qHoKXM+RxG75XkxpGkL7n0SeFdDB9X1O6pntVUAyiw7MQq0sk77U6hIIChLtLWNy
         3yXCLMgiSwnG5Rwy7XnJmz+cpIQpsqnNg6fPrv5Un/pqR6CecN3MjyziNFmAuncrufwG
         iNgA3cDmjYO1a7nXr7MAVWtdGta5XcQWYqp4CkWl+0Xo9BP9DWyoYRs2xLS7TwfkRDAt
         w1tH/p3tc8w7/bLXn5WW75vnUbk180CNMQrYSVvbvT2ksvDOFinq00HBo6lT7t6Kkq/J
         XFqg==
X-Forwarded-Encrypted: i=1; AL+hErHSN399ciaCcTYTdq828DZEFW6KJ9NoEKv21n76VuoxUF6bp9iCy195qJST9CUYTG7fXrPZvQPIeNE=@vger.kernel.org
X-Gm-Message-State: APuU4Z94ikNqoMZlnlpijuGi8Hl24zXAfq/FeqEZvCYBdQe2f4ni6dGq
	BlQWq++0SfwUDNWWq0BOHGFXcMH2239T+S+ZDat8mCgOmQM3v1ewNUNglnDbXrBg7cbQOw4qxtc
	Z0l9oJiBH/62RIu+2HYkDbNEmrYzxPW/73EFuh0ZQ5F4M1gPt9264gbR3wYKMhyw=
X-Gm-Gg: AYBFou2iFc3n+wpctU7EC9As3guf7qo3RGSSQfJQucvjDvQxYQl5fz70J3sDXgDhDWA
	mrFrd9OGnRhMPR/FTjBtDNPZyKw61Gns64FYH40gop8j3hFN2mk/xnD75KtzTJp1UR3zCjWsDVY
	u2sjffro/7+bUlqAoK5XQTtec/mfEXIfF4Wl+Tzr1BH3iZcAdYpBfgcMo11HwgCWclmkOC3+LDp
	MYPFZtPqvuUWfdm+5hAHe1uL5SM1uBjvlawFwmNSuEMX8PhmLC3z/nfDUHWdaNKOfV86pHxj9Ca
	pvc4mYQ/FB8H1C4t1SQKXrN8ugH9V2/Rv0YntTtBymQQWU3FTkfJfhEcoNU/Xlsyxfo1B1IDZfI
	xitNXzJ/Gv3OkjyWC8B9YlNIqfJLoB+61+JrCuQaLrxur3R1GY1L9Qrhl/GbNbTUIiMa3KPlRSV
	g=
X-Received: by 2002:a17:90b:180b:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3b182dea9d4mr4105861a91.6.1794467462542;
        Wed, 11 Nov 2026 23:11:02 -0800 (PST)
X-Received: by 2002:a17:90b:180b:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3b182dea9d4mr4105839a91.6.1794467462005;
        Wed, 11 Nov 2026 23:11:02 -0800 (PST)
Received: from [10.239.31.126] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6dd2dsm3063939a91.2.2026.11.11.23.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 23:11:01 -0800 (PST)
Message-ID: <9d80c088-1a0e-48fc-9a24-09fa8c281cd7@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:10:55 +0800
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
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
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
 <0fa09b92-3855-40b0-af6d-2c763235b15e@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0fa09b92-3855-40b0-af6d-2c763235b15e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bCMHhBpB_xwsVuAOKkdLrECqVg4TyEVO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyOCBTYWx0ZWRfX1tTxS9g1cfOu
 jCFpn0xOX8w+jYfX289kUpnqpSfwS0rpCCNWf8sxb+1+yk8DTXukrCPaTHom/qy3Q9EWb3ls+aI
 jtvnOjYowzdXDcKoHkzcahnd6aDNsux+m6CBwaqyJNLu0TOkdVymuMf4mgWLBvIWH+oZcLneSFc
 RM3RNnlzgIYUlqyNVfUWIGCQ1Xb1n8USFIWu60FScVO0qj4G+guTJKwoaxM4AG10d6e9RmYG7oC
 vjn43ddgvLLPkOUVGlc330KXhfNf2HNa/WzXNW0q4QDZJrXNmYQtFoxEOwMAj5ez28zsDN6R2AC
 7sJCpRqyGXSyXm7o8w+/Zod8fTbfDg9Yb2IDSDb3C1z+TJf9DEBmm9K0brEXNgyaUPCKaEDjwUT
 mYpieA1WbV6ZXOezPnjDVEWnYvUTL316BQ3B5LZ0/x9iQERqlS7iMl0iGFHvKGaZ2VW75Xl0qbV
 WlkDNoXluS1QxvZU7OA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyOCBTYWx0ZWRfXy1y2T1JmIq0X
 QUoxuVJ5Kj0VekSqxAR9S7foRLNhPuuHRqUKJ+wnkU6TCWl993npbQwIIujOu1EsYnEkd7sDntJ
 Ru1oWg7pEeAnT0x/JNxipMSoBh/+c1Q=
X-Proofpoint-GUID: bCMHhBpB_xwsVuAOKkdLrECqVg4TyEVO
X-Authority-Analysis: v=2.4 cv=O/ysLx9W c=1 sm=1 tr=0 ts=6af56687 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=n58xdIrCezaV6CGXdrwA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120028



On 11/12/2026 9:11 AM, Fenglin Wu wrote:
> 
> 
> On 11/11/2026 9:14 PM, Jeff Roach wrote:
>> Hi Fenglin,
>>
>> I tried this series on an HP OmniBook X 16 (X2 Elite "Mahua", DT boot,
>> qcom,glymur-pmic-glink, 7.3-based kernel, firmware F.04). The RTC part
>> works: rtc-qcom-gio reads the correct UTC time.
>>
>> But UCSI breaks when pmic_glink_gio is bound, although the commit
>> message says ucsi stays on the legacy interface:
>>
>> - pmic_glink_gio loaded at boot: ucsi_glink fails with
>>   "error -ETIMEDOUT: PPM init failed", no typec ports.
>> - pmic_glink_gio blacklisted (patched pmic_glink still loaded): typec
>>   ports and partners come up, plug/unplug is seen.
>> - Same boot, then modprobe pmic_glink_gio: the RTC works and the ports
>>   stay, but UCSI no longer sees any plug or unplug (old partners stay).
>>   USB data and charging still work.
>>
>> Happy to test a fix.
>>
>> Jeff
> 
> Hi Jeff,
> 
> Thanks for testing the changes and reporting the issues.
> 
> I tested with all clients switched to use GIO interface. I confirmed
> that battmgr, UCSI, altmode worked as expected. I should also test the
> hybrid mode of only having RTC used on GIO and others left in PMIC
> Glink. I thought I didn't push those client changes so those drivers
> were not impacted and they should work as before.
> 
> I will test it this way and get back.
> 
> Thanks
> Fenglin

Hi Jeff,

My initial impression was that the SoCCP battery management firmware
might not handle this hybrid mode (GIO + legacy OPCODE) well. Enabling
the GIO alert might cause the charger firmware to select the GIO
interface over the legacy OPCODE by default. I made a simple change to
prevent the global alert from being enabled, and the issue you mentioned
was resolved at my side. This will not impact RTC driver anyway, as RTC
doesn't need to handle alert messages.

Could you try this on your side? If it works there as well, I can
discuss it with the firmware team and come up with a formal fix when
pushing next patch.


diff --git a/drivers/soc/qcom/pmic_glink_gio.c
b/drivers/soc/qcom/pmic_glink_gio.c
index 83656a5758b8..fc5dcc62b200 100644
--- a/drivers/soc/qcom/pmic_glink_gio.c
+++ b/drivers/soc/qcom/pmic_glink_gio.c
@@ -310,14 +310,14 @@ static void pmic_glink_gio_pdr_notify(void *priv,
int state)

 static void pmic_glink_gio_enable_alerts(struct pmic_glink_gio *pgio)
 {
-       __le32 data;
-       int ret;
-
-       data = cpu_to_le32(GIO_CORE_GLOBAL_ALERT_MODE_IBI |
GIO_CORE_GLOBAL_ALERT_EN_BIT);
-
-       ret = regmap_raw_write(pgio->gio->regmap,
GIO_CORE_GLOBAL_ALERT_CTRL_ADDR, &data, 4);
-       if (ret)
-               dev_err(pgio->dev, "GIO turn on global alert failed:
%d\n", ret);
+//     __le32 data;
+//     int ret;
+//
+//     data = cpu_to_le32(GIO_CORE_GLOBAL_ALERT_MODE_IBI |
GIO_CORE_GLOBAL_ALERT_EN_BIT);
+//
+//     ret = regmap_raw_write(pgio->gio->regmap,
GIO_CORE_GLOBAL_ALERT_CTRL_ADDR, &data, 4);
+//     if (ret)
+//             dev_err(pgio->dev, "GIO turn on global alert failed:
%d\n", ret);
 }

Thanks
Fenglin Wu
> 

