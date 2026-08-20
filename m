Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47747D461
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244573; cv=none; b=p6DBilgFbq15BtJKI7r3yPVKoHeVzfZ//u1xbPlOxzhm9VNzUFkyEoJxT0boEAbLiG39LWYDEvvED0LZC6ag8T3J1uZQmefhCHihy3Abj3/ftjh4Bu9foex0FerYwOX19aiV7khTf+9hSF/GRoF8idihH591IDtPjn76QYK22Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244573; c=relaxed/simple;
	bh=h4CTY+d9wEtomhKJCnr8biLp5+RUII7D1e7j+ve1TlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBqARSMo6S+zUGEj4HEMaxAdvOygBV4x0zdcITgItU3eviiKu43rJadt83WmEVBjVsuk2qk9lC4P2g9Cm7tCXTrMi5wO8M4nDnt+Q6OByT/6cG/Nm+chlEDyVP1X2lUQ7fNNfDwyvI06ejC99l8TbZRBDb7D6nbnRXSpOvyrVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fKBPNyCR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CIc4Y2Gr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fKBPNyCR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CIc4Y2Gr"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KG6oTE3415012
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 16:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6EECnriWX5YW5pZTkr75zc0m
	wwB/aeSRu/+86vpiqtY=; b=fKBPNyCRrHPAxjttRM8MzNmsKMLqzckJZH64N64H
	N0rLN9pXsDqIf1U3vDoHpFz32uSE24KtD2dwkKv6rk2fBKUBfrowB0RWuLJnMoJD
	Uqsx1oQUf6Wz0HYz6dIJpZvdM5DagAwNjVKgqG0jicr3ExqqzaXKyckKso9ycN1P
	mUr30wxEWmSF3YdvMVSknJXEkrHbDvu5/zqW9dCJlY+DlppjxreC6yOdAOMy26Jr
	EchpaYJ1m+JAoDL8hXpOxaqra/dhossS5QUgoAnPWXwLwSf+2uCwp9O6+7kVBmzf
	6piKSq+Quuc5oPMBPCeia/e5GqGNCCmekPt81t6OePeiAA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7thct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 16:49:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so19787835ad.1
        for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787244568; x=1787849368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6EECnriWX5YW5pZTkr75zc0mwwB/aeSRu/+86vpiqtY=;
        b=CIc4Y2Grbuvn/MaT25ixGNkmpWxVXuipFAh/dw62NPEd1G7KLufVFclXvb3xHUQSk0
         L6sS8ogaBYCZeyMIsAPcRm+L8RtNPvcmFAGsY/CtAfDSO02jI08JMCmjPWeS/NXSTFnz
         BMX01grTECxc1ECUhbPixI2QXUGfpNASftoLFAyZ/MiogDCgPWfIwcoGKq6YM2mTDxYW
         XDmid/bxDFs4EoOdUC3iVahVCI4pXRp2o58bxvzyWfAn8+MyiU7vbS2aaAHwCpnJaLYI
         o7R5DSe6TZqYElPivE7Gkk9Ih8xYkxMM0RgHNoszpRsOzxR9vVyZKhWKRGf0JkbNeDIT
         YJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244568; x=1787849368;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EECnriWX5YW5pZTkr75zc0mwwB/aeSRu/+86vpiqtY=;
        b=DK/HEBQz83NxD0YvgorU+qKddiYsL3lFdbk4oJOVk+bLKdZl8wa+VQk36ynnaxIsm/
         SXk+ynIVPt0JKVs5CjWdpjcv0RwSvmLLMVu5rGhxEzLx0H7kAEGmpRvjgz2fOm9KO8pq
         X9kiModc25DndpCHL/5wS6qFxdX9rfD1nN0CLEwlIG5lDNJ7Eegb/Py2LbiztVWNSqoH
         zl37THjzq2IFit0JX1Kp+cG1ck4+Ahka507QoaFbNeT3A4U3OZFz/3Imdqk9leRvNd5+
         hoW/TZdy2HCQ3NUizFYWcqrwG/Ms404Xw3iJweyteOHOibv7DtXaeq3xz2O0Ued5VFeF
         /vow==
X-Forwarded-Encrypted: i=1; AHgh+RogV9H8XPgr37/hceQJKJ4+uaNPgOtE7360RbTgRQE6UEnG9p47WGMIaMHhCLQvB6qs6pUWVg1DelM=@vger.kernel.org
X-Gm-Message-State: AFuF++m92FXuq73ig1Qoe/lbdWrxuCeAW9T/9kHXkWNmXe3ns2BwC5bU
	+BzCNScKAHjt/Q+rXZSPGNeOWgXzQgXdoxvY6Cl3oAeFKDuiSR/OiOJ7cXnAIKDRIweK0HP3cA1
	5/M0PpsFK3MNcczOVH14jelxZvsHb5csvW2VgB8ilsQ6FlRK26IGFRkdTZsFxSQw=
X-Gm-Gg: AR+sD12A/QpTc3prKKltet+ichBqUAIO1ZM5zIvqR42SxlUql9PkMikfHahkZTUZeVm
	ZklSnTVFwx72lCnVY20z45w/8NGRnOsb+rKm02NpSV356CioXW1mKGRYGXJ3UePNYqqypUrBtf1
	iF/Rc/kXt1csihsk0rRWNbkyOjtaNakV5LAgT6C+B2VatWyil8likkz9aQ8cnajZvTQLC24YYT9
	ipNWAa9SkxUnJ1L6IFOxwGOMEoOA3LE9fWqVj4KXaKOi/CRzAw3txeCusaipXKwDAH11T9PPziV
	l/oNkIPrCwChE2IkH/zNTWMcEG5OYn7WsZfLHqrXBF/Q6QrAdsBkVF+JHiw7YTLzguWR/jSUZDJ
	deZTGTFTGOdZn6gJ4QTY+tqZjK7Yk3w==
X-Received: by 2002:a17:903:1b27:b0:2cf:8aa7:7810 with SMTP id d9443c01a7336-2d61a03da23mr103161705ad.2.1787244567198;
        Thu, 20 Aug 2026 09:49:27 -0700 (PDT)
X-Received: by 2002:a17:903:1b27:b0:2cf:8aa7:7810 with SMTP id d9443c01a7336-2d61a03da23mr103160885ad.2.1787244566452;
        Thu, 20 Aug 2026 09:49:26 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3c0a7bsm9658045ad.66.2026.08.20.09.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 09:49:25 -0700 (PDT)
Date: Thu, 20 Aug 2026 22:19:20 +0530
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Raj Aryan <raryan@qti.qualcomm.com>
Subject: Re: [PATCH 2/2] rtc: qcom: rtc-glink: Add PMIC GLINK RTC driver and
 extend pmic_glink
Message-ID: <w3yxosn4wvcqcmcmweb4pdi2vsvr5wnh2agwou3anpmxzqvqls@liefdb26jj56>
References: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
 <20260807-rtc-glink-cleanup-v1-2-7801e4d69c4f@oss.qualcomm.com>
 <2026080720584407a4d82d@mail.local>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026080720584407a4d82d@mail.local>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyNyBTYWx0ZWRfX+P+71vCbDuSI
 ixmiFOJYTHnOh1ESypfwGM3czdC86N2F4NEDeKTn+i9uF7zNepmcqola98VWBJZKk9M+IJOf+o8
 JOEIAqNGHoXNbSTQkYnRIxIBoW3h/9ftj7lTzm1M/mzeUZr2Vaf5gzETkbOHzl21lQ8l7tppkvh
 MBVVjls0ICTi5eaZMDAWzwcAu+sephe978kRmuiqXP/f5/uU3U+BjS8hBuIuZHISXbsaINya627
 YJOoiKB8I/U6jURP5CLa67G588tfr5QqEcvz1NWeizKr23senY0CJAzc9Kd4E7edkzKGqmxwhy/
 RmQRdrICBzvGZL7PpfXyTtk9lgWyZS13GZW2xY3lg3bPb0cP9A+LhRUP1xXiWPkNq3m8aMDZnoC
 25VCzlamIKeGALYofkVgAHMWjpwzWJN8NIIg7mzqjsaC5DBDu7s2JG549yDHJaoSPzHZdd5IabT
 2UYE45oJfsTqZ1AoyAA==
X-Proofpoint-ORIG-GUID: HkwFEunoJcQYo3_UutPz4n-gLdbiR5Ps
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a873019 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=WCpGfyg5o2W2mbwI7u8A:9
 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyNyBTYWx0ZWRfX7wyfrETiW8Jd
 e/PWPEf9SJIV3WBa5EvaUGb8/7PGK2QTNKfL8Wn9Ho1n27+awCDSopp/Jzjy178dW9zcKNsgYzy
 kYNBqlm+mEO+c3aIxKI9PQN6l7o7fOk=
X-Proofpoint-GUID: HkwFEunoJcQYo3_UutPz4n-gLdbiR5Ps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200127

On Fri, Aug 07, 2026 at 10:58:44PM +0200, Alexandre Belloni wrote:
> On 07/08/2026 02:26:31+0530, Kamal Wadhwa wrote:
> > Add a new RTC driver that communicates with the PMIC firmware over
> > the GLINK transport layer. The driver supports reading time and
> > alarm functionality via GET_PROPERTY and SET_PROPERTY opcodes.
> > 
> > Time is read via GET_PROPERTY (opcode 0x62) using QCOM_RTC_GLINK_TIME
> > property (0x00). Alarm set and enable are handled via SET_PROPERTY
> > (opcode 0x63) using QCOM_RTC_GLINK_ALARM and QCOM_RTC_GLINK_ALARM_ENABLE
> > properties respectively.
> > 
> > GET_PROPERTY and SET_PROPERTY responses share the same firmware message
> > layout, with the firmware echoing back the property value. Both opcodes
> > are handled by a common callback path accordingly.
> > 
> > Also extend pmic_glink to register the RTC as a PMIC GLINK client and
> > add PMIC GLINK RTC client support for glymur.
> > 
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Raj Aryan <raryan@qti.qualcomm.com>
> > Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > ---
> >  MAINTAINERS                         |   7 +
> >  drivers/rtc/Kconfig                 |  10 +
> >  drivers/rtc/Makefile                |   1 +
> >  drivers/rtc/rtc-qcom-glink.c        | 690 ++++++++++++++++++++++++++++++++++++
> >  drivers/soc/qcom/pmic_glink.c       |  22 +-
> >  include/linux/soc/qcom/pmic_glink.h |   1 +
> >  6 files changed, 730 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5f178a5ff026..752cf667b8ad 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22505,6 +22505,13 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
> >  F:	drivers/power/supply/qcom_smbx.c
> >  
> > +QUALCOMM PMIC GLINK RTC DRIVER
> > +M:	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > +L:	linux-rtc@vger.kernel.org
> > +L:	linux-arm-msm@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/rtc/rtc-qcom-glink.c
> > +
> >  QUALCOMM PPE DRIVER
> >  M:	Luo Jie <jie.luo@oss.qualcomm.com>
> >  L:	netdev@vger.kernel.org
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 01def8231873..3ac39704b2e1 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -1836,6 +1836,16 @@ config RTC_DRV_PM8XXX
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called rtc-pm8xxx.
> >  
> > +config RTC_DRV_QCOM_GLINK
> > +	tristate "Qualcomm PMIC GLINK RTC"
> > +	depends on QCOM_PMIC_GLINK
> > +	help
> > +	  Say Y here to enable support for the RTC exposed by the PMIC
> > +	  over the GLINK transport on Qualcomm platforms.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called rtc-qcom-glink.
> > +
> >  config RTC_DRV_TEGRA
> >  	tristate "NVIDIA Tegra Internal RTC driver"
> >  	depends on ARCH_TEGRA || COMPILE_TEST
> > diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> > index 0347645b021f..8215a1fc29fb 100644
> > --- a/drivers/rtc/Makefile
> > +++ b/drivers/rtc/Makefile
> > @@ -73,6 +73,7 @@ obj-$(CONFIG_RTC_DRV_FM3130)	+= rtc-fm3130.o
> >  obj-$(CONFIG_RTC_DRV_FSL_FTM_ALARM)	+= rtc-fsl-ftm-alarm.o
> >  obj-$(CONFIG_RTC_DRV_FTRTC010)	+= rtc-ftrtc010.o
> >  obj-$(CONFIG_RTC_DRV_GENERIC)	+= rtc-generic.o
> > +obj-$(CONFIG_RTC_DRV_QCOM_GLINK) += rtc-qcom-glink.o
> >  obj-$(CONFIG_RTC_DRV_GOLDFISH)	+= rtc-goldfish.o
> >  obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) += rtc-hid-sensor-time.o
> >  obj-$(CONFIG_RTC_DRV_HYM8563)	+= rtc-hym8563.o
> > diff --git a/drivers/rtc/rtc-qcom-glink.c b/drivers/rtc/rtc-qcom-glink.c
> > new file mode 100644
> > index 000000000000..611f06a3cc5c
> > --- /dev/null
> > +++ b/drivers/rtc/rtc-qcom-glink.c
> > @@ -0,0 +1,690 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/completion.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/property.h>
> > +#include <linux/rtc.h>
> > +#include <linux/slab.h>
> > +#include <linux/soc/qcom/pdr.h>
> > +#include <linux/soc/qcom/pmic_glink.h>
> > +#include <linux/timekeeping.h>
> > +#include <linux/workqueue.h>
> > +
> > +#define RTC_GLINK_SET_PROPERTY		0x63
> > +#define RTC_GLINK_GET_PROPERTY		0x65
> > +#define RTC_GLINK_GET_RTC_TICKS		0x67
> > +#define RTC_GLINK_GET_REAL_TIME		0x68
> > +#define RTC_GLINK_SET_REAL_TIME		0x69
> > +#define RTC_GLINK_ALARM_EXPIRED		0x6A
> > +
> > +enum qcom_rtc_glink_properties {
> > +	QCOM_RTC_GLINK_TIME = 0,
> > +	QCOM_RTC_GLINK_ALARM_TIME,
> > +	QCOM_RTC_GLINK_ALARM_ENABLE,
> > +};
> > +
> > +struct qcom_rtc_glink_msg {
> > +	struct pmic_glink_hdr	hdr;
> > +	__le32			property;
> > +	__le32			value;
> > +};
> > +
> > +struct qcom_rtc_glink_generic_req {
> > +	struct pmic_glink_hdr	hdr;
> > +};
> > +
> > +struct qcom_rtc_glink_status_resp {
> > +	struct pmic_glink_hdr	hdr;
> > +	__le32			return_status;
> > +};
> > +
> > +struct qcom_rtc_glink_ticks_resp {
> > +	struct pmic_glink_hdr	hdr;
> > +	__le32			return_status;
> > +	__le32			rtc_ticks;
> > +};
> > +
> > +struct qcom_rtc_glink_real_time_resp {
> > +	struct pmic_glink_hdr	hdr;
> > +	__le32			return_status;
> > +	__le32			real_time_data[4];
> > +};
> > +
> > +struct qcom_rtc_glink_set_real_time_req {
> > +	struct pmic_glink_hdr	hdr;
> > +	__le32			real_time_data[4];
> > +};
> > +
> > +struct qcom_rtc_glink {
> > +	struct device		*dev;
> > +	struct pmic_glink_client *client;
> > +	struct rtc_device	*rtc;
> > +
> > +	/* Serializes requests: only one may be in flight at a time */
> > +	struct mutex		lock;
> 
> This mutex is useless as all the RTC operations are already serialized.
> Simply rtc_lock/rtc_unlock in qcom_rtc_glink_alarm_work.

Ack. will remove it.

> 
> > +	struct completion	ack;
> > +	struct work_struct	alarm_work;
> > +
> > +	/* Protects service_up and request_pending across callback contexts */
> > +	spinlock_t		state_lock;
> > +	bool			service_up;
> > +	bool			request_pending;
> > +
> > +	int			error;
> > +	u32			resp_value;
> > +	u32			offset;
> > +	struct rtc_time		resp_tm;
> > +	bool			resp_valid;
> > +	bool			allow_set_time;
> > +};
> > +
> > +static int qcom_rtc_glink_request(struct qcom_rtc_glink *rtc_glink,
> > +				  void *data, size_t len)
> > +{
> > +	unsigned long flags;
> > +	unsigned long left;
> > +	int ret;
> > +
> > +	/*
> > +	 * Reinit the completion before request_pending becomes visible to
> > +	 * qcom_rtc_glink_pdr_tify(), so a concurrent SSR down-transition
> > +	 * can't complete() a stale completion that gets wiped out by
> > +	 * reinit_completion() right after.
> > +	 */
> > +	reinit_completion(&rtc_glink->ack);
> > +	rtc_glink->error = 0;
> > +	rtc_glink->resp_valid = false;
> > +
> > +	spin_lock_irqsave(&rtc_glink->state_lock, flags);
> > +	if (!rtc_glink->service_up) {
> > +		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> > +		return -ECONNRESET;
> > +	}
> > +	rtc_glink->request_pending = true;
> > +	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> > +
> > +	ret = pmic_glink_send(rtc_glink->client, data, len);
> > +	if (ret < 0) {
> > +		spin_lock_irqsave(&rtc_glink->state_lock, flags);
> > +		rtc_glink->request_pending = false;
> > +		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> > +		return ret;
> > +	}
> > +
> > +	left = wait_for_completion_timeout(&rtc_glink->ack, HZ);
> > +	spin_lock_irqsave(&rtc_glink->state_lock, flags);
> > +	rtc_glink->request_pending = false;
> > +	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> > +	if (!left)
> > +		return -ETIMEDOUT;
> > +
> > +	return rtc_glink->error;
> > +}
> > +
> > +static int qcom_rtc_glink_set_property(struct qcom_rtc_glink *rtc_glink,
> > +				       u32 property, u32 value)
> > +{
> > +	struct qcom_rtc_glink_msg msg = {
> > +		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC),
> > +		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
> > +		.hdr.opcode = cpu_to_le32(RTC_GLINK_SET_PROPERTY),
> > +		.property = cpu_to_le32(property),
> > +		.value = cpu_to_le32(value),
> > +	};
> > +	int ret;
> > +
> > +	dev_dbg(rtc_glink->dev,
> > +		"TX opcode=0x%x property=%u value=%u\n",
> > +		RTC_GLINK_SET_PROPERTY, property, value);
> > +	mutex_lock(&rtc_glink->lock);
> > +	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
> > +	mutex_unlock(&rtc_glink->lock);
> > +	return ret;
> > +}
> > +
> > +static int qcom_rtc_glink_get_property(struct qcom_rtc_glink *rtc_glink,
> > +				       u32 property, u32 *value)
> > +{
> > +	struct qcom_rtc_glink_msg msg = {
> > +		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC),
> > +		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
> > +		.hdr.opcode = cpu_to_le32(RTC_GLINK_GET_PROPERTY),
> > +		.property = cpu_to_le32(property),
> > +	};
> > +	int ret;
> > +
> > +	dev_dbg(rtc_glink->dev,
> > +		"TX opcode=0x%x property=%u\n",
> > +		RTC_GLINK_GET_PROPERTY, property);
> > +	mutex_lock(&rtc_glink->lock);
> > +	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
> > +	if (!ret) {
> > +		if (!rtc_glink->resp_valid)
> > +			ret = -EIO;
> > +		else
> > +			*value = rtc_glink->resp_value;
> > +	}
> > +	mutex_unlock(&rtc_glink->lock);
> > +	return ret;
> > +}
> > +
> > +static int qcom_rtc_glink_get_ticks(struct qcom_rtc_glink *rtc_glink,
> > +				    u32 *ticks)
> > +{
> > +	struct qcom_rtc_glink_generic_req msg = {
> > +		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC),
> > +		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
> > +		.hdr.opcode = cpu_to_le32(RTC_GLINK_GET_RTC_TICKS),
> > +	};
> > +	int ret;
> > +
> > +	dev_dbg(rtc_glink->dev, "TX opcode=0x%x\n", RTC_GLINK_GET_RTC_TICKS);
> > +	mutex_lock(&rtc_glink->lock);
> > +	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
> > +	if (!ret) {
> > +		if (!rtc_glink->resp_valid)
> > +			ret = -EIO;
> > +		else
> > +			*ticks = rtc_glink->resp_value;
> > +	}
> > +	mutex_unlock(&rtc_glink->lock);
> > +	return ret;
> > +}
> > +
> > +static int qcom_rtc_glink_get_real_time(struct qcom_rtc_glink *rtc_glink,
> > +					struct rtc_time *tm)
> > +{
> > +	struct qcom_rtc_glink_generic_req msg = {
> > +		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC),
> > +		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
> > +		.hdr.opcode = cpu_to_le32(RTC_GLINK_GET_REAL_TIME),
> > +	};
> > +	int ret;
> > +
> > +	dev_dbg(rtc_glink->dev, "TX opcode=0x%x\n", RTC_GLINK_GET_REAL_TIME);
> > +	mutex_lock(&rtc_glink->lock);
> > +	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
> > +	if (!ret) {
> > +		if (!rtc_glink->resp_valid)
> > +			ret = -EIO;
> > +		else
> > +			*tm = rtc_glink->resp_tm;
> > +	}
> > +	mutex_unlock(&rtc_glink->lock);
> > +	return ret;
> > +}
> > +
> > +static int qcom_rtc_glink_set_real_time(struct qcom_rtc_glink *rtc_glink,
> > +					struct rtc_time *tm)
> > +{
> > +	struct qcom_rtc_glink_set_real_time_req msg = {};
> > +	u32 w0, w1;
> > +	int ret;
> > +
> > +	w0 = ((tm->tm_year + 1900) & 0xffff) |
> > +	     (((tm->tm_mon + 1) & 0xff) << 16) |
> > +	     ((tm->tm_mday & 0xff) << 24);
> > +	w1 = (tm->tm_hour & 0xff) |
> > +	     ((tm->tm_min & 0xff) << 8) |
> > +	     ((tm->tm_sec & 0xff) << 16) |
> > +	     (1U << 24);
> > +	msg.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC);
> > +	msg.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP);
> > +	msg.hdr.opcode = cpu_to_le32(RTC_GLINK_SET_REAL_TIME);
> > +	msg.real_time_data[0] = cpu_to_le32(w0);
> > +	msg.real_time_data[1] = cpu_to_le32(w1);
> > +	msg.real_time_data[2] = 0;
> > +	msg.real_time_data[3] = 0;
> > +	dev_dbg(rtc_glink->dev,
> > +		"TX opcode=0x%x data=%08x %08x\n",
> > +		RTC_GLINK_SET_REAL_TIME, w0, w1);
> > +	mutex_lock(&rtc_glink->lock);
> > +	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
> > +	mutex_unlock(&rtc_glink->lock);
> > +	return ret;
> > +}
> > +
> > +static int qcom_rtc_glink_get_time(struct qcom_rtc_glink *rtc_glink,
> > +				   struct rtc_time *time)
> > +{
> > +	u32 ticks;
> > +	int ret;
> > +
> > +	ret = qcom_rtc_glink_get_real_time(rtc_glink, time);
> > +	if (!ret)
> > +		return 0;
> > +	dev_warn(rtc_glink->dev, "0x68 failed (%d), falling back\n", ret);
> 
> This message is useless, either fail or fallback silently

Ack. will fix in v3

> 
> > +
> > +	ret = qcom_rtc_glink_get_ticks(rtc_glink, &ticks);
> > +	if (!ret) {
> > +		rtc_time64_to_tm((time64_t)ticks + rtc_glink->offset, time);
> > +		return 0;
> > +	}
> > +
> > +	ret = qcom_rtc_glink_get_property(rtc_glink, QCOM_RTC_GLINK_TIME,
> > +					  &ticks);
> > +	if (!ret && ticks != U32_MAX) {
> > +		rtc_time64_to_tm((time64_t)ticks + rtc_glink->offset, time);
> > +		return 0;
> > +	}
> > +
> > +	dev_err(rtc_glink->dev, "all time sources failed\n");
> 
> Ditto

Ack. will fix in v3

> 
> > +	return -EIO;
> > +}
> > +
> > +static int qcom_rtc_glink_set_time(struct qcom_rtc_glink *rtc_glink,
> > +				   struct rtc_time *time)
> > +{
> > +	time64_t t = rtc_tm_to_time64(time);
> > +	u32 ticks;
> > +	int ret;
> > +
> > +	if (!rtc_glink->allow_set_time)
> > +		return -EOPNOTSUPP;
> > +
> > +	ret = qcom_rtc_glink_set_real_time(rtc_glink, time);
> > +	if (ret)
> > +		dev_warn(rtc_glink->dev, "0x69 failed (%d)\n", ret);
> 
> Ditto
> 

Ack. will fix in v3

> > +
> > +	ret = qcom_rtc_glink_set_property(rtc_glink, QCOM_RTC_GLINK_TIME, (u32)t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = qcom_rtc_glink_get_ticks(rtc_glink, &ticks);
> > +	if (!ret && ticks != U32_MAX) {
> > +		rtc_glink->offset = (u32)t - ticks;
> > +	} else {
> > +		dev_warn(rtc_glink->dev, "no tick source for offset\n");
> 
> This is also probably useless. No one is going to read those messages or
> do anything about them.

Ack. will fix in v3

> 
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int qcom_rtc_glink_set_alarm_en(struct qcom_rtc_glink *rtc_glink,
> > +				       int enabled)
> > +{
> > +	return qcom_rtc_glink_set_property(rtc_glink,
> > +					   QCOM_RTC_GLINK_ALARM_ENABLE,
> > +					   enabled);
> > +}
> > +
> > +static int qcom_rtc_glink_set_alarm(struct qcom_rtc_glink *rtc_glink,
> > +				    struct rtc_wkalrm *alarm)
> > +{
> > +	time64_t alarm_t = rtc_tm_to_time64(&alarm->time);
> > +	struct rtc_time now_tm;
> > +	time64_t now_real, secs_until_alarm;
> > +	u32 fw_current, fw_alarm;
> > +	int ret;
> > +
> > +	ret = qcom_rtc_glink_get_time(rtc_glink, &now_tm);
> > +	if (ret)
> > +		return ret;
> > +	now_real = rtc_tm_to_time64(&now_tm);
> > +	secs_until_alarm = alarm_t - now_real;
> > +	dev_dbg(rtc_glink->dev,
> > +		"set_alarm: now_real=%lld alarm_t=%lld delta=%lld\n",
> > +		now_real, alarm_t, secs_until_alarm);
> > +	if (secs_until_alarm < 0)
> > +		return -EINVAL;
> > +	if (secs_until_alarm > U32_MAX)
> > +		return -ERANGE;
> > +
> > +	ret = qcom_rtc_glink_get_property(rtc_glink, QCOM_RTC_GLINK_TIME,
> > +					  &fw_current);
> > +	if (ret)
> > +		return ret;
> > +	if (fw_current == U32_MAX)
> > +		fw_current = 0;
> > +	fw_alarm = fw_current + (u32)secs_until_alarm;
> > +	dev_dbg(rtc_glink->dev,
> > +		"set_alarm: fw_current=%u fw_alarm=%u\n",
> > +		fw_current, fw_alarm);
> > +
> > +	ret = qcom_rtc_glink_set_alarm_en(rtc_glink, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = qcom_rtc_glink_set_property(rtc_glink,
> > +					  QCOM_RTC_GLINK_ALARM_TIME, fw_alarm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return qcom_rtc_glink_set_alarm_en(rtc_glink, alarm->enabled);
> > +}
> > +
> > +static int qcom_rtc_glink_get_alarm(struct qcom_rtc_glink *rtc_glink,
> > +				    struct rtc_wkalrm *alarm)
> > +{
> > +	u32 fw_alarm_time, fw_current, alarm_en;
> > +	struct rtc_time now_tm;
> > +	time64_t now_real, secs_until_alarm, alarm_real;
> > +	int ret;
> > +
> > +	ret = qcom_rtc_glink_get_property(rtc_glink,
> > +					  QCOM_RTC_GLINK_ALARM_TIME,
> > +					  &fw_alarm_time);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = qcom_rtc_glink_get_property(rtc_glink, QCOM_RTC_GLINK_TIME,
> > +					  &fw_current);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = qcom_rtc_glink_get_property(rtc_glink,
> > +					  QCOM_RTC_GLINK_ALARM_ENABLE,
> > +					  &alarm_en);
> > +	if (ret)
> > +		return ret;
> > +	if (fw_current == U32_MAX)
> > +		fw_current = 0;
> > +
> > +	ret = qcom_rtc_glink_get_time(rtc_glink, &now_tm);
> > +	if (ret)
> > +		return ret;
> > +	now_real = rtc_tm_to_time64(&now_tm);
> > +	secs_until_alarm = (time64_t)fw_alarm_time - (time64_t)fw_current;
> > +	alarm_real = now_real + secs_until_alarm;
> > +	dev_dbg(rtc_glink->dev,
> > +		"get_alarm: now_real=%lld fw_current=%u fw_alarm=%u delta=%lld\n",
> > +		now_real, fw_current, fw_alarm_time, secs_until_alarm);
> > +	rtc_time64_to_tm(alarm_real, &alarm->time);
> > +	alarm->enabled = !!alarm_en;
> > +	return 0;
> > +}
> > +
> > +static void qcom_rtc_glink_alarm_work(struct work_struct *work)
> > +{
> > +	struct qcom_rtc_glink *rtc_glink =
> > +		container_of(work, struct qcom_rtc_glink, alarm_work);
> > +	int ret;
> > +
> > +	ret = qcom_rtc_glink_set_alarm_en(rtc_glink, 0);
> > +	if (ret)
> > +		dev_err(rtc_glink->dev,
> > +			"failed to disable alarm after expiry (%d)\n", ret);
> 
> So what is the user supposed to do with this message? Also, do you
> actually have to disable the alarm? I guess it is not going to fire again.

it seems less likely that it will fire again, it just seemed safe to disable it
before sending the RTC irq. but fine i will remove the print and also the
disable call.

> 
> > +	rtc_update_irq(rtc_glink->rtc, 1, RTC_IRQF | RTC_AF);
> > +}
> > +
> > +static void qcom_rtc_glink_callback(const void *data, size_t len, void *priv)
> > +{
> > +	struct qcom_rtc_glink *rtc_glink = priv;
> > +	const struct pmic_glink_hdr *hdr = data;
> > +	unsigned long flags;
> > +	bool pending;
> > +
> > +	if (len < sizeof(*hdr))
> > +		return;
> > +
> > +	dev_dbg(rtc_glink->dev,
> > +		"RX opcode=0x%x type=0x%x owner=0x%x len=%zu\n",
> > +		le32_to_cpu(hdr->opcode), le32_to_cpu(hdr->type),
> > +		le32_to_cpu(hdr->owner), len);
> > +
> > +	if (le32_to_cpu(hdr->opcode) == RTC_GLINK_ALARM_EXPIRED) {
> > +		dev_info(rtc_glink->dev, "alarm expired\n");
> 
> This is just noise

Ack. will fix in v3
> 
> > +		schedule_work(&rtc_glink->alarm_work);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Hold state_lock across the pending check and the response fields
> > +	 * below: qcom_rtc_glink_pdr_notify() writes the same error/resp_*
> > +	 * fields under this lock when it force-completes a request on an
> > +	 * SSR down-transition, and the two must not race. Dropping the
> > +	 * response here if !pending also covers requests that already
> > +	 * timed out or were aborted; qcom_rtc_glink_request() will call
> > +	 * reinit_completion() again before this response could be mistaken
> > +	 * for a later request's.
> > +	 */
> > +	spin_lock_irqsave(&rtc_glink->state_lock, flags);
> > +	pending = rtc_glink->request_pending;
> > +
> > +	if (!pending) {
> > +		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> > +		dev_dbg(rtc_glink->dev,
> > +			"dropping stale response opcode=0x%x\n",
> > +			le32_to_cpu(hdr->opcode));
> > +		return;
> > +	}
> > +
> > +	switch (le32_to_cpu(hdr->opcode)) {
> > +	case RTC_GLINK_GET_PROPERTY:
> > +		fallthrough;
> > +	case RTC_GLINK_SET_PROPERTY: {
> > +		const struct qcom_rtc_glink_msg *msg = data;
> > +
> > +		if (len < sizeof(struct pmic_glink_hdr) + sizeof(__le32)) {
> > +			rtc_glink->error = -EINVAL;
> > +			break;
> > +		}
> > +		rtc_glink->resp_value = le32_to_cpu(msg->property);
> > +		rtc_glink->resp_valid = true;
> > +		rtc_glink->error = 0;
> > +		dev_dbg(rtc_glink->dev, "ACK opcode=0x%x resp_value=%u\n",
> > +			le32_to_cpu(hdr->opcode), rtc_glink->resp_value);
> > +		break;
> > +	}
> > +
> > +	case RTC_GLINK_GET_RTC_TICKS: {
> > +		const struct qcom_rtc_glink_ticks_resp *resp = data;
> > +
> > +		if (len < sizeof(*resp)) {
> > +			rtc_glink->error = -EINVAL;
> > +			break;
> > +		}
> > +		if (le32_to_cpu(resp->return_status)) {
> > +			rtc_glink->error = -EIO;
> > +			break;
> > +		}
> > +		rtc_glink->resp_value = le32_to_cpu(resp->rtc_ticks);
> > +		rtc_glink->resp_valid = true;
> > +		rtc_glink->error = 0;
> > +		dev_dbg(rtc_glink->dev, "ACK opcode=0x%x ticks=%u\n",
> > +			RTC_GLINK_GET_RTC_TICKS, rtc_glink->resp_value);
> > +		break;
> > +	}
> > +
> > +	case RTC_GLINK_GET_REAL_TIME: {
> > +		const struct qcom_rtc_glink_real_time_resp *resp = data;
> > +		u32 w0, w1;
> > +
> > +		if (len < sizeof(*resp)) {
> > +			rtc_glink->error = -EINVAL;
> > +			break;
> > +		}
> > +		if (le32_to_cpu(resp->return_status)) {
> > +			rtc_glink->error = -EIO;
> > +			break;
> > +		}
> > +		w0 = le32_to_cpu(resp->real_time_data[0]);
> > +		w1 = le32_to_cpu(resp->real_time_data[1]);
> > +		rtc_glink->resp_tm.tm_year = (w0 & 0xffff) - 1900;
> > +		rtc_glink->resp_tm.tm_mon = ((w0 >> 16) & 0xff) - 1;
> > +		rtc_glink->resp_tm.tm_mday = (w0 >> 24) & 0xff;
> > +		rtc_glink->resp_tm.tm_hour = w1 & 0xff;
> > +		rtc_glink->resp_tm.tm_min = (w1 >> 8) & 0xff;
> > +		rtc_glink->resp_tm.tm_sec = (w1 >> 16) & 0xff;
> > +		rtc_glink->resp_valid = true;
> > +		rtc_glink->error = 0;
> > +		dev_dbg(rtc_glink->dev,
> > +			"ACK opcode=0x%x %04d-%02d-%02d %02d:%02d:%02d\n",
> > +			RTC_GLINK_GET_REAL_TIME,
> > +			rtc_glink->resp_tm.tm_year + 1900,
> > +			rtc_glink->resp_tm.tm_mon + 1,
> > +			rtc_glink->resp_tm.tm_mday,
> > +			rtc_glink->resp_tm.tm_hour,
> > +			rtc_glink->resp_tm.tm_min,
> > +			rtc_glink->resp_tm.tm_sec);
> > +		break;
> > +	}
> > +
> > +	case RTC_GLINK_SET_REAL_TIME: {
> > +		const struct qcom_rtc_glink_status_resp *resp = data;
> > +
> > +		if (len < sizeof(*resp)) {
> > +			rtc_glink->error = -EINVAL;
> > +			break;
> > +		}
> > +		rtc_glink->error = le32_to_cpu(resp->return_status) ? -EIO : 0;
> > +		dev_dbg(rtc_glink->dev, "ACK opcode=0x%x status=%u\n",
> > +			RTC_GLINK_SET_REAL_TIME,
> > +			le32_to_cpu(resp->return_status));
> > +		break;
> > +	}
> > +
> > +	default:
> > +		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> > +		dev_warn(rtc_glink->dev,
> > +			 "unhandled RX opcode=0x%x len=%zu\n",
> > +			 le32_to_cpu(hdr->opcode), len);
> 
> Useless message

Ack. will fix in v3

> 
> > +		return;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> > +	complete(&rtc_glink->ack);
> > +}
> > +
> > +static void qcom_rtc_glink_pdr_notify(void *priv, int state)
> > +{
> > +	struct qcom_rtc_glink *rtc_glink = priv;
> > +	unsigned long flags;
> > +	bool up = (state == SERVREG_SERVICE_STATE_UP);
> > +
> > +	spin_lock_irqsave(&rtc_glink->state_lock, flags);
> > +	rtc_glink->service_up = up;
> > +	if (!up && rtc_glink->request_pending) {
> > +		rtc_glink->error = -ECONNRESET;
> > +		rtc_glink->resp_valid = false;
> > +		complete(&rtc_glink->ack);
> > +	}
> > +	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> > +}
> > +
> > +static int qcom_rtc_glink_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	return qcom_rtc_glink_get_time(dev_get_drvdata(dev), tm);
> > +}
> > +
> > +static int qcom_rtc_glink_set_time_dev(struct device *dev, struct rtc_time *tm)
> > +{
> > +	return qcom_rtc_glink_set_time(dev_get_drvdata(dev), tm);
> > +}
> > +
> > +static int qcom_rtc_glink_read_alarm(struct device *dev,
> > +				     struct rtc_wkalrm *alrm)
> > +{
> > +	return qcom_rtc_glink_get_alarm(dev_get_drvdata(dev), alrm);
> > +}
> > +
> > +static int qcom_rtc_glink_set_alarm_dev(struct device *dev,
> > +					struct rtc_wkalrm *alrm)
> > +{
> > +	return qcom_rtc_glink_set_alarm(dev_get_drvdata(dev), alrm);
> > +}
> > +
> > +static int qcom_rtc_glink_alarm_irq_enable(struct device *dev,
> > +					   unsigned int enabled)
> > +{
> > +	return qcom_rtc_glink_set_alarm_en(dev_get_drvdata(dev), enabled);
> > +}
> > +
> > +static const struct rtc_class_ops qcom_rtc_glink_rtc_ops = {
> > +	.read_time = qcom_rtc_glink_read_time,
> > +	.set_time = qcom_rtc_glink_set_time_dev,
> > +	.read_alarm = qcom_rtc_glink_read_alarm,
> > +	.set_alarm = qcom_rtc_glink_set_alarm_dev,
> > +	.alarm_irq_enable = qcom_rtc_glink_alarm_irq_enable,
> > +};
> > +
> > +static const struct of_device_id qcom_rtc_glink_of_variants[] = {
> > +	{ .compatible = "qcom,glymur-pmic-glink" },
> > +	{}
> > +};
> > +
> > +static int qcom_rtc_glink_probe(struct auxiliary_device *adev,
> > +				const struct auxiliary_device_id *id)
> > +{
> > +	struct device *dev = &adev->dev;
> > +	struct qcom_rtc_glink *rtc_glink;
> > +
> > +	if (!of_match_device(qcom_rtc_glink_of_variants, dev->parent))
> > +		return -ENXIO;
> > +
> > +	rtc_glink = devm_kzalloc(dev, sizeof(*rtc_glink), GFP_KERNEL);
> > +	if (!rtc_glink)
> > +		return -ENOMEM;
> > +
> > +	rtc_glink->dev            = dev;
> > +	rtc_glink->allow_set_time = device_property_read_bool(dev->parent,
> > +							      "allow-set-time");
> > +
> > +	mutex_init(&rtc_glink->lock);
> > +	spin_lock_init(&rtc_glink->state_lock);
> > +	init_completion(&rtc_glink->ack);
> > +	INIT_WORK(&rtc_glink->alarm_work, qcom_rtc_glink_alarm_work);
> > +	dev_set_drvdata(dev, rtc_glink);
> > +
> > +	rtc_glink->client = devm_pmic_glink_client_alloc(dev,
> > +							 PMIC_GLINK_OWNER_RTC,
> > +							 qcom_rtc_glink_callback,
> > +							 qcom_rtc_glink_pdr_notify,
> > +							 rtc_glink);
> > +	if (IS_ERR(rtc_glink->client))
> > +		return dev_err_probe(dev, PTR_ERR(rtc_glink->client),
> > +				     "failed to allocate glink client\n");
> > +
> > +	pmic_glink_client_register(rtc_glink->client);
> > +
> > +	device_init_wakeup(dev, true);
> > +
> > +	rtc_glink->rtc = devm_rtc_allocate_device(dev);
> > +	if (IS_ERR(rtc_glink->rtc))
> > +		return dev_err_probe(dev, PTR_ERR(rtc_glink->rtc),
> > +				     "failed to allocate RTC device\n");
> > +
> 
> Useless message, there is no failure path without a message in
> devm_rtc_allocate_device.

Ack. will fix in v3

> 
> 
> > +	rtc_glink->rtc->ops      = &qcom_rtc_glink_rtc_ops;
> > +	rtc_glink->rtc->range_min = 0;
> > +	rtc_glink->rtc->range_max = U32_MAX;
> > +
> > +	return devm_rtc_register_device(rtc_glink->rtc);
> > +}
> > +
> > +static void qcom_rtc_glink_remove(struct auxiliary_device *adev)
> > +{
> > +	struct qcom_rtc_glink *rtc_glink = dev_get_drvdata(&adev->dev);
> > +	/*
> > +	 * Nothing left to arm alarm_work after this returns: the glink
> > +	 * client (and its callback/pdr_notify) is torn down by devm after
> > +	 * .remove() returns, and rtc_update_irq() below still targets a
> > +	 * live devm-managed rtc device.
> > +	 */
> > +	cancel_work_sync(&rtc_glink->alarm_work);
> > +}
> > +
> > +static const struct auxiliary_device_id qcom_rtc_glink_id_table[] = {
> > +	{ .name = "pmic_glink.rtc-glink" },
> > +	{}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(auxiliary, qcom_rtc_glink_id_table);
> > +
> > +static struct auxiliary_driver qcom_rtc_glink_driver = {
> > +	.name = "qcom_pmic_rtc_glink",
> > +	.id_table = qcom_rtc_glink_id_table,
> > +	.probe = qcom_rtc_glink_probe,
> > +	.remove = qcom_rtc_glink_remove,
> > +};
> > +
> > +module_auxiliary_driver(qcom_rtc_glink_driver);
> > +MODULE_DESCRIPTION("Qualcomm PMIC GLINK RTC driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> > index 3042261578aa..7ee70a31ba15 100644
> > --- a/drivers/soc/qcom/pmic_glink.c
> > +++ b/drivers/soc/qcom/pmic_glink.c
> > @@ -21,6 +21,7 @@ enum {
> >  	PMIC_GLINK_CLIENT_BATT = 0,
> >  	PMIC_GLINK_CLIENT_ALTMODE,
> >  	PMIC_GLINK_CLIENT_UCSI,
> > +	PMIC_GLINK_CLIENT_RTC,
> >  };
> >  
> >  struct pmic_glink_data {
> > @@ -40,6 +41,7 @@ struct pmic_glink {
> >  	struct auxiliary_device altmode_aux;
> >  	struct auxiliary_device ps_aux;
> >  	struct auxiliary_device ucsi_aux;
> > +	struct auxiliary_device rtc_aux;
> >  
> >  	/* serializing client_state and pdr_state updates */
> >  	struct mutex state_lock;
> > @@ -341,6 +343,12 @@ static int pmic_glink_probe(struct platform_device *pdev)
> >  			goto out_release_altmode_aux;
> >  	}
> >  
> > +	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_RTC)) {
> > +		ret = pmic_glink_add_aux_device(pg, &pg->rtc_aux, "rtc-glink");
> > +		if (ret)
> > +			goto out_release_ps_aux;
> > +	}
> > +
> >  	if (pg->data->charger_pdr_service_name && pg->data->charger_pdr_service_path) {
> >  		service = pdr_add_lookup(pg->pdr, pg->data->charger_pdr_service_name,
> >  					 pg->data->charger_pdr_service_path);
> > @@ -358,6 +366,9 @@ static int pmic_glink_probe(struct platform_device *pdev)
> >  	return 0;
> >  
> >  out_release_aux_devices:
> > +	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_RTC))
> > +		pmic_glink_del_aux_device(pg, &pg->rtc_aux);
> > +out_release_ps_aux:
> >  	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
> >  		pmic_glink_del_aux_device(pg, &pg->ps_aux);
> >  out_release_altmode_aux:
> > @@ -384,11 +395,20 @@ static void pmic_glink_remove(struct platform_device *pdev)
> >  		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
> >  	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
> >  		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
> > +	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_RTC))
> > +		pmic_glink_del_aux_device(pg, &pg->rtc_aux);
> >  
> >  	guard(mutex)(&__pmic_glink_lock);
> >  	__pmic_glink = NULL;
> >  }
> >  
> > +static const struct pmic_glink_data pmic_glink_glymur_data = {
> > +	.client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
> > +		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
> > +		       BIT(PMIC_GLINK_CLIENT_UCSI) |
> > +		       BIT(PMIC_GLINK_CLIENT_RTC),
> > +};
> > +
> >  static const struct pmic_glink_data pmic_glink_adsp_data = {
> >  	.client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
> >  		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
> > @@ -404,7 +424,7 @@ static const struct pmic_glink_data pmic_glink_soccp_data = {
> >  };
> >  
> >  static const struct of_device_id pmic_glink_of_match[] = {
> > -	{ .compatible = "qcom,glymur-pmic-glink", .data = &pmic_glink_soccp_data },
> > +	{ .compatible = "qcom,glymur-pmic-glink", .data = &pmic_glink_glymur_data },
> >  	{ .compatible = "qcom,kaanapali-pmic-glink", .data = &pmic_glink_soccp_data },
> >  	{ .compatible = "qcom,pmic-glink", .data = &pmic_glink_adsp_data },
> >  	{}
> > diff --git a/include/linux/soc/qcom/pmic_glink.h b/include/linux/soc/qcom/pmic_glink.h
> > index 7cddf1027752..11031b06b810 100644
> > --- a/include/linux/soc/qcom/pmic_glink.h
> > +++ b/include/linux/soc/qcom/pmic_glink.h
> > @@ -11,6 +11,7 @@ struct pmic_glink_client;
> >  #define PMIC_GLINK_OWNER_BATTMGR	32778
> >  #define PMIC_GLINK_OWNER_USBC		32779
> >  #define PMIC_GLINK_OWNER_USBC_PAN	32780
> > +#define PMIC_GLINK_OWNER_RTC		32784
> >  
> >  #define PMIC_GLINK_REQ_RESP		1
> >  #define PMIC_GLINK_NOTIFY		2
> > 
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
