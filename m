Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF33D6463
	for <linux-rtc@vger.kernel.org>; Fri,  4 Sep 2026 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507953; cv=none; b=AuXLHor9pm+77qWdMdZ/zK4jOLXMYB0xjjorqAZ4/X0wvcY2vn6YLrmqWpGWAk4dMNecoRJmeoi2D3vEKlxUulIg9URuQvlnlt9McQjIgzM81RNjxbWnsUULFnIJqflT4cTKlOK48EAQwfhY28pJhYKAkgOPM1qn0DeQsbBKAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507953; c=relaxed/simple;
	bh=nkM2qt5R1/uUPdCckueCKlJxJ01JG2RhAEHpxcPs2t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YV56k57rXERmymHEyDK12t8wcufKWepIV+rTl8bI/rFHJ22A8/hXBFWf6ft4hL9aEmrz3hg8HiWWwynUcQRx4NSwhA8bQGkTjQnAo5qgJ1KF+daoWl+PnbUCtF3cn8VpaAzb9mWy1TjjhvPkaZTo84REPqzDgVaI2/Tgk33UrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QgY9HWDk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KOcBBkW5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QgY9HWDk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KOcBBkW5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68462lpt1545530
	for <linux-rtc@vger.kernel.org>; Fri, 4 Sep 2026 07:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XKTncCRMH/pUckJkjeysZYspaWdgUPV+H+N
	Y0DIrMe4=; b=QgY9HWDk9emaCdPY8/Bdpc7mHHcRZjYWOuOhaGRv1XPQWHC/pt4
	br2Q1LEEkBaCYgk/8G6lJvjWRHeJeglJDlAyO78yMKB6b3RmnyIj5Y1hU4YJc4H6
	UxXFAjCDddpLEsJ8zjVAwhdeiL0YMWyHqj17BgdtK0xGUVp+v5g57UKh6TfJdqz1
	x3rTXKMpGOCH6A/fp2DQFlL6g9uYY0XGeW/qdIIclet3uqp4163/O6rTBUS7dn8A
	rgnFEQg47qrgkkfAPXB/VUmxzSwLpx/u79syrN0ecSZmJxhQYZjYBGe6oICPqA3V
	m5B8kMWwBFuAb2capvHBWS3XFQ04Qv2eH9w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfpmqrp5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Fri, 04 Sep 2026 07:45:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6f80c76e6so14445355ad.3
        for <linux-rtc@vger.kernel.org>; Fri, 04 Sep 2026 00:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788507950; x=1789112750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XKTncCRMH/pUckJkjeysZYspaWdgUPV+H+NY0DIrMe4=;
        b=KOcBBkW5deB9TO6KYO+KUvV76T8YC4RpBgh7PvxgXrFpGb7a5wp19ciNErfuVLweBn
         vGX0qO+E2vBADDJAkVXUvsdH7BytQnYVMj0cjuf/+mV96fvHwgpCMMfE4lKWl2XohrIP
         ULcUvNCp4yeZIGEq7XGxFdDYFDOHAKshZW93rdHbMPmM0opZGTZwlLByBocv43P2cnk6
         /v1s26tEopk8JTGyWmk8Oi5xurN20dT/8BBzgKdN1RNkBrZCD4vzte4MbbDzAQysrHMb
         LsO30ybIsAwO1VDMplvOLjd6ACjJ860Exw3lE+kb7Vm4XOSYURY8qTqrojZW/ieQ7wzB
         4kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788507950; x=1789112750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKTncCRMH/pUckJkjeysZYspaWdgUPV+H+NY0DIrMe4=;
        b=oeAZr09SOaxtfcnhoIkcXUD3kzqgba3DjVd/flLa6KwPDZhxPS6xQSUFoWyQKxwi5d
         RvdnuoGRYO+RW7A1aJ0C9Lsgi0QSwPQ5+vs++VwKG9IYi/RrEQUHc+VmAJ+U7FndNuYP
         H1ZNDdmho+8AnQS1qiUTIHwq44ICyJBZ0tyXQgUSWHNqr9D6uWCVBe+pZmEzVQsf8x/E
         6KeVaZ2S5qPYcCXE4aqoPMFpWH4iFmh3UQj83L8+z4g30fg+afYEnureOKcAU+FYSOOV
         6iPFD9cm9vwIKInuzAXLxXK63OkSmoF0QBd6kK3KGJzZofBgpgpBFbA+HeH50DeNmXvq
         f/Ig==
X-Forwarded-Encrypted: i=1; AKwUvByrRsOpStRVbgV+wueVtmoNddDfRDBCdY9xnQumAkNsKr8hr4YpgsZwga83j87L7t4kAE8wuJ3Pze8=@vger.kernel.org
X-Gm-Message-State: AFuF++kZZj+ovZDWLRAatTKxJXGluAyNIo37D6Yd8DWmG3porquCij5D
	E9mOJFnXVn4JYT2se92X7cOUDtgI2kxgJN9Zv0OwH4d35aqK9WooVxOLduBaloQn4JIFwCflTd7
	MUUbZ6RBsj/Qve4GZB5FXhIRh+sOxZoA8lNRP9hR2ocH+davx6S6V4m52D+s3D0Y=
X-Gm-Gg: AYBFou2a+RSdT83XuLtPDS3fEZxOb6lN9qaztctBMv8RPh6VIaM0fB+rbmradLwo7pL
	bj0kykhtDEXZZtjvNxYZqVcv+CyG03yIwysbCmHvKEBNKnp9Rf4/lyMzzePI4SChqRNLauzI5S/
	TUmBPxMMBE/D+VfxVyOjyUeX6DCSIpjeaWLrdJt4SXevzg0polRavWmPWZJh+CKvJCoA80sics/
	B/X4aMZiovBeu3R0mm64qdzdrO++H5MgA5xt+1cK+nMpDb5jbMECsSshQf9OwM/OkMM5sK0o/5C
	KUinTQ8409Zfdki2x+4mkF9AfKiPDKo8vNMyny/G9ICnWlC169jPB1I2jOxOg6iVcl0R+4P3g7r
	m+NnT7cqsy00QqDfCN4CKN1KiXEHdxsmkeay5JAn3OfK+/2m+9Cj3XmutczVs
X-Received: by 2002:a17:903:46c5:b0:2d9:123c:8c49 with SMTP id d9443c01a7336-2db1975804bmr37599875ad.14.1788507950003;
        Fri, 04 Sep 2026 00:45:50 -0700 (PDT)
X-Received: by 2002:a17:903:46c5:b0:2d9:123c:8c49 with SMTP id d9443c01a7336-2db1975804bmr37598965ad.14.1788507949336;
        Fri, 04 Sep 2026 00:45:49 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm5130365eec.1.2026.09.04.00.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:45:49 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: rtc: qcom-pm8xxx: Document PMM8654AU RTC
Date: Fri,  4 Sep 2026 15:45:41 +0800
Message-ID: <20260904074541.590485-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA3MCBTYWx0ZWRfX0cmnw6fJ5kE7
 1bLXXiCr/70ztdH9u04yRscpD/oFsu3igSlK6g/mDNqYXvGaBQlYthEuDfIOI/LgUtJyo2Bg7Ri
 MJAS0UeTkg42OE7PjJIXGAKOASrsvHs=
X-Authority-Analysis: v=2.4 cv=eovvCIpX c=1 sm=1 tr=0 ts=6a9a772e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=yylTr5QwT-72qLXmsWIA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA3MCBTYWx0ZWRfX0218pdGh9TLu
 PzVYe/31bMBYsFZCFR/cx6PU6CQXWSDA9Ax2xHP4OYiZrYXoY8adqphHQ2zwOzI0z/huicFvBjL
 46Rw1HjqZQQ2B4DpVryW0cFhtgfQR6RsHvByv/SJOfhMvlT8GeVtOjrLoq+c4xnTI4ewneES1ay
 AhuA57O1NEgRVO7q7oJWJhV7gcnTAkJ8y+wjCWLSspyynVtPINUx/esb5v3hBF4Gz0xncXuyphq
 GDfzx9DzMTNzWBHorKgf8j0I7QDUfZKpcEDvOyLPA0JreAQkg3GsaA1pzr/wQtEdSy1xlCkTMfM
 cfIQ5A8O1PJYcFFWJbxrMX8hRHIg47mmTwNEWMcS+iYp+mffMvTeRs8tHmVBcsRBsz2m7TdZT/5
 hTxV+quWitzHVCs6aAEIT02OJ2wYvGPUqkPLAqkOm439KYF+XpvqO9h2locRHrvC7MR00VOVaVk
 c+Z/WFOJwQe5vuKm6mA==
X-Proofpoint-ORIG-GUID: oqA0pn8SvoVp9I7WgEm-bD6B6Sur6IhY
X-Proofpoint-GUID: oqA0pn8SvoVp9I7WgEm-bD6B6Sur6IhY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040070

Document Qualcomm PMM8654AU PMIC RTC which is compatible with PMK8350
RTC.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
index 7497dc3ac5b2..78fa1d5ed028 100644
--- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
@@ -17,6 +17,9 @@ properties:
           - qcom,pm8921-rtc
           - qcom,pm8941-rtc
           - qcom,pmk8350-rtc
+      - items:
+          - const: qcom,pmm8654au-rtc
+          - const: qcom,pmk8350-rtc
       - items:
           - enum:
               - qcom,pm8018-rtc
-- 
2.43.0

