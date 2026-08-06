Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F353F20F4
	for <linux-rtc@vger.kernel.org>; Thu,  6 Aug 2026 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049846; cv=none; b=Pq9+J6iWfxOHBrhEkbGKJN9tHEoOGqks7fp66K6q8Vpy3JkUZdooX1K2dx+KLOQKoCfK+XUuxc6x/hO/L8KHJLTDznLsb42RmsIcCcQaujzdcjSeNk2DlsyF8YEPGkvtwWVpv5EtO3OVfzg/l6vK+DvpBpgnt913tpJhM6Hqx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049846; c=relaxed/simple;
	bh=MD5I+VArbC1H63/X/zCUsjSZIDHA/CM8wfB/bAIAthE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJ8Fdp0uObznbH+tmHhmz2fFP6PotorZDDEfhpxmlhrj7vrgUKI1sYM7bj4eIZzVdJK+enStLXZKLHZe7qfmOrbJeulaGoITIeE6jGe67yAjhsiYs4AZ861TBMpkccMt2WT5nTCOnQnMvXMCvHLA/cKpoAQjQYWcjLOgg5BL69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pXMWxeTh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I6VCRhny; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pXMWxeTh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I6VCRhny"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IID8g3289380
	for <linux-rtc@vger.kernel.org>; Thu, 6 Aug 2026 20:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6bBCWNJUB84UpOgg5BY1iXXPsRYauvBdtILg7E28C0U=; b=pXMWxeThI8cjN0uv
	KVt41gCnjEEaZUSn+V9h/n7yxFekG++alz4My9Prgow+7u1dpqvcGG0Mll5KBU8N
	YVkaHmrRM1BL5v7ZhNSMyGGrCQ7yg6UxidXoHwrCHs0tAcrtNMi5qi9nOEvy/f0T
	qjR9i6qeUsXrTQNKa52HOSz6WBDTC/BD3fSiPjFgP63opEYRYgwM+0fQGjj6VQDS
	wrK6z48DLo3KOe/fk7m5UoZeD0o+FBJnwxBAnEASh0lO41e+Rai4g4XXBzEUjUAZ
	9elfmQXehYDvdukvF0dxN+41rzSS04tQd2Qy0t/5G4Pj+9NiJCaLpFUEL7CiRHMl
	6lZ4kw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6h8pru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Thu, 06 Aug 2026 20:57:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb7d6ba548eso2952379a12.1
        for <linux-rtc@vger.kernel.org>; Thu, 06 Aug 2026 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786049832; x=1786654632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6bBCWNJUB84UpOgg5BY1iXXPsRYauvBdtILg7E28C0U=;
        b=I6VCRhnyaIJTd/Kmx98Ku10nhPIBTeSOrIhnsrA7tNHuAcKQbNnfyOi7CQypBSFjOR
         XRmV7HD1eEFufkGATIy2ZKYMVI5b5iAFB1jQwY9UZ2IXCa/KPl0HIhoEXywzvf9sUHJG
         ncQajP6yuhxzHAP6d6SkSM2e2+vqAjEHwg1f5SmwqOaSkL3iQxyBUqJ/+A9IfGloYAsL
         uIGmEc4T0MTcShP8dAxxvpTi+OFcQkybiTUwiDlYRoUPYeAf2pZwGAyq8doE+eOsud5H
         15wLWetNyc18J2mW8PoG5JvFJ0CJ9fMaOCPt7sbQM22dNLHCM7hxMRZl8EN5pWSZsB2a
         i7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786049832; x=1786654632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6bBCWNJUB84UpOgg5BY1iXXPsRYauvBdtILg7E28C0U=;
        b=LsMSviyQBDiAX2zcFH1xWmE1M4TaFgwdcybacI4XLdnsCL5/gWRiljYdBceFnt3gvx
         J5VqSw3Nh8+mmOHxO7qeY7megDiJ2rAG5HqthbdJoPn5R2f4QM4bVgjnUECe/2OL7L6F
         SdgU10QCHkOjVibB7dR7KQu46jwq6BM/OB9pECt6O81xeXGeAa6L0Okk4fy4nB9zsaFr
         7oE+769BUaUEK9EilDBJmaIlpxZDxkf3dmOEOj/QHfQrX+LScUJ+O/cbYBCHUrlhXa5j
         Ok2cQ+VWng1rrYhp2rYKVr8gfwss54NfOBSL0i3odhGrSwaz2Nrt+wQMbRhJyJpZnV7Y
         0ffw==
X-Forwarded-Encrypted: i=1; AHgh+RpG3ecp/JC3/STbZPkA4IHuBROCV8I2PVogd9W9Huefru3kCbqSeGTdKSYOqvKIwrWZKRmvG6hQhVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBcW7RmE/ldZ8X0WJmZc93wGcf15tIHzzQTsQwkp+4xVKLJoCG
	WA+AsW8WPD/pSO4ygMoUlB5Prjrp5bDM0+OoyTuBIEMwWknC/Fa5INa4m1/DOls0PbJm9I8yhLL
	nnYMisXHE6gqGpezJAdJEA1A/Z0IFB+OfXi6NcdjfMRjTLoUSjuT8H4ILW9PjNHg=
X-Gm-Gg: AR+sD12hHoy6ofbW+7Q3b+AT9t6tXGwiaF6kHt53urM3qvwVW/sk7AwT8ocxQ1mkdoi
	E9C6QurM+hu5qJsxPRvP7Onu3aV7TH64FThTI2JQ/vFqG+cMniQUM4fIcDLXc/7x26PuDUSH5fr
	DI15eu99+z3jIWpPArW9cUubV5MWkDW8KvGw+oewTuA7u3EeMisZcKdLn4cm2ftfYdXBB0tKix6
	/9g+G92oaa1xGIe/4H7eqF5PQVSIGK8dRHcG/BDVbTU1utlPYmOxx25GNzeT0ZGzJRt2z1yO3R+
	MOKpPwLDv5h6hEaYL45roBBKid6Bwj4bOOljlPCy2pE7eb3+0vje7n5eOMhtJd+YTVXl8eoFd7U
	iYV0Epvmsuf4N/9nc4arGjk0rSdLo+Q==
X-Received: by 2002:a05:6a21:3a82:b0:3c3:704d:57c4 with SMTP id adf61e73a8af0-3cb85ded954mr22189210637.12.1786049832135;
        Thu, 06 Aug 2026 13:57:12 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a82:b0:3c3:704d:57c4 with SMTP id adf61e73a8af0-3cb85ded954mr22189169637.12.1786049831727;
        Thu, 06 Aug 2026 13:57:11 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bc667f1csm116641eec.12.2026.08.06.13.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 13:57:11 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 02:26:30 +0530
Subject: [PATCH 1/2] dt-bindings: soc: qcom: qcom,pmic-glink: Document RTC
 client properties
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-rtc-glink-cleanup-v1-1-7801e4d69c4f@oss.qualcomm.com>
References: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
In-Reply-To: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Raj Aryan <raryan@qti.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786049822; l=1194;
 i=kamal.wadhwa@oss.qualcomm.com; s=20260406; h=from:subject:message-id;
 bh=MD5I+VArbC1H63/X/zCUsjSZIDHA/CM8wfB/bAIAthE=;
 b=toKd43o3cpn3nv/npS75mCQTi7r5OfqMdiI5G8BIj1R7PIQ5xV7RIwoVj1UMPgF3Qou2XZs9x
 i5Oan3QM94RCyASDrn89qABVFr5fQG+1RxI6Xurwxwi+OueBp5D37LE
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=ylH1NxUZkBpYsmww89g6zVxpS0q8qthtzcORkYxn/Ag=
X-Authority-Analysis: v=2.4 cv=G60s1dk5 c=1 sm=1 tr=0 ts=6a74f52d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=qoOW9mG7lyo1mN_lm6gA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: ZDAGXJZSj3Bikcm4201_hEbsnuo_wvuI
X-Proofpoint-ORIG-GUID: ZDAGXJZSj3Bikcm4201_hEbsnuo_wvuI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX5ijTq+rLToVU
 tEmry8b4/TiesHQqnGIPGUSh7Ac8+Ra1Qwuau8oap3YvzzupieCC9qwMOk3GYK2QcsFvVb08J+Y
 q1FI8EKI3fGzQeE64F696sRRSSOTEac=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX28SsM+Nlo+m+
 dZdN235z0b+/xLKHJV9z/orRkqBMbqF6uDIzkjWwXZ12gXAXJFTHrypLCL0fnW2z8+d/1HhlTG2
 P9DQ0txGEvHqUq4VgY6Q+IsGDMY8ykVAM2AUxLsVpTbfShRNNvdnngqmCAKdhaakeO/ASBZkEwX
 BULbyI2YW42G5BI7pBmjCKcbnY+BnGEyTOJINIttUVC2HmMgio0mwzwFzFUi30pEw2x+NSjMt8M
 wLF1RZZh1eod7aL/HE+uQb04It8Kez2rLzprxZTa0Z4ESS6x78bn0LjMqUEd1ez3fr6xVmSpyjj
 RX5w7ptZ8cR/pPBbuiI58Gv/cyQgMkAmdA4eg5Nli9KQN7itkSKzTA+BCW3Dp/hjwnXayPOu9lh
 SEJGqbAoEk1Ye1I2PqjqexMKOp44m6DPRgFG+gbx4sLoRESpu5n8/yNRaZ6IafC+lhWvlhNe/tQ
 7J6IDXEkuKwJQHbfWoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1011 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060163

The pmic_glink driver can now register an RTC auxiliary device on
glymur, whose PMIC exposes an RTC over GLINK (see rtc-glink driver).
Document the allow-set-time flag it consumes from the parent
pmic-glink node.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Raj Aryan <raryan@qti.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 16ad4f5698fc..38db1ff473c0 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -79,6 +79,11 @@ properties:
       - const: charge_limit_end
       - const: charge_limit_delta
 
+  allow-set-time:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates that the setting of RTC time is allowed by the host CPU.
+
 patternProperties:
   '^connector@\d$':
     $ref: /schemas/connector/usb-connector.yaml#

-- 
2.43.0

