Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672216;
	b=CBP9ZGdD2dGGa/Iva0+yFTvibzOgOg7Fy8eX7D1KEw0IeqlrU97cm6DxJ/Yt/UT6nRVY
	 3RHNQrPuryXimMH68SxR/8eaaw5GaJw5GvqDEAvfp9jQ54xG8UNrpQz6Gay0CphMaKa/J
	 DmumFhhhZtyAM5Af9K2L4KvS57rURyL29okbPRgaZm7Q8vbzWToKTUeyvG3wU1DEKNd+K
	 T99xj/zPMhS38jld3BEb6J/zYgZF26sg6RkHXSvVQbO9XI15km40Sfe6b25NaPQSqu66+
	 nf+wwoMEJcAQsI5gkYoCKUl7xPuuRgB3XAAm6johQkMD4ytqx3oaBcvoemehXa+WK3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672216;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7F2O2csUCBBF7nZbrAGT/+JaFY7SalieFm/4qJ12Ccc=;
	b=xVGa1oPYXTpeRfzTjG9Pltq1WGvzJzKqe1YFkKsV5BqQORPaUHJC+FCdO2los16Ojljs
	 eX678XD5hCVqFmK6uouzoykQA6Bz4DlPnhN7Q4fpfXbPeEPQAZafXpwxLm5lEDEC9s7rs
	 8cokEyqTFKO1Qf56hDcPuvLxoKJDuSuO8cudi1Y4Rp7bPLQJFHUhsdnfwz4M31U2tx3/I
	 XAKwlVTBU+SzBqDUZpVHWKOVBCZlMgY5YfI/f18apML9iSx64/S0x3OLu3EyV8u9o9/12
	 MSFKBUn2QVzywakkte4GRy3E4IWMv/fu2avY2RvK9lnYK4UTk0cKYcJidWdBTdFytQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=julWiXhI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kIkoVceu;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C5606A31E
	for <linux-rtc@vger.kernel.org>; Thu, 26 Nov 2026 05:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED4C5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=julWiXhI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kIkoVceu
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ36W0D2791231
	for <linux-rtc@vger.kernel.org>; Thu, 26 Nov 2026 05:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7F2O2csUCBBF7nZbrAGT/+JaFY7SalieFm/
	4qJ12Ccc=; b=julWiXhIDChDerVvQXdfNZWsKRAwqc+ZSaBHybE9UnPg+bH97rP
	uNRS7w+mcY7PrF/5GgZPf/vroOn7fGyBbXxrHZoX7SX/YBMnUSYh1xQ1YtRv4ydm
	ua5g27RyCco4/ZiA2KnY9OOFk+9INo/3k9C25UTo/1AZ6OrqjpnGYvtWQyTwTn/l
	dPvfbAUZdVlK5ZfmPbrgASsKzsEvQZ9JZN6+8/H75VnZ+3kcFdeIhEH/hoWGjrWY
	jzCyFGQfBXo0ZUVuZRS4CMYC0AJhThNPjhWkUOVU6Fev6LdosNtrj4IruTBBJdT1
	BOajCPfliaLolMiAwErJUV7vQSaFKXnghjg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnv2hx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Thu, 26 Nov 2026 05:50:14 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3854627c1c8so9089115eec.1
        for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 21:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795672214; x=1796277014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7F2O2csUCBBF7nZbrAGT/+JaFY7SalieFm/4qJ12Ccc=;
        b=kIkoVceuwDopnIlqyl2EAH5l06vAgvJ7797Yx7lntcX6u5/MVOaUnsW7BjMXSLYJkb
         MMwJA8AihFnFAzEfDqMt1I7Bb84LUXT6g/lMDLdpQzJDtVv/GIEwjDUQ4h/GyM9hzKYu
         eN31vic61v8vAWTZVV31SuLAbaCq81LW57Cf5BrryCr56wr80xBAKGeCUy4mWaq2qjZd
         rQagSh1nMRCruemRcyLxwJXtYpKOT4l2sAjiiqs+q2geUhu9SA3pMzQKiShpnum+Xm20
         tTsJK2eCzml8GqWIhUzfstmGbMY8/8vZ1g0jvWfrMUVBc+Evfo+tNlmWGQuY+fRloOue
         tuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795672214; x=1796277014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7F2O2csUCBBF7nZbrAGT/+JaFY7SalieFm/4qJ12Ccc=;
        b=XVEhntGIiVkrA221XHU0R5T/hCU58pDEEGCWlfG/tTPTIjHAJu/Pr1Q4MWmkQs2W6a
         6TIXAGLf3l5/BlbZHU9BiWa3/6cIlRvtuZr8DIhIoOtpkrGZouerWK4ufln3Ejwx95HG
         tM5vHgY8/lYdAuHS+XfBAoUJcQ8cLqJC5g5LVcuN5Q25a4vH1+RvyD3yiL/84G/FuVkZ
         7rsl1xmbjR4/PYxCknb5Pbdk1wBlqftD+B0X7c53AnWof5N6TuSCRcVFocJ351+qPaQ4
         KttRBmM7AOqhQwx3cl0ihKItUEPHdPVVAzHBXp+BxdevqZ2WKOeqvJpOe/vduGS4j42h
         rFTA==
X-Forwarded-Encrypted: i=1; AL+hErEOht57UzRNKnIVR4ZaAmy5b2t+azRHW0rHblFjY9/FJ+TxArqD3wDh7DL6SUCBfpyUKPcz9YyAwB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zl1VnQexgFyV1StexGlpoIL9TGQmO9FvAw17DDee2tzxvuXIk
	roK5fQLnC+1mXfMKktesIk03VwQ1dyh17kQOV+Mi+CQaMcKzgPeB8Ygzm2gsT03yPsMZiwdeZNo
	L39ZXxisYaCg68Tshlhd/L1H9H6AuEYpOTP6wIUKN8ROBc1qIaGqoTwUAyEVL7+0=
X-Gm-Gg: AZFdTZey6cMohLsyCk86QVA5Dyko8soJt6jIZkNVtUZJTSlNcR+tNepZdFrdNR9UGdK
	iM/dMHd8lmiiRR9g8R4Gp7SCsTUeHunhqa7zcZjHr2aa2nNS1PYh2JIDM0Y044CNP42p8R5DU1z
	SkFD2XWT0WBhJJA/j89iE3RqMV4vGMFtXzj8ZjY39kjvxyl2Nuix8DLevw1u97LaiiMgPY/CWMP
	EWPSfXtQ87BchYNlSs43KZpw5sw7JtKNV7+V+KofvUfLFTVgW3KJa/vyMXJ3OKRMXYj1c50+v9H
	cbYOlEwB38fuxZm4iTLMSnYfZFvlNCZ34unVJrnjzlhhpnjiQ0S4jb6VIuvJPtw5JOmv49aLyco
	IbbRLUMumy9LewJNEYDPmAvL6dddMCyeyd2xLUgtOOec+h4yLSGgt8AkZ47VOv0Qz6hlf9TCR1k
	42WRIu+eQxvQzGDEA46Ew69oM7px335fyrTReMtQ==
X-Received: by 2002:a05:693c:8843:b0:386:b526:251e with SMTP id 5a478bee46e88-386b52637c1mr9650968eec.10.1795672213782;
        Wed, 25 Nov 2026 21:50:13 -0800 (PST)
X-Received: by 2002:a05:693c:8843:b0:386:b526:251e with SMTP id 5a478bee46e88-386b52637c1mr9650934eec.10.1795672213179;
        Wed, 25 Nov 2026 21:50:13 -0800 (PST)
Received: from hu-ggarmidi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386992b404bsm46141619eec.1.2026.11.25.21.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:50:12 -0800 (PST)
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Subject: [PATCH] rtc: pm8xxx: Don't fail probe if the UEFI offset variable is missing
Date: Wed, 25 Nov 2026 21:50:09 -0800
Message-Id: <20261126055009.758156-1-gopikrishna.garmidi@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyMSBTYWx0ZWRfXwQQc9FOCOjEr
 BJYyVTlIppGqgqu9tGKCfYSHNQtuCaaiNG0yag6eKy3vubVqlJq/b1L3X6TjrvtxsqcakAOP54b
 qD3pdqkFr9MxS6/QP9XBz60Sh6ZrdUM5KeC6+erXGK0lU+0lylgSsjUOXQJbkNDOXMNhcEi6+G4
 23jnAs5GQ+hIRUJnyjdkW30PTW+klgvVYDQdoKkD+kqYzgz+2h1JE/8yBwa4+nbgcZIz23C4k9f
 meApv+eBaJ09UJN9njtu5nmTVESKrpyC7h7ccg4OR1nlKtH5PEGuJ8GN+1ttUj2fp9aaMjD6Ija
 YGQlM2NdTY/jO9jO/CHioHEccCsv/seQPsKX0CdR/lq5+phPNQ5Fpau2Az/GesVKTACIZ9ajyzY
 slNf9S8jPzFLTE8IALz7xujzl+Z3M2RuNA1eiUfIzMtAPgjRD9WqEf6DDElIvJ55p/6irApzEr2
 mrbg43iC9vZILuAPPzg==
X-Proofpoint-ORIG-GUID: n6GymYENXBY96Hp_Q-M4rgM3ksoNxJKd
X-Proofpoint-GUID: n6GymYENXBY96Hp_Q-M4rgM3ksoNxJKd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyMSBTYWx0ZWRfX9+u8lwZ650os
 iQn6Y6NCY56bsJwvJasdPN9iXbdb0MvN+fkbBkRRo/C2lTwYN6fLwxT21576dugsB65KXr9grwg
 fSs+H1oFIch1AYqn5EVpcek9/8ujeo4=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b07c896 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=OYn6iJlKGZJMMuh0WgQA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1011
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260021

On boards that set qcom,uefi-rtc-info, the RTC offset is read from the
RTCInfo UEFI variable at probe time. Not every firmware creates this
variable. On the Microsoft Surface Laptop 8th Edition the variable store
is accessible but RTCInfo does not exist, so the read returns
EFI_NOT_FOUND and the probe fails:

  rtc-pm8xxx c426000.spmi:pmic@0:rtc@6100: probe with driver
  rtc-pm8xxx failed with error -2

As no RTC device is registered, the time can never be set and the
variable is never created.

Treat a missing variable as a zero offset. It gets written the first
time the time is set, as for any other offset update.

Fixes: bba38b874886 ("rtc: pm8xxx: add support for uefi offset")
Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
---
 drivers/rtc/rtc-pm8xxx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 40b6b62116dc..747fd81c8146 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -109,6 +109,16 @@ static int pm8xxx_rtc_read_uefi_offset(struct pm8xxx_rtc *rtc_dd)
 				     &size, rtc_info);
 	efivar_unlock();
 
+	/*
+	 * Not every firmware creates the variable. Start with a zero offset,
+	 * it gets written when the time is set for the first time.
+	 */
+	if (status == EFI_NOT_FOUND) {
+		dev_dbg(dev, "UEFI offset not found, assuming zero\n");
+		rtc_dd->offset = 0;
+		return 0;
+	}
+
 	if (status != EFI_SUCCESS) {
 		dev_dbg(dev, "failed to read UEFI offset: %lu\n", status);
 		return efi_status_to_err(status);
-- 
2.34.1

