Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794900813;
	b=GQAH+7c5fwfOtFETzImaC8w/vIfhioFb223akvi9ylc0t8H6mvrvc8UebfvNp6enYkQ5
	 LVA06KHCR3ZDfutK+OgP2K21J/Xl40lEQdhKq9xQUoDE4QSTPeHmezwl4NeqtT03mYhYr
	 I6kS/Unz/bukoQnzZlcTEoQ/eFDqAozTbnrkfPq32UyfN47vI5Z3fi7FLKSAZcjOXklRj
	 LhuxyPEZV8WBH9JMyu7ebwGwsfXk3nQxsRPMaY8wxX9pWkC+p5v2qGpcPK1LrO8TQNYB4
	 TEmIclPZbw5C7SgjBtJuAhCBVQdinAIf045iDdi2akI38WJ1mPvBK1P8N9xFGxCrDQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900813;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=D1PofqN9VO+f3dursuBgYbD8mpWVQv4pbEKGr63A14I=;
	b=WQJCBwUhfSEp0IRuWhoJSkjzMhnzjKVg5GXk7D7FH7GmsMNgS3t2SYcb8DSrV4DgwlYN
	 aY1DZo9MiuTd0lEH+sn242ureuj2ewNuyMGooTd6vt9nHR/xg1W9Izi+PArdrUk5nB1L+
	 rb/T+LZKaobB3UX80Lg9EZSMoLXH2IR2xdjHHew/964fIe7T/Scod2MIKGTO2u/sxQPtE
	 Ww14QE548gK5oiCuuYb9s2nuEhMdNZGCXAURPI9Rn/OJs+a5KvIkolPLdlnbOIp+6zqk3
	 oYpdmDQMINzuEFs/tmzHTNzanKVFPF28V8pb7ZM2fkZbyocHsM0VW3fzNvedWFhxAKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bMLLy0AT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dt7To2ZB;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F0606A884
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 07:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F6F0606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bMLLy0AT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dt7To2ZB
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH6LmFD3980749
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 07:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D1PofqN9VO+f3dursuBgYbD8mpWVQv4pbEKGr63A14I=; b=bMLLy0ATGBabVtq2
	OQahNlMghwC240PPYEE1cCCK2Te31EzDJW5zSuHdVReMMQjB8lIeGvHjFjBnp3su
	WF9tMopCZ+7Rh2JiwdnxWSwd1g1X6LWqqVtsIpCT5/chzoE7GFplGr6r1yie45Rb
	Qgn/5kSjBy8607SMC/A4ZigqRjeB7mlBRAg1ikji1KczXneWxb/moyZPpiVIvOgE
	LKYPo3fVrqjFUtZRUqLMZMghYJgpSpuKHd5lfqQJZXO7J1sHkqKvqE0ykfzqcciE
	DxMY9QxLuUygouUj/55Ca32l6sVCB8M47rCjz/i/F+8NW0qeOY6u8LGCSLxbioFj
	Rj6hqA==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hkd0894-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 07:33:31 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-47d75bcf3ebso3942460fac.0
        for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 23:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794900811; x=1795505611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D1PofqN9VO+f3dursuBgYbD8mpWVQv4pbEKGr63A14I=;
        b=dt7To2ZBHpzaHOXZ4i5Nf3OtMQEXet/Tjz4ZxOCpGwB6IWKAqLtC6+PciacrNmJyRp
         lPlr7NpKky/UOu/IPY4WxemT840dCpVkoVisVfws+cwU8JZ0fCyyoPaT0yIr/M9qZPJS
         T+k3wbmv4hBYFUk930FxyET/384lskKW0aUtPYMlbD3MdTZzSIeXXzuOg7Y/Czmg8SEU
         xvV084lZuaAgmnA1ZbrmDjHRNtmzVzTkv8rvaDRmr9Oh2YwCRPHXEdpQgowxmqPNgGg6
         TkesutkR4pwzpF8ZN+Snabj2jjN7tUB/NHMOgnAaq61PaBgJSIPaTZsNJwLjnt/egIpk
         0QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794900811; x=1795505611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D1PofqN9VO+f3dursuBgYbD8mpWVQv4pbEKGr63A14I=;
        b=mhVtfae/ainP2OjuY/7FemolcKZNd7K1kzv5bAf1FRMNgyRh+EIjxK9Kke7alAS7Uu
         21c20cUo1s7XHZNOey5wcYlcF7nDrfp9bH/oP3YMwOIh7Ugjhrix5kEHb9DyOie7fcA+
         ahR5ENWoTNmPgBMjF0MtUNF7TKmk3iZGjEmviZLS8iRhy5cWWFhckyRa8zkl5TUXFTyj
         4ECH9Mojek5tIviR4Ov/zA1BdCQpfs182ZTpwgJbiDumm4PbTEdHrXWF7UJnHwoo+rXX
         xJFOzBouwfnGH1VQmoiGcFVmYXYhDNfLbmKitc/eE9B8ynIuunx2qGavQJ2GS+4KFRa7
         O5oQ==
X-Forwarded-Encrypted: i=1; AL+hErG9Yl3n+8VGJjBMDFyKwIjr2/z8dz8J3GXXqkJfe2v6guLvd++0tvJEHHl/1rfgG3+7lwfhgAH9cDw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xl1ZqqhL6wSsghcLjPcuLkusz6KidevCA1xwQuaaKdKSe6aPX
	L2jUg/Sfp2OsSGNJumoCmDU38zC8jdEMZyIimlmrlh5iG4O8iVj5adozBzr3elG7Z7AoV3XDyJq
	fYrEL9mFmQAGiGw5Czd0MHHa8DB7XCDlvwKO31IG5dINBLooQalkRktsLXzRQmQQ=
X-Gm-Gg: AYBFou1yIyi7qggtJP2WEYKerTdX96SS0nHx4tIY09pQ4IF1Gxj7NEJI5FJIf9GhcyX
	eIqnrERq7CRqczQTOAEd5IOlqTCnOwfHvmV64MCuqn5CRH4eR66aVXc0+SXH7TbQZ3kCdYrcW5K
	ADUn1Dkc6j2LTvzQTtEy5oDQbpp8fhupGlcVwK243qbl1qQCG6nGiQ9yqysl4UvnJDUyeByY9bc
	c18pqkt4yrhGZst/24vCG5H4GdP5oQR1/yezcVDR35CaJXnynTdmVBVfpGWJoTVw4WOE4FGRIvZ
	vwfm8TUSOMD1ugPVz94ARtU4ks7CHQP2Ux7dirHSIWqHB1ChcvP8F0RFl2PQpgW7k6YIgxYJJop
	AdU1vxsajeC7cxejoXbiJbUGbPB/rVFhmGftQM+JAPwETI7uQfMtpC/UqpScR10yO0PM+uVB4c7
	d7946yaczAtrddSFhrbStKl081zQ==
X-Received: by 2002:a05:6870:ad86:b0:4a6:f698:df8f with SMTP id 586e51a60fabf-4afdf477d78mr11779812fac.42.1794900810139;
        Mon, 16 Nov 2026 23:33:30 -0800 (PST)
X-Received: by 2002:a05:6870:ad86:b0:4a6:f698:df8f with SMTP id 586e51a60fabf-4afdf477d78mr11779788fac.42.1794900809383;
        Mon, 16 Nov 2026 23:33:29 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe228982bsm8593875fac.10.2026.11.16.23.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 23:33:28 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 23:33:18 -0800
Subject: [PATCH v2 2/3] soc: qcom: pmic_glink: Add GIO pmic_glink instance
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
Message-Id: <20261116-gio-framework-rtc-driver-2026-10-12-v2-2-b60e6fe33831@oss.qualcomm.com>
References: <20261116-gio-framework-rtc-driver-2026-10-12-v2-0-b60e6fe33831@oss.qualcomm.com>
In-Reply-To: <20261116-gio-framework-rtc-driver-2026-10-12-v2-0-b60e6fe33831@oss.qualcomm.com>
To: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794900802; l=22017;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=mptYCjY4gfZQ5iFfngPsJRsSfCW82kTYHmwIC9eQrPw=;
 b=SETCKnDtO9aeDT1RYU20Fa0NuK1w1sWiHiRnaXP1VtCtePF2TdnaQh8VgCYSKtj8EHeZ5tfHH
 F2VjVydqpIvAzoNsFHFIpGEGbx26KYy5apQuIbJxdkwgot/gIDSvniR
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Authority-Analysis: v=2.4 cv=eqFKXYpX c=1 sm=1 tr=0 ts=6afc034b cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Xe68GOy1h7Bi-u-YiFIA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyOSBTYWx0ZWRfX/77vw0i6Pq2o
 8B+SEcuADxOSXfx6D3/xgW07PJgQbzp+mxgBzkVpBY97+/16AMDn8Ae9nXGYMLfP7nFGca8pHNg
 YWYhLK0SRpOwc8Fnpc0mcpW+QTZ4+nE=
X-Proofpoint-GUID: vzhlUweAUvVxsX69qlUYfNLSQ3r3KAoj
X-Proofpoint-ORIG-GUID: vzhlUweAUvVxsX69qlUYfNLSQ3r3KAoj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyOSBTYWx0ZWRfX4UgPIcynCekq
 CHPPc6zRupwosD27RRMLhD3h8bKS2JDY/SZWn7rsdrdV5xnWI4toEt66tkMrqsDZwSEGee6dFSO
 ymESZ8Qd79wtbXfhs9ZNAjxjsz/fnPQLD2nnMHg2VfN6EOh5IX2uZ3DzNJGAGMC6tihSXt5IP25
 fMfKrKV7t+43wW5cmbZ6LxMbJd9Nw0vNHgkk4ZykKeMkz65gxTbSxdM694LGma9bRG7qGI9wOpY
 InXrVydcwm9KBDYxG0tAkHqwRgJQF1ofABWWQt7aPD7EO/bcpdR4F6vfshr9+q6HtseRoaJ6FkF
 6VbB522EFXLbec32B3RRQYURvlCTvOi7S9Dc6Hr617CHNmEQGW/SPEbISpB2AmS5IUOd9Pu6xLL
 IYhEqsigqU1tFLsV/4fz2o5WzcLtwzi/EP9mGW83knf+nZjNsAm11OcmoPKdyH+hiRTBuq4tnoG
 swwRHvbbjnG7seZDHBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170029

Add a PMIC GLINK transport instance for GIO (General I/O) which is a
new communication model used by the SoCCP battery-management firmware
on some of the Qualcomm platforms (e.g. Glymur): it turns the
GIO_OPCODE_BLOCK_READ/_WRITE requests and the GIO_OPCODE_ALERT_IND
notification exchanged over the pmic-glink rpmsg channel into a regmap
and per-alert IRQ delivery. It registers as a "pmic_glink.gio"
auxiliary driver and bound to a new "gio" auxiliary device that's created
on GIO-capable platforms.

Also, update the client_mask to additionally request the GIO client on
Glymur, which is the 1st platform to support GIO. Even through the legacy
clients (battmgr, ucsi, altmode) can also be supported using the new GIO
interface, their per-client bits are still kept with the functionalities
continue to be provided by the existing pmic_glink.* auxiliary devices
using the pmic_glink interfaces, to minimize the risks associated with
transitioning all of them to use the new GIO interface.

Co-developed-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
Signed-off-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/soc/qcom/Kconfig            |  13 +
 drivers/soc/qcom/Makefile           |   1 +
 drivers/soc/qcom/pmic_glink.c       |  25 +-
 drivers/soc/qcom/pmic_glink_gio.c   | 544 ++++++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/pmic_glink.h |   1 +
 5 files changed, 582 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 266a1babc108..64f21fe6911e 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -137,6 +137,19 @@ config QCOM_PMIC_GIO
 	  Say yes here to enable the GIO interface on a SoCCP based battery
 	  management firmware platform.
 
+config QCOM_PMIC_GLINK_GIO
+	tristate "Qualcomm PMIC GLINK GIO driver"
+	depends on QCOM_PMIC_GLINK && QCOM_PMIC_GIO
+	default QCOM_PMIC_GLINK && QCOM_PMIC_GIO
+	help
+	  The Qualcomm PMIC GLINK GIO driver provides access, over GLINK, to
+	  the General I/O (GIO) register space and alerts exposed by the
+	  SoCCP coprocessor on some modern Qualcomm platforms.
+
+	  Say yes here to support USB-C and battery functions through GIO
+	  interface with the PMIC Glink transport exposed by SoCCP coprocessor
+	  on a Qualcomm platform.
+
 config QCOM_RAMP_CTRL
 	tristate "Qualcomm Ramp Controller driver"
 	help
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index c3170757b012..5a0167e8fa55 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_QCOM_PDR_MSG)	+= qcom_pdr_msg.o
 obj-$(CONFIG_QCOM_PMIC_GIO)	+= pmic_gio.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
+obj-$(CONFIG_QCOM_PMIC_GLINK_GIO)	+= pmic_glink_gio.o
 obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
 CFLAGS_pmic_pdcharger_ulog.o	:=  -I$(src)
 obj-$(CONFIG_QCOM_QMI_TMD) += qmi_tmd.o
diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 84fd0c82c0c4..059f4fd7a5d7 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -2,7 +2,9 @@
 /*
  * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
  * Copyright (c) 2022, Linaro Ltd
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
+
 #include <linux/auxiliary_bus.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
@@ -21,6 +23,7 @@ enum {
 	PMIC_GLINK_CLIENT_BATT = 0,
 	PMIC_GLINK_CLIENT_ALTMODE,
 	PMIC_GLINK_CLIENT_UCSI,
+	PMIC_GLINK_CLIENT_GIO,
 };
 
 struct pmic_glink_data {
@@ -40,6 +43,7 @@ struct pmic_glink {
 	struct auxiliary_device altmode_aux;
 	struct auxiliary_device ps_aux;
 	struct auxiliary_device ucsi_aux;
+	struct auxiliary_device gio_aux;
 
 	/* serializing client_state and pdr_state updates */
 	struct mutex state_lock;
@@ -326,10 +330,15 @@ static int pmic_glink_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_GIO)) {
+		ret = pmic_glink_add_aux_device(pg, &pg->gio_aux, "gio");
+		if (ret)
+			goto out_release_pdr_handle;
+	}
 	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
 		ret = pmic_glink_add_aux_device(pg, &pg->ucsi_aux, "ucsi");
 		if (ret)
-			goto out_release_pdr_handle;
+			goto out_release_gio_aux;
 	}
 	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
 		ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
@@ -367,6 +376,9 @@ static int pmic_glink_probe(struct platform_device *pdev)
 out_release_ucsi_aux:
 	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
 		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
+out_release_gio_aux:
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_GIO))
+		pmic_glink_del_aux_device(pg, &pg->gio_aux);
 out_release_pdr_handle:
 	pdr_handle_release(pg->pdr);
 
@@ -385,6 +397,8 @@ static void pmic_glink_remove(struct platform_device *pdev)
 		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
 	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
 		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_GIO))
+		pmic_glink_del_aux_device(pg, &pg->gio_aux);
 
 	guard(mutex)(&__pmic_glink_lock);
 	__pmic_glink = NULL;
@@ -404,8 +418,15 @@ static const struct pmic_glink_data pmic_glink_soccp_data = {
 		       BIT(PMIC_GLINK_CLIENT_UCSI),
 };
 
+static const struct pmic_glink_data pmic_glink_glymur_data = {
+	.client_mask = BIT(PMIC_GLINK_CLIENT_GIO) |
+		       BIT(PMIC_GLINK_CLIENT_BATT) |
+		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
+		       BIT(PMIC_GLINK_CLIENT_UCSI),
+};
+
 static const struct of_device_id pmic_glink_of_match[] = {
-	{ .compatible = "qcom,glymur-pmic-glink", .data = &pmic_glink_soccp_data },
+	{ .compatible = "qcom,glymur-pmic-glink", .data = &pmic_glink_glymur_data },
 	{ .compatible = "qcom,kaanapali-pmic-glink", .data = &pmic_glink_soccp_data },
 	{ .compatible = "qcom,pmic-glink", .data = &pmic_glink_adsp_data },
 	{}
diff --git a/drivers/soc/qcom/pmic_glink_gio.c b/drivers/soc/qcom/pmic_glink_gio.c
new file mode 100644
index 000000000000..9a28f88152b2
--- /dev/null
+++ b/drivers/soc/qcom/pmic_glink_gio.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/atomic.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/pdr.h>
+#include <linux/soc/qcom/pmic_glink.h>
+#include <linux/soc/qcom/pmic_gio.h>
+#include <linux/soc/qcom/pmic_gio_regs.h>
+#include <linux/spinlock.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/workqueue.h>
+
+#define PMIC_GLINK_SEND_TIMEOUT		(5 * HZ)
+
+/* GIO (Generic I/O) pmic_glink transaction opcode and mask */
+#define GIO_OPCODE_BLOCK_READ		0x90
+#define GIO_OPCODE_BLOCK_WRITE		0x91
+#define GIO_OPCODE_ALERT_IND		0x92
+#define GIO_OPCODE_MASK			GENMASK(15, 0)
+
+#define GIO_RW_BUFFER_SIZE		1024
+#define GIO_ALERT_MAX_PENDING		32
+
+struct gio_alert_hdr {
+	u8	revision;
+	u8	reserved_1;
+	__le16	serial_no;
+} __packed;
+
+struct gio_alert_info {
+	u8	peripheral_id;
+	u8	reserved_1;
+	u8	alert_id;
+	u8	reserved_2;
+} __packed;
+
+struct gio_alert_data {
+	struct gio_alert_hdr	hdr;
+	struct gio_alert_info	info;
+	u8			payload[PMIC_GIO_ALERT_PAYLOAD_SIZE];
+} __packed;
+
+struct gio_alert_msg {
+	struct pmic_glink_hdr	hdr;
+	__le32			reserved;
+	struct gio_alert_data	alt_data;
+} __packed;
+
+struct gio_read_req {
+	struct pmic_glink_hdr	hdr;
+	__le32			reserved;
+	__le32			offset;
+	__le32			length;
+} __packed;
+
+struct gio_read_resp {
+	struct pmic_glink_hdr	hdr;
+	u8			data[GIO_RW_BUFFER_SIZE];
+	__le32			ret_code;
+} __packed;
+
+struct gio_write_req {
+	struct pmic_glink_hdr	hdr;
+	__le32			reserved;
+	__le32			offset;
+	__le32			length;
+	u8			data[GIO_RW_BUFFER_SIZE];
+} __packed;
+
+struct gio_write_resp {
+	struct pmic_glink_hdr	hdr;
+	__le32			ret_code;
+} __packed;
+
+struct gio_alert_work {
+	struct work_struct	work;
+	struct pmic_glink_gio	*pgio;
+	u8			peripheral_id;
+	u8			alert_id;
+	u8			payload[PMIC_GIO_ALERT_PAYLOAD_SIZE];
+};
+
+struct pmic_glink_gio {
+	struct device *dev;
+
+	struct pmic_glink_client *client;
+	struct pmic_gio_device *gio;
+
+	struct workqueue_struct *wq;
+	struct work_struct init_work;
+	struct completion ack;
+	atomic_t alert_pending;
+
+	spinlock_t lock;	/* protects the transaction state and flags */
+	bool pending;
+	u16 pending_opcode;
+	int ack_error;
+	unsigned int buf_size;
+	u8 *buf;
+	bool removing;
+	bool service_up;
+
+	struct gio_write_req write_req;
+};
+
+/* Must be called with pgio->lock held. */
+static void pmic_glink_gio_reset_transaction(struct pmic_glink_gio *pgio)
+{
+	pgio->pending = false;
+	pgio->pending_opcode = 0;
+	pgio->ack_error = 0;
+	pgio->buf = NULL;
+	pgio->buf_size = 0;
+}
+
+/* Must be called with pgio->lock held. */
+static void pmic_glink_gio_complete_transaction(struct pmic_glink_gio *pgio)
+{
+	pgio->pending = false;
+	pgio->pending_opcode = 0;
+	pgio->buf = NULL;
+	pgio->buf_size = 0;
+	complete(&pgio->ack);
+}
+
+static int pmic_glink_gio_prepare_transaction(struct pmic_glink_gio *pgio, u16 opcode,
+					      void *buf, size_t buf_size)
+{
+	guard(spinlock_irqsave)(&pgio->lock);
+
+	if (pgio->removing)
+		return -ENODEV;
+
+	if (!pgio->service_up)
+		return -ENETRESET;
+
+	reinit_completion(&pgio->ack);
+	pgio->pending = true;
+	pgio->pending_opcode = opcode;
+	pgio->ack_error = 0;
+	pgio->buf = buf;
+	pgio->buf_size = buf_size;
+
+	return 0;
+}
+
+static int pmic_glink_gio_wait_ack(struct pmic_glink_gio *pgio)
+{
+	unsigned long left;
+	int ret;
+
+	left = wait_for_completion_timeout(&pgio->ack, PMIC_GLINK_SEND_TIMEOUT);
+
+	scoped_guard(spinlock_irqsave, &pgio->lock) {
+		ret = pgio->ack_error;
+		pmic_glink_gio_reset_transaction(pgio);
+	}
+
+	/*
+	 * If a BLOCK_READ/BLOCK_WRITE request times out, its response may still
+	 * arrive later and be mistaken for a newer request with the same opcode:
+	 * neither gio_read_resp nor gio_write_resp carries any offset/length/
+	 * sequence identifier, so a late response cannot be distinguished from
+	 * the response to whichever transaction is pending when it arrives.
+	 * Fixing this would need a per-transaction generation counter/sequence
+	 * number threaded through the request and checked against the response
+	 * before trusting it. However, this has not been implemented at the
+	 * firmware side, so just print an error message and abort the current
+	 * request instead.
+	 */
+	if (!left) {
+		dev_err(pgio->dev,
+			"GIO transaction timed out, response may still be in flight\n");
+		return -ETIMEDOUT;
+	}
+
+	return ret;
+}
+
+static int pmic_glink_gio_write_sync(struct pmic_glink_gio *pgio, u32 addr,
+				     const u8 *data, size_t length)
+{
+	struct gio_write_req *req = &pgio->write_req;
+	int ret;
+
+	if (!data || !length)
+		return -EFAULT;
+
+	if (length > GIO_RW_BUFFER_SIZE) {
+		dev_err(pgio->dev, "Write length %zu exceeds maximum buffer size %d\n",
+			length, GIO_RW_BUFFER_SIZE);
+		return -EINVAL;
+	}
+
+	req->hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_GIO);
+	req->hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP);
+	req->hdr.opcode = cpu_to_le32(GIO_OPCODE_BLOCK_WRITE);
+	req->offset = cpu_to_le32(addr);
+	req->length = cpu_to_le32(length);
+	memcpy(req->data, data, length);
+
+	ret = pmic_glink_gio_prepare_transaction(pgio, GIO_OPCODE_BLOCK_WRITE, NULL, 0);
+	if (ret)
+		return ret;
+
+	ret = pmic_glink_send(pgio->client, req, offsetof(struct gio_write_req, data) + length);
+	if (ret) {
+		dev_err(pgio->dev, "Failed to send GIO write request to 0x%05x: %d\n", addr, ret);
+
+		scoped_guard(spinlock_irqsave, &pgio->lock)
+			pmic_glink_gio_reset_transaction(pgio);
+
+		return ret;
+	}
+
+	ret = pmic_glink_gio_wait_ack(pgio);
+	if (ret)
+		dev_err(pgio->dev, "GIO write to 0x%05x failed: %d\n", addr, ret);
+
+	return ret;
+}
+
+static int pmic_glink_gio_read(struct pmic_gio_device *gio, unsigned int reg,
+			       void *val, size_t val_size)
+{
+	struct pmic_glink_gio *pgio = gio->drvdata;
+	struct gio_read_req req = {};
+	int ret;
+
+	if (!val || !val_size)
+		return -EFAULT;
+
+	if (val_size > GIO_RW_BUFFER_SIZE) {
+		dev_err(pgio->dev, "Read length %zu exceeds maximum buffer size %d\n",
+			val_size, GIO_RW_BUFFER_SIZE);
+		return -EINVAL;
+	}
+
+	req.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_GIO);
+	req.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP);
+	req.hdr.opcode = cpu_to_le32(GIO_OPCODE_BLOCK_READ);
+	req.offset = cpu_to_le32(reg);
+	req.length = cpu_to_le32(val_size);
+
+	ret = pmic_glink_gio_prepare_transaction(pgio, GIO_OPCODE_BLOCK_READ, val, val_size);
+	if (ret)
+		return ret;
+
+	ret = pmic_glink_send(pgio->client, &req, sizeof(req));
+	if (ret) {
+		dev_err(pgio->dev, "Failed to send GIO read request to 0x%05x: %d\n", reg, ret);
+
+		scoped_guard(spinlock_irqsave, &pgio->lock) {
+			pmic_glink_gio_reset_transaction(pgio);
+		}
+
+		return ret;
+	}
+
+	ret = pmic_glink_gio_wait_ack(pgio);
+	if (ret)
+		dev_err(pgio->dev, "GIO read from 0x%05x failed: %d\n", reg, ret);
+
+	return ret;
+}
+
+static int pmic_glink_gio_write(struct pmic_gio_device *gio, unsigned int reg,
+				const void *val, size_t val_size)
+{
+	struct pmic_glink_gio *pgio = gio->drvdata;
+
+	return pmic_glink_gio_write_sync(pgio, reg, val, val_size);
+}
+
+static bool pmic_glink_gio_handle_alert(struct pmic_gio_device *gio,
+					u8 peripheral_id, u8 alert_id,
+					const void *payload)
+{
+	dev_dbg(gio->dev,
+		"GIO alert: peripheral_id=0x%02x alert_id=0x%02x payload=%*ph\n",
+		peripheral_id, alert_id, PMIC_GIO_ALERT_PAYLOAD_SIZE, payload);
+
+	return false;
+}
+
+static const struct pmic_gio_device_ops pmic_glink_gio_ops = {
+	.read = pmic_glink_gio_read,
+	.write = pmic_glink_gio_write,
+	.handle_alert = pmic_glink_gio_handle_alert,
+};
+
+static void pmic_glink_gio_pdr_notify(void *priv, int state)
+{
+	struct pmic_glink_gio *pgio = priv;
+	bool service_up;
+
+	service_up = state == SERVREG_SERVICE_STATE_UP;
+
+	scoped_guard(spinlock_irqsave, &pgio->lock) {
+		if (pgio->removing)
+			return;
+
+		WRITE_ONCE(pgio->service_up, service_up);
+		if (!service_up && pgio->pending) {
+			pgio->ack_error = -ENETRESET;
+			pmic_glink_gio_complete_transaction(pgio);
+		}
+
+		if (!service_up)
+			pmic_gio_set_state(pgio->gio, PMIC_GIO_STATE_DOWN);
+	}
+
+	if (service_up)
+		queue_work(pgio->wq, &pgio->init_work);
+}
+
+static void pmic_glink_gio_init_work(struct work_struct *work)
+{
+	struct pmic_glink_gio *pgio = container_of(work, struct pmic_glink_gio, init_work);
+
+	if (!READ_ONCE(pgio->service_up))
+		return;
+
+	scoped_guard(spinlock_irqsave, &pgio->lock) {
+		if (pgio->removing || !pgio->service_up)
+			return;
+
+		pmic_gio_set_state(pgio->gio, PMIC_GIO_STATE_UP);
+	}
+}
+
+static void pmic_glink_gio_alert_work(struct work_struct *work)
+{
+	struct gio_alert_work *alert_work = container_of(work, struct gio_alert_work, work);
+
+	pmic_gio_handle_alert(alert_work->pgio->gio, alert_work->peripheral_id,
+			      alert_work->alert_id, alert_work->payload);
+	atomic_dec(&alert_work->pgio->alert_pending);
+	kfree(alert_work);
+}
+
+static void pmic_glink_gio_callback(const void *data, size_t len, void *priv)
+{
+	const struct pmic_glink_hdr *hdr = data;
+	const struct gio_alert_msg *alert_msg;
+	const struct gio_write_resp *tx_resp;
+	const struct gio_read_resp *rx_resp;
+	struct pmic_glink_gio *pgio = priv;
+	size_t copy_size;
+	u16 opcode;
+
+	if (!data || len < sizeof(*hdr)) {
+		dev_warn(pgio->dev, "Invalid packet received (len: %zu)\n", len);
+		return;
+	}
+
+	opcode = FIELD_GET(GIO_OPCODE_MASK, le32_to_cpu(hdr->opcode));
+
+	switch (opcode) {
+	case GIO_OPCODE_BLOCK_READ:
+		if (len != sizeof(struct gio_read_resp)) {
+			dev_warn(pgio->dev, "Invalid read response message, length: %zu\n", len);
+			return;
+		}
+
+		rx_resp = data;
+
+		scoped_guard(spinlock_irqsave, &pgio->lock) {
+			if (!pgio->pending || pgio->pending_opcode != GIO_OPCODE_BLOCK_READ) {
+				dev_warn(pgio->dev, "Unexpected GIO read response, dropping\n");
+				return;
+			}
+
+			if (le32_to_cpu(rx_resp->ret_code) != 0) {
+				pgio->ack_error = -EREMOTEIO;
+				dev_warn(pgio->dev, "GIO read response failed (%u)\n",
+					 le32_to_cpu(rx_resp->ret_code));
+			} else if (pgio->buf) {
+				copy_size = min_t(size_t, pgio->buf_size, GIO_RW_BUFFER_SIZE);
+				memcpy(pgio->buf, rx_resp->data, copy_size);
+			}
+			pmic_glink_gio_complete_transaction(pgio);
+		}
+		break;
+
+	case GIO_OPCODE_BLOCK_WRITE:
+		if (len != sizeof(struct gio_write_resp)) {
+			dev_warn(pgio->dev, "Invalid write response message, length: %zu\n", len);
+			return;
+		}
+
+		tx_resp = data;
+
+		scoped_guard(spinlock_irqsave, &pgio->lock) {
+			if (!pgio->pending || pgio->pending_opcode != GIO_OPCODE_BLOCK_WRITE) {
+				dev_warn(pgio->dev, "Unexpected GIO write response, dropping\n");
+				return;
+			}
+
+			if (le32_to_cpu(tx_resp->ret_code) != 0) {
+				pgio->ack_error = -EREMOTEIO;
+				dev_warn(pgio->dev, "GIO write response failed (%u)\n",
+					 le32_to_cpu(tx_resp->ret_code));
+			}
+			pmic_glink_gio_complete_transaction(pgio);
+		}
+		break;
+
+	case GIO_OPCODE_ALERT_IND:
+		if (len != sizeof(struct gio_alert_msg)) {
+			dev_warn(pgio->dev, "Invalid alert message, length: %zu\n", len);
+			return;
+		}
+
+		if (atomic_read(&pgio->alert_pending) >= GIO_ALERT_MAX_PENDING) {
+			dev_warn_ratelimited(pgio->dev,
+					     "Too many pending GIO alerts, dropping\n");
+			return;
+		}
+
+		struct gio_alert_work *alert_work __free(kfree) =
+				kmalloc_obj(*alert_work, GFP_ATOMIC);
+		if (!alert_work)
+			return;
+
+		alert_msg = data;
+
+		INIT_WORK(&alert_work->work, pmic_glink_gio_alert_work);
+		alert_work->pgio = pgio;
+		alert_work->peripheral_id = alert_msg->alt_data.info.peripheral_id;
+		alert_work->alert_id = alert_msg->alt_data.info.alert_id;
+		memcpy(alert_work->payload,
+		       alert_msg->alt_data.payload,
+		       PMIC_GIO_ALERT_PAYLOAD_SIZE);
+
+		scoped_guard(spinlock_irqsave, &pgio->lock) {
+			if (pgio->removing || !pgio->service_up)
+				return;
+
+			atomic_inc(&pgio->alert_pending);
+			if (queue_work(pgio->wq, &alert_work->work))
+				retain_and_null_ptr(alert_work);
+			else
+				atomic_dec(&pgio->alert_pending);
+		}
+		break;
+	}
+}
+
+static void pmic_glink_gio_destroy_wq(void *data)
+{
+	struct workqueue_struct *wq = data;
+
+	destroy_workqueue(wq);
+}
+
+static int pmic_glink_gio_probe(struct auxiliary_device *adev,
+				const struct auxiliary_device_id *id)
+{
+	struct pmic_glink_gio *pgio;
+	struct device *dev = &adev->dev;
+	int ret;
+
+	pgio = devm_kzalloc(dev, sizeof(*pgio), GFP_KERNEL);
+	if (!pgio)
+		return -ENOMEM;
+
+	pgio->dev = dev;
+	spin_lock_init(&pgio->lock);
+	init_completion(&pgio->ack);
+	INIT_WORK(&pgio->init_work, pmic_glink_gio_init_work);
+	dev_set_drvdata(dev, pgio);
+
+	pgio->client = devm_pmic_glink_client_alloc(dev, PMIC_GLINK_OWNER_GIO,
+						    pmic_glink_gio_callback,
+						    pmic_glink_gio_pdr_notify,
+						    pgio);
+	if (IS_ERR(pgio->client))
+		return PTR_ERR(pgio->client);
+
+	pgio->gio = devm_pmic_gio_register(dev, &pmic_glink_gio_ops, pgio);
+	if (IS_ERR(pgio->gio))
+		return dev_err_probe(dev, PTR_ERR(pgio->gio), "failed to register GIO device\n");
+
+	pgio->wq = alloc_ordered_workqueue("pmic_glink_gio", 0);
+	if (!pgio->wq)
+		return -ENOMEM;
+
+	ret = devm_add_action_or_reset(dev, pmic_glink_gio_destroy_wq, pgio->wq);
+	if (ret)
+		return ret;
+
+	pmic_glink_client_register(pgio->client);
+
+	return 0;
+}
+
+static void pmic_glink_gio_remove(struct auxiliary_device *adev)
+{
+	struct pmic_glink_gio *pgio = dev_get_drvdata(&adev->dev);
+
+	scoped_guard(spinlock_irqsave, &pgio->lock) {
+		pgio->removing = true;
+		WRITE_ONCE(pgio->service_up, false);
+		if (pgio->pending) {
+			pgio->ack_error = -ENODEV;
+			pmic_glink_gio_complete_transaction(pgio);
+		}
+		pmic_gio_set_state(pgio->gio, PMIC_GIO_STATE_DOWN);
+	}
+
+	cancel_work_sync(&pgio->init_work);
+	flush_workqueue(pgio->wq);
+}
+
+static const struct auxiliary_device_id pmic_glink_gio_id_table[] = {
+	{ .name = "pmic_glink.gio", },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, pmic_glink_gio_id_table);
+
+static struct auxiliary_driver pmic_glink_gio_driver = {
+	.name = "pmic_glink_gio",
+	.probe = pmic_glink_gio_probe,
+	.remove = pmic_glink_gio_remove,
+	.id_table = pmic_glink_gio_id_table,
+};
+
+module_auxiliary_driver(pmic_glink_gio_driver);
+
+MODULE_DESCRIPTION("Qualcomm PMIC GLINK GIO driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/qcom/pmic_glink.h b/include/linux/soc/qcom/pmic_glink.h
index 7cddf1027752..6283495a2396 100644
--- a/include/linux/soc/qcom/pmic_glink.h
+++ b/include/linux/soc/qcom/pmic_glink.h
@@ -11,6 +11,7 @@ struct pmic_glink_client;
 #define PMIC_GLINK_OWNER_BATTMGR	32778
 #define PMIC_GLINK_OWNER_USBC		32779
 #define PMIC_GLINK_OWNER_USBC_PAN	32780
+#define PMIC_GLINK_OWNER_GIO		32785
 
 #define PMIC_GLINK_REQ_RESP		1
 #define PMIC_GLINK_NOTIFY		2

-- 
2.43.0

