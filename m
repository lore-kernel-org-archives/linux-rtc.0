Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659396;
	b=TJFOgIcwDCsDiw8QyJzoqvo3UBk4u1qXizBdBTaw0dIXp2quNe5qZuW5MkSVGtVdldCV
	 EaDu9Nt+ehdijRDwUcxYJqfZaLH7icDrVyJngqtSwBVG6h4Fs1fduwl4v/8FxfZhx0ZrI
	 iJVqVsS9hn489awi95GE+89GYtdTTZk5HFUlBtN8dIlhFFN7MBl08tbVN9xV7joO2KOl9
	 mI6aUKD7Vzl9NeIZq60BPpg7vTTfDJWLDC/VR24o/S9+9agYCuZV0lbpB0Kf/H6ClgJ2f
	 CTY/08ZHCpos2zivWbmxV7y5qVXZq9xAia9aXQYqgPUkGPp3AwjY+HmUnqZBLtN86bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659396;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2sxsRWlKfg/leqhheaFNE/NKgDRvemJZ2eId3SX/IcU=;
	b=BLorNzQ92soMbSdjdGZHMeERxQclACIfhF5HEKJkSlI0fXMSNlrAB3NA037JNxbs7W5E
	 eoG+EvrCy4ETrBro6UVsGu6Ye/2vJgN87YuaMu4WN0p5RkSjYPnQv7+hOZkcSyW9OB0Hz
	 5+gs2keDZBrPotNbJ5uT9MoEUwuvMfGMrzbuySH+Ys/u212QohTqBk/fty8tbK6AVt1TI
	 /vUEQrC5A1FAClzWpEMqBxP2rZfREqhrPmlRTUQgbtlCVjq7UAoiYBBv1nzuOZPm6BBiM
	 HB6tod4uyM4MgsbVIXCTItPYeNZkFedlEa307jh+zKS3XoMURn+j74IE8B1JmNdkrug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cFEtGTVF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I7NAyc1E;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83150606A332
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 22:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83150606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cFEtGTVF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I7NAyc1E
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2K6CEp166089
	for <linux-rtc@vger.kernel.org>; Mon, 2 Nov 2026 22:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2sxsRWlKfg/leqhheaFNE/
	NKgDRvemJZ2eId3SX/IcU=; b=cFEtGTVFLjWo5+wGENJ5L7U9pK2ayuS/WFm1yN
	ofFzmL4YZthsZShQqlpCLHrQdnjfF+oPSU0y6gtWM6AcXlMyUZiOX5NgpH4pU35Z
	NqxVzrixxjnQy+7+A6a3XYgcPK5YLCrbKIFX341rGpxQYbDhXOJIetzUY/3w7gKM
	/D2GnuynspZPT0m0IXoXYraiDM811z7iyZhRmQTP0TF9wizas2h52FRqho3ROrd6
	I0eyjemlg759tZN38jRI0ahceS04X6qnkApIoHTD4BzsaeGHysL6WnZ/qCLJESlY
	pnN4Pt4Mc7e+F9g1MiQuUX+BTA3hQEEiuN8kRnP/YiIzjjBQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrk8rf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Mon, 02 Nov 2026 22:43:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so8072930eec.1
        for <linux-rtc@vger.kernel.org>; Mon, 02 Nov 2026 14:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793659388; x=1794264188; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2sxsRWlKfg/leqhheaFNE/NKgDRvemJZ2eId3SX/IcU=;
        b=I7NAyc1EAd2R4I0lYpFDQ5kWOuMVR7KPhPd6ZueuslYTcihXipuejgD8q2iwz8v5wH
         stEp7UuYSUDL/5yKSjQ42MUEmxSQ7pssW5A8dxUSUFi0GYlSajSHL3J73tRABIOfaxXf
         A4w4krhrgLIUB+rb07jYOoZaRAtKyVjs4SeEEXoFIkXEkFxXmB0WlwyBlfv90hTepU97
         p7e81mNNLXY788CuSESyjkmqvXPbx6k92qBtHz9rhfZ7/slbmf03F3AVHyeaftm32lUv
         6wOOIbDwC/1upnJH+slc4885svu69CqKUXwF/ABtdsiRjY9mf1kjpSZgBxrA5BfdZnf7
         bj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659388; x=1794264188;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2sxsRWlKfg/leqhheaFNE/NKgDRvemJZ2eId3SX/IcU=;
        b=VVuMbPtj4G1zRtFCw5ocQjcKdXaBucq94kqF11NN279U3S8Ce1xWvx3NGpV+r5jl2u
         PVjbPg/su8hB1+dSGiSDTlQwPv92+PJAQYKRU2NCis3RDYT9zfJV9bWdZP0cMxP9e+g1
         FaVWnQrhQ7wR9pjeDyyR5T8iCfEpoeyGfradg7wIJmPjvIBaJL4iBlSFLxSIaCfTh8s+
         VgnzmyrkZHMhK7ujhhQ4icNeOZIxEC2YRS0eZKtgD3TqJeA1+FX1sZ2TpYDZFR7E0aLo
         eaBDbEAy1w4+4QlMY5sLKbsjcVFd79ZPACObCmEYPobmIAq2hGQzWzxZT1wgOXa8oq3K
         xldw==
X-Forwarded-Encrypted: i=1; AKwUvBwhBak4vcD/Zwjjcfw7qwxQ6zrqKYMSF3lf+Q1mtS2rLVwV58DsD4Cvy+6YEP1ojzbterfmVxZkoMk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yoJnWGS9VA6D1oR7MFcsed0Pem8P65F4fpKH2fjcGaztplEb1
	w82i9XeIb6e7KlxdVciGYaH3SxvJa/IQzcVzVQ1thZzKs1NLg2iCkrRHJaNPIl76/Bb571RX3QW
	vIZCRNmIDnP5ZCT+j9p8LvWQil7K6VNMeQ6YKXLFfquNrKlHbKyJIXbOGcAybx/QaYQr+Cfk=
X-Gm-Gg: AYBFou1TH5ZDAifvyyq6TZMk+I6qtoZhp7lYuBl5MnzqLPnMprlULbu9uQ0T+5H8PJm
	JIs9Clwle/n1kf2BH3JTdIHVJ8HDpfQ4XoXu5NjsBVqbacOQaAiFkB9LraPGmZsx7UdUxtCuYwO
	+G+hU/4VMfbPtDlW++KfbGVyYCKa6biEM/MG4y1kRv2dkYewjit+sygkc7IdsqZp4kYzwF7LyEi
	Qheay73Spv6yA3t9vjS6MCiSYI8NjRmAyKK5nQhTftivnjoQn+foNHp5NfgQmk+LuS47Y+4HXCO
	oBLqhW9peC/Q1AuY06E31yqqgkAxUFvfOfiQVgnqVmyN19qE7kB6n9Mffa78+KMcCpoxISJex1K
	04gy2ZKVIu3eGAOBvt/938U39ph/DV5UbMRtFeTPwhzGbJIiz9oqAEGrv6Vwdbbo50tL1tO9ocw
	7g2w==
X-Received: by 2002:a05:7301:7e14:b0:367:363f:6fe4 with SMTP id 5a478bee46e88-36a423f6947mr15661261eec.32.1793659387278;
        Mon, 02 Nov 2026 14:43:07 -0800 (PST)
X-Received: by 2002:a05:7301:7e14:b0:367:363f:6fe4 with SMTP id 5a478bee46e88-36a423f6947mr15661231eec.32.1793659386617;
        Mon, 02 Nov 2026 14:43:06 -0800 (PST)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429467cdsm38673319eec.19.2026.11.02.14.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:43:06 -0800 (PST)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: [PATCH v2 0/2] rtc: Fix broken RTC alarm support on Qualcomm
 Glymur and Hamoa/X1E80100 boards
Date: Tue, 03 Nov 2026 04:12:16 +0530
Message-Id: <20261103-rtc-glink-cleanup-v2-0-895eb6e8d890@qti.qualcomm.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMgR6WoC/22NQQ6CMBREr0L+2pIWsKAr72FY1PKBKrTYD0RDu
 LsF487NJC+ZebMAoTdIcI4W8DgbMs4GSA4R6FbZBpmpAkPCE8kLLpkfNWs6Yx9Md6jsNDCeFkK
 mPDuquoKwGzzW5rU7r+WXabrdUY+baGu0hkbn3/vpLLbez5//8c+CcZYXXGBWyZPO6osjip+T6
 rTr+zgElOu6fgC2x/FGywAAAA==
X-Change-ID: 20260806-rtc-glink-cleanup-038163045afd
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Raj Aryan <raryan@qti.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793659383; l=3682;
 i=kamalw@qti.qualcomm.com; s=20260406; h=from:subject:message-id;
 bh=1PdOOUp2CYNC2i5yaYElF8vnXcP3Dq4i4K1LytEr1YY=;
 b=6Tdj666FpYLsldYchKz9aU5buXHYvBfgYNwEQlv8wuYYyc6e3pNXRZ5JqJUO8zA+vAhiPgQ2U
 e9KJhOVA7WqBz+fuJh1Xhk7nHTR7iWfqRPSQAQbNudc7f9M/PNLj5OY
X-Developer-Key: i=kamalw@qti.qualcomm.com; a=ed25519;
 pk=ylH1NxUZkBpYsmww89g6zVxpS0q8qthtzcORkYxn/Ag=
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae911fd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=yMhMjlubAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=P-IC7800AAAA:8 a=Opl38xjawUwNXisF-KoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=FO4_E8m0qiDe52t0p3_H:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: cPcISYlspftfcJZuPZBQaTP--bAw07eT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4OSBTYWx0ZWRfXxgyTGLMFGwqB
 /663+iRiD4iOO3pyTDBoVNLv3Ml1L2/vHMdi3hopWBBv41bbhHcEKr9cIyQlxW6HO5HiXp8jw9I
 KVNJXG18Jszg2vVAzf2PamZl3ZH3EcM=
X-Proofpoint-ORIG-GUID: cPcISYlspftfcJZuPZBQaTP--bAw07eT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4OSBTYWx0ZWRfX1RxmnNPsXEeF
 kHJI/3X9N3ac4N3I+Uwl8hL0zDKPqiJXb6T/VFJTVfOAMfsM2idB28kaaTjk9MJFBZ9re6OUMTX
 vsKsun7Xx3Z/7vGTW1kQQ5vvDST6kJqt6Awa8LS8z2pmTEWXCUwOJkQDwZ7HnOyn2uSyiS9CpUy
 lVZGlXxS8bW2DtEJ+AdyriGUEQbfISzrHyYw4zPfsnuOGxPYMutnOw4A36D5VnmsuXrnnuBshyX
 fWYlzNESZwQi7p71OLtQZYu0kuasnQE8xXzvsdF7VS8duGH73SSDaS21GOVK1OCIJgvfY1M/Xov
 2P/2ps06rzj3TfrSFY6fQ4t8zSn+8Hy2dCDNh7VFS3Pi0q6Zg33SYq9zukrl6ut2R/f55LcO4D/
 LpHivCwstF4paSp9w4B3EV6CfMHLtRbANNNvD+cxHXQ8xvEz71Ae7pO0RtwMphpu6WNrBuc4fiP
 C6mN3AU9UmR7SfRh03A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020089

On some Qualcomm targets like Glymur & Hamoa, the SPMI based rtc-pm8xxx.c
driver is unable to receive alarm IRQs. This happens because the SPMI IRQ
permission for receiving the RTC alarms is routed to remote firmware that
implements the TAD feature [1].

TAD feature is a standard feature on Microsoft Windows OS based devices.
Since Glymur and Hamoa were originally launched on Windows OS, unlike the other
Qualcomm targets launched with Android/Linux OS, rtc-pm8xxx.c can not work on
these targets to provide alarm support.

So in order to make the RTC alarm IRQ available on the Linux kernel, the PMIC
RTC Alarm IRQ must be relayed to APPS from the remote firmware via Glink
interface and on the APPS side a new driver is needed to register an RTC device, and
provide time and alarm functionality.

To support this, add a new auxiliary driver rtc-qcom-glink.c under the
existing pmic_glink base driver, which will register an RTC device and will
handle the communication with the remote firmware for RTC related operations via
the pmic_glink interface driver.

[1] See "Control method time and alarm device" in the specification:
Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-defined-devices

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
Changes in v2:
- Extended this series to include Hamoa RTC support (along with Glymur)
- Split the single driver patch into two: the pmic_glink client plumbing is now
  its own patch, separate from the RTC driver.
- Fixed a UAF on driver unbind/probe failure by registering the
  GLINK client only after the RTC device is allocated, and by
  explicitly unregistering the client before cancel_work_sync() in
  remove().
- Fixed a timeout in qcom_rtc_glink_request() that could leave the
  request/response state out of sync, letting a late firmware response get
mistaken for a subsequent request's.
- Fixed 32-bit wraparound and sign-extension bugs in the time/alarm
  math, and removed the ticks-based time fallback entirely along
  with the offset tracking it relied on.
- Renamed the GET_PROPERTY/SET_PROPERTY opcodes (and the structs and
  helpers built around them) to GET_TIMER_VALUE/SET_TIMER_VALUE to
  match the firmware's own wire protocol naming.
- Dropped the "allow-set-time" DT property: the firmware does not
  gate RTC writes on it, so it was host-side policy with no
  hardware/firmware fact to document, not something devicetree
  should express. RTC writes are now always allowed.
- Link to v1:
  https://patch.msgid.link/20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-rtc@vger.kernel.org

---
Kamal Wadhwa (2):
      soc: qcom: pmic_glink: Add RTC client support
      rtc: qcom: rtc-glink: Add new driver to support alarms on Glymur & Hamoa boards

 MAINTAINERS                         |   7 +
 drivers/rtc/Kconfig                 |  10 +
 drivers/rtc/Makefile                |   1 +
 drivers/rtc/rtc-qcom-glink.c        | 590 ++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/pmic_glink.c       |  43 ++-
 include/linux/soc/qcom/pmic_glink.h |   1 +
 6 files changed, 651 insertions(+), 1 deletion(-)
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20260806-rtc-glink-cleanup-038163045afd

Best regards,
--  
Kamal Wadhwa <kamalw@qti.qualcomm.com>

