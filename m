Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4BD4DB562
	for <linux-rtc@vger.kernel.org>; Thu,  6 Aug 2026 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049837; cv=none; b=GppWAJSqVXeQgrZ1ufbg9pYDHKZ7B1Hdnpju5TYl6Remt6t46SdDDUPlINIP49FJeQD26wCcUoh57myCT6WskvvByJlX3DmHf4zEgxMR+6bnrPHBvUgLHpSNyKbrkBdGRLQnjHq/JhSKMOTLgzNb+nhJml/d6oVgWHWF6nImCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049837; c=relaxed/simple;
	bh=zwg1PWhkT+s66AP87LA1pYO8qx4GSQurd1KZURCWRGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pr9gw1ma3gVAx+T2RoyLn8iNH+t4HjNB+WykMLmxWtSE1YcwEYRoZ1tcqC4gm5WcO3z0/if5kGu2RkCy9JHmY5fEBUQXGRu2n2Eud1BaanO+Vizln/isYw72Hpjy3lkSyhZGoL/YcDK8ouk8BXb02cPP3f5CfphMbAfIKK+LKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZmKF7GTF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ARzwXaxO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZmKF7GTF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ARzwXaxO"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHdnQ3908902
	for <linux-rtc@vger.kernel.org>; Thu, 6 Aug 2026 20:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TNn8dvyR8MKVhHoEzNadcA
	7+HBIVRs71on16l2k2cZM=; b=ZmKF7GTFTJVCKcPaFOTa0ojgxZ2gi2CyGffcWV
	Sy2iG2Ts3cWCELR0UdqZH2XtNRU5w8fJaoD7VLkUPrdk2pDgzxgC99x7hIBgFl3d
	BgrhM6WtsXgnzv8Ih+Og6dqGJ1nYiR8ip/TO1i2xA1zcDFNFUclo8o63UAjWvunt
	XCgmmSg5DBUZ+QA/6tYkCRLvS1RDY6Q28pcAN2XTx3rxenu2CcGqccqwhu54AE9r
	o8t2ABmZYEMGRYoOycLmy+g1L0dw0K7xiAsjyrQhpd6saRbZoErlUtjlwdTsBoHn
	nrLlBD/5sNYgA1ucSdAYLckHs0zCwemlDTgXLOAeGxalWOdQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6r8qwe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Thu, 06 Aug 2026 20:57:08 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb6dd278512so1545535a12.3
        for <linux-rtc@vger.kernel.org>; Thu, 06 Aug 2026 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786049827; x=1786654627; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TNn8dvyR8MKVhHoEzNadcA7+HBIVRs71on16l2k2cZM=;
        b=ARzwXaxOZhfHvhrG9QCifOaTPSNJUOQc2p+bkWRN/q9YOD+Hg6xcj4tJYF0L5IeCSk
         yJq1MplS6A8xFlhFZusQyDmoqoSglZyb7Vw7A3E/XNU1hyLc40U3QGvQ0mU7XVQSWcLq
         /wdpQ78eDePACrVYZPVsPwHs/zJcKHjWG5h82yz7CHFq5Ws2UzR40gV/BUzXffZY4OAq
         ucRWvJiFL7QCcN5xp8ysHKietuxJMijNfa7TcGmxDt/zOxIcL8v0//JgDGhM6z2nMXFW
         ndZxRq2c2HxEPdRSp6c+2XXf3aYbRJHNB4G7cEiUJBf9Kul64Z0COYAumSo0RV5S6WV4
         AydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786049827; x=1786654627;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TNn8dvyR8MKVhHoEzNadcA7+HBIVRs71on16l2k2cZM=;
        b=fuZ6r44POFgawQGb65g1WsGVcdEbrIHpL6HeLmKZWkII319fD9imIxroR1nq43lqdX
         QEQuAmX07UtB97qeJxFGWvg1QhEd2njC194x6cMEEIgXooMa1b88gDJvkcEOE9Cwaeft
         P2OhmQIBaFLOBHA5uZgM0BBltOw9Vp+ybTSNHVn5JVTx8Fi3rFF9o8Z/qNqQZ814AbaT
         41EvjlXHLyfqAN0RJaG2n7idVZB2llDtrTerkdjJd1Jhv8X+E7dhaj0e9N7hDJaunLJ6
         lk8qfGIZSf/Gw86z9TGXi2/fJQompJqmi9QrL8aQDT3bYxs4dMLlAVXGYnPDOLWcENbR
         lwAw==
X-Forwarded-Encrypted: i=1; AHgh+Row03Gt2rFeCu4/WEM7tHO1D+cZP3gggVp91gZ86Wq/BDFlprgWjzobi0m9TnTPlQpJ1s4DoiRxktI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHNElUDEEga7NrNNrkgHDl/ONvb7bS5lvEwQMizX6TysZN6nvT
	Gjkm8TQ19twCKBfo454YmjAuqz1xt0V3Z7QnPlt7LDlmGPvvGYGnJTj3M6JP7X5SWgag6RXlWtV
	1FvNj1WZdQMBMAZ91qgIyTqrQOCfQmSU/VcBO92In6B2nbf37fxNqLM4iMcBlzzQ=
X-Gm-Gg: AR+sD101/eKmkSmVxGgmE4Nz2HKxzOUyLtPjAhgs6EdONNP/EtZ4Mfg+CFrcP8AZdTl
	Zc7T5OGwWtpGg2+ttEV855/PUThClnRIo9cTfDOC/rpBQ0R7lQucBE3zhV8spxBddOY3ufLwviE
	wEa7ubIzvFhoUP2c3qUeeo8Bu+i+437NwDfNrmnKuJlu3THLtCfuXygDOLiyuBoC9RxEFGfLdR9
	XQXkJ8JBY85EQxU8Nd7+0P3q11ZzYW+AngRZQiXzPmWMfHpNWmDT5Y2k3ar892VaV4YAB6KrWoV
	/927Ra3pWXCoCvQuhD1VI0RmsiBv2ohUJ6Cq9mikbAFb35x71mQeBDeiqSMIqII1zG0EyvHirzG
	iCtwZXjRmBwzXauZ/IhDNRiezt4HrFQ==
X-Received: by 2002:a05:6a21:6089:b0:3c4:2fe1:fa36 with SMTP id adf61e73a8af0-3cbadd74818mr5812854637.36.1786049827582;
        Thu, 06 Aug 2026 13:57:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:6089:b0:3c4:2fe1:fa36 with SMTP id adf61e73a8af0-3cbadd74818mr5812802637.36.1786049827036;
        Thu, 06 Aug 2026 13:57:07 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bc667f1csm116641eec.12.2026.08.06.13.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 13:57:06 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: [PATCH 0/2] rtc: Add Qualcomm PMIC RTC-GLINK support for Glymur
Date: Fri, 07 Aug 2026 02:26:29 +0530
Message-Id: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP30dGoC/yXMzQ5FMBBA4VeRWZtk/DVyX0UsqgbjSkmLSMS7K
 5bf4pwTPDthD7/oBMe7eJltQBJHYAZte0ZpgyGlVFFJCt1qsJ/E/tFMrO22IGVlojLKC921ELr
 FcSfH+6zqz35rRjbrM4LrugHE0cPndQAAAA==
X-Change-ID: 20260806-rtc-glink-cleanup-038163045afd
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786049822; l=1734;
 i=kamal.wadhwa@oss.qualcomm.com; s=20260406; h=from:subject:message-id;
 bh=zwg1PWhkT+s66AP87LA1pYO8qx4GSQurd1KZURCWRGg=;
 b=LOKErvm6JLx4BuX86tRV0YI6PShIU9b1NqyPmRAFS6Wr8SXiByIjjxaNmc0ZnE13+V7aLqMz4
 XXt9YJMfoJvBqA4UI8BauPAzEyN5F4rPIu9TCJ52wymtjmJI6xLP7sK
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=ylH1NxUZkBpYsmww89g6zVxpS0q8qthtzcORkYxn/Ag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX5kXfALLVPDtU
 JLc1/Efj5RBqStj/2+wTS+k/AdzyGwRLcaHI5mooeCidxaMFFOvqWEwq7Hxw4fQz4r+iaJaAShy
 rQxBH8uLXbSQD4OQv1C8DVfiRehicw3jN3E0nADvGIHhoNlFVBT8bPj22viyt/kpkOCk7nMDZCF
 w9n1AHsczcpMwg0WF8tqLUubCOIKIgAX4YSGODFjNFBqnx3QLwTKr+RCUGDVeStLNUNOMnOLEH1
 B7Lgq6ARkfUMzr51wCdVmS6H4I7nhOrr9xzRFiptOP23okVVHKpigJNlMoznR/wwh+tWNTBGfH8
 YVkbfdO44/2oT/hZdfGbzQrUptzGKi4OVt17AjMu2/Pzg0LrbHbBwqwx0a1wNb5DUuRyPSvxvJ9
 M5Ee2Abw5Nzbi4G7RTZw/+QHN5poKVTKbRXuBI9R0eCj01/Y/HY1YvkijE+ulXxtgQYEDcOYuVF
 0e1I9P99sqy5PXCTjZQ==
X-Authority-Analysis: v=2.4 cv=HPXz0Itv c=1 sm=1 tr=0 ts=6a74f524 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=WiWho93J9qY7Nhnkw_wA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Bu2hwaseRYIAIxoQOZ--x500Z5tLJZtj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX9Yenzo2qW9kH
 zmCQ9y0SAUfWbcNzxbU+JkahTPT9E0XlKqewnCZ6lXkCeEGbRksYIotdJPPdJ7075BEbE/feF9D
 gKYnenNqmCWIETfQcbjz/sfmVfhPFEc=
X-Proofpoint-GUID: Bu2hwaseRYIAIxoQOZ--x500Z5tLJZtj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060163

On some targets like Glymur, the permission for receving the RTC
alarms is routed to charger firmware running on remote subsystem.

This is because Glymur boards have to  support MSFT's `TAD feature`
on the windows OS devices.

So rtc-pm8xxx.c driver cannot recieve RTC alarm IRQs via SPMI on
Glymur. So in order to make the IRQ available on the Linux kernel,
the PMIC RTC Alarm IRQ must be routed to APPS via remote subsystem.

To implement this, add support for a New Qualcomm PMIC GLINK RTC
client, which will request for RTC set/get calls for time/alarm IRQ
 via the existing pmic_glink interface to the charger firmware.

Also, add a DT property to explicily support enabling the RTC
writes, keep RTC writes disabled by default to align behaviour
with the existing rtc-pm8xxx.c driver.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
Kamal Wadhwa (2):
      dt-bindings: soc: qcom: qcom,pmic-glink: Document RTC client properties
      rtc: qcom: rtc-glink: Add PMIC GLINK RTC driver and extend pmic_glink

 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   5 +
 MAINTAINERS                                        |   7 +
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-qcom-glink.c                       | 690 +++++++++++++++++++++
 drivers/soc/qcom/pmic_glink.c                      |  22 +-
 include/linux/soc/qcom/pmic_glink.h                |   1 +
 7 files changed, 735 insertions(+), 1 deletion(-)
---
base-commit: 1701fda2f58e345c050f4309971bdc07cd6146ba
change-id: 20260806-rtc-glink-cleanup-038163045afd

Best regards,
--  
Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

