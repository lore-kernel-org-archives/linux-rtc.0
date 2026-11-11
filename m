Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367729;
	b=aIupfajuQsxEkoeWUv2/t3A7/wKzUyzaL/XHPXScNHwPGtPZS4zGUQZ/6AxcMcKcY89X
	 oGT6gL9Nvc1DhKh1cVrLD7rEfhuB9q1fz+puo/+KzMymLrU7Zz2hb1CEwX+uPtq9Bibtz
	 kq+LFVoWP6MRxcgSXUY28W75kG7Knd/bfrSu+WMbDxe6niyiD+jYEE4mCZjcwoBi7ghCB
	 YiVjA4hmVsMJ1mOZ2Tn/QjzJGsI1KWLG1ivtGB9SJckhJApEBqOzajoTCqLGOJPLeqwuC
	 Q4j8NuEExHJ8sLqN7c7fSnhvcu3RaMJQaolN7jV34Dp5FbMFe8AzqY4AXbObf/F0FFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367729;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UKubwUnXpSsojNF4c02s5LNmPIOEfy8rKaXdovd5TqI=;
	b=nQjf44uiihFAF3HMcHlmdrZYKPFx4tDWLACNHUqlAMPF43lfVrNmYffsbIj46y8kCMf8
	 ez1Y2/pnV+LY8fJesEQj4Y7EFa0xmbk+W1tW3sZS1nvmpB3ghLgTiGUvZstl+L3tXVV1y
	 X0IbOsFZMzLbeQd8O4/6yt4AGZMkrRHPpcPkr8JPJ26wXtl8TA9PnP5bS8Y5GmDD6Aoe2
	 AbIf3/GXXvAaxVpfG/vpJAxg5KMX0qiNNPx76R7ZuFJBltozKBRBDLkJwm8Eq/iCSO41b
	 j2W2JoIC29oYQOwMli8D9AN6j+iG1qeNLXkx3M6/faO+MVYNvaohQppoKMZ10slDDPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eGjhjeiD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FsPPrihA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D640606A32E
	for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 03:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D640606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eGjhjeiD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FsPPrihA
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB1tZdD923311
	for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 03:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UKubwUnXpSsojNF4c02s5L
	NmPIOEfy8rKaXdovd5TqI=; b=eGjhjeiDqlhEgD0QO0hicpq/voD3ET8egDylRM
	x8bM7rzM/3cD3Ze+I5OPbps+hrouPeT1JDK6ZiqESyK+aWAFUQXb0MPx3Ir+v6Oo
	l3/ZV40XY3bVE2kpvFANsGr9nc3ntaFhbyL/Z8HGqK8Pg2th+Rdu2OfCCRZzNIMH
	CW8DGn5tiKCtYwGUW4FDNSm/60HpcnV0K5h7vEBEoacYbeXt+/U/kMlXyP5H51Gy
	rzw8NakHsY5aLOfWWOmlgGEvLfJoaW2KC/3Me9TFwvANFh9PKZuAOLXd8MYuBW9q
	UqeNXiK360iIB+VOqs5iVYV6gOJ/AaJQq2HeixTRTwnKTqEg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvcpegsjh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 03:28:47 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1af203073e0so3435820c88.1
        for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 19:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794367727; x=1794972527; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UKubwUnXpSsojNF4c02s5LNmPIOEfy8rKaXdovd5TqI=;
        b=FsPPrihAI3teM5TJWavZbHCpbhhTrN39QhtdfYtZ9NUwg9J4fc3s+KEbEx+WMXwFh/
         /1ITQmg90r0c2BtgHDr0EEhpcKmtqFDQwSl5IdoBSiNWFzZ/Gj7vsBRbkoe29v06GP3d
         BBD0nm0rGava/UjWc+Eg4Qoyl4T6yI975N/hkgXpp8zpfV2Eyyn74gxiz2V2LIx5iRlu
         ylkopUa/eI40HnbZYc/qoZatknMD1vn/z2JOkWiPh2+oT1q56Bac/TwR7bBXRiXGH2hD
         zHhfSgWgIE8DiFqFB2pf9P27IjPeQPq+oojjqos4lxto4IkuuTW+l02eyqEgNHls6sPm
         xukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367727; x=1794972527;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UKubwUnXpSsojNF4c02s5LNmPIOEfy8rKaXdovd5TqI=;
        b=e6OYTeOn7AIkQWOsJRITe7+zkjmOVhUEcsBhAMfVykSug1IVR/g9OC2wFM6dvqNkh5
         eUJ6cHGvFDcLUhoCddwklnSX/aKBSoxXOizKsqO1WpM0gR+1MnS6QTVzS0BnGk61sh0k
         goa84GSnr8Wl9PesqfmzNz0ZJbjnwrgXTkq57DMTEhJmoROGaO4kl6uUypEqDOe9ZZr3
         KcSdOHU1Ui7GE9B0taUFHTIx1omKGov4TL9Wansc21l66euJIcb6e7gObhJI8g9CXhId
         F1TkGmN6NSck0DASnhCv7M6Jy0wQVqZzQ78pXEDZNKLTHdDPNii98LJGkiM52FQltHgU
         jTGw==
X-Forwarded-Encrypted: i=1; AL+hErGFzfVxVf2rStc3XR+lgn9X/d1z/KBBSP40dT2n++sTC479yhcUcb4IVCKoaKZb7NBAWDfIu1D+Yyk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8osb//WRoZrrNZ9VmIkXPFX28RrOWryjpb3Fpv0Glk925Kk7kb
	eaUBbFdMux9GDELwxMIf1c8sO+l2yUmZ3d6hf04TaI3Ldy5TsVSQrXso3ZKqARZPBCY0VLmp0Xu
	wWngLNNEMXh6NQ/HL8KVKv3mHgqvsGAWqY48y+KQwMSZrx+8AN4tgO+sM7XnMc0Q=
X-Gm-Gg: AYBFou3E3PeBN8dPDwiQlMYH81XKUWcSQZMnPbktsa5xKOOEToTz9742wgLS0tDS3Yp
	a1boYBaKGZJdHptTJD3hvvmRREhg61gwYvVMqdGceOjljy8rNyubMv+X8WAzDPyD7boP/4FnMEE
	7Gz3gTfiNprsmXv+vcTb6LAxjulPsYQ91gakmpIBSt5fkEQOcyOyFee0VX9y1cYSnq2qWhCJ0CK
	NhoS7X6VWt8GDJ9AtYZD+J48x7JaDIBNlsOhW6yAp/C4mD3p3l5HR2HdcKK4xMOrgLVGgypepP+
	gd60PW+vrtHU3PmnmG7I8hwdtt9ShJmtRSLYgeTBcr0REnmWkY0Vq3L2lcidXMHuCoD14DfOrHw
	7qqMt0iTv2+4OhVD8HQzPPmZ/ciMfpnujqnfCY6XPtM7l7jDgjO+05gVIKRK1KzTlRBjS1+fi3h
	RoN6Z/93zqgeeALjqNJfaXWGYA
X-Received: by 2002:a05:7022:f90e:b0:190:596:4071 with SMTP id a92af1059eb24-1b3c033484bmr1198038c88.11.1794367726729;
        Tue, 10 Nov 2026 19:28:46 -0800 (PST)
X-Received: by 2002:a05:7022:f90e:b0:190:596:4071 with SMTP id a92af1059eb24-1b3c033484bmr1197997c88.11.1794367725971;
        Tue, 10 Nov 2026 19:28:45 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b56c4e88sm10261800c88.0.2026.11.10.19.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:28:45 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Subject: [PATCH 0/3] soc: qcom: Add Qualcomm PMIC GIO framework and RTC
 driver using it
Date: Tue, 10 Nov 2026 19:28:15 -0800
Message-Id: <20261110-gio-framework-rtc-driver-2026-10-12-v1-0-e4164178183a@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAM/g82oC/yXNywqDMBCF4VeRWXcgE1spvkrpQpOJnRZNmXgpi
 O9utMsPDv9ZIbEKJ6iLFZRnSRKHDLoU4F7N0DGKzwZrbEWGCDuJGLTpeYn6QR0depWZFY8FkkG
 yeA+2csS30l9byKWvcpDf+fJ4/p2m9s1uPNKwbTuUsT0NhwAAAA==
X-Change-ID: 20261011-gio-framework-rtc-driver-2026-10-12-8f26c1e53d4b
To: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794367724; l=3445;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=gYURsT4EB13XYEWtnH6o8S5v7vmAE2KhatW1p7v6K/E=;
 b=9E/VnFfx6BOlCD1VHnKAKViV6LTFMfwtag5LO8t1w0Do6mSwozdC1L5qRX5fL41bRtPLndJVV
 11qyp0FKcVMBdyuVIUjQkMaM3p/TXADA8AO511tP2mFT3ayOjYE9i5d
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAxMyBTYWx0ZWRfX8kTpiHN7H/NH
 uFFBmjH7BA16PBR/7NwqKVE7MdHNWHHhOzahtYQzfT0P8pog27cERgZrZMg3LpUVX551hThY3aY
 BMGmGlWmXX/gwwC3TcozBXyySJACwQGP7RdMrNH3UEgOvlAjppe3gNuDuSuUmvN8jcXtXWTXA7g
 10ScwsdGnys6Hkj4MmYOGZwMwPfI6nMESpwKvmD9Q4XX/q6vI134FZkRByETaLDTxBtb+XAlHY9
 3yf5tIPdV9AdergPsoL9XVDDeMTr9yiYnBoSeWaWe1UWiPdfejNBPVyPkimAyjXFTX/q+Cl4jDp
 i37I6AfY1uOUxKfhi+SusRVjKVUDv9ah2RMkSreL9cWG03SUnJBzRw8v+M73itRoqrJkF5eY1vm
 naABudyZhSlcm79fOafvgueG1OzbkdX9JZecf6wIaDGHw/OQoKJeaLU7G/87O6rqw6mVUxdYn9n
 Bc9XX7nv4bx6hRYjCGw==
X-Proofpoint-ORIG-GUID: WesfNPH4fSVRBrUNu8hb7USH28H3V5jx
X-Proofpoint-GUID: WesfNPH4fSVRBrUNu8hb7USH28H3V5jx
X-Authority-Analysis: v=2.4 cv=RfAFmFtv c=1 sm=1 tr=0 ts=6af3e0ef cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=_-7pcJMw-8RhaTVf9fsA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAxMyBTYWx0ZWRfX774ZNwFpS0Ae
 hNP6pTxpL6e+Zd1+J8aQIGnccgBddbz20OVbFGfrmO75+Lamfl91j7IWWaM4W6ca0eeCsVd7F2w
 fLqgnv4m8IAiLoUsS7AUz2bY28wLTCQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110013

Qualcomm SoCCP battery-management firmware on the Glymur platform
introduces a General I/O (GIO) interface. GIO exposes firmware
functionality through fixed-size register blocks grouped into
virtual peripherals, including core, battery, USB-C, service,
settings, debug, and OEM, etc. These blocks require block-aligned
transactions, while asynchronous firmware events are reported
as alerts identified by peripheral and alert IDs.

This series introduces a transport-agnostic PMIC GIO framework that
exposes the register space through regmap, tracks transport
availability, and routes alerts through a virtual IRQ domain.
It also provides managed interfaces for registering transports,
state notifiers, IRQ mappings, and auxiliary consumer devices.

It then adds a PMIC GLINK transport instance that converts GIO
block read/write transactions and alert notifications exchanged
over RPMSG into regmap accesses and IRQ delivery, and updated Glymur
to instantiate this GIO client while retaining the existing pmic_glink
clients.

Also, add a new RTC driver based on GIO interface to demonstrate
GIO usage, by accessing the firmware TAD real-time register block
for reading and setting the system time through the GIO regmap.

This also addresses a concern on the Glymur platform, where no
writable RTC device is available to retain the system time during
device reboot.

The battery manager, UCSI, and USB-C altmode functions currently
provided by dedicated PMIC GLINK clients can also be implemented
using the GIO interface. Changes have been made in qcom_battmgr/
ucsi_glink/pmic_glink_altmode drivers and tested on Glymur CRD
device by using the new GIO interface, including SSR scenarios.

This primarily helped validate the function and API sanity of
routing GIO alert messages through virtual interrupts, which
could not be done in the RTC driver because it does not need to
handle alert messages.

However, these client changes are not included in this series to
reduce the risk of introducing the GIO framework while migrating
all existing functionalities at the same time. They could be posted
to migrate these client drivers to their corresponding GIO auxiliary
devices and remove the legacy clients from Glymur once the GIO
implementations have been independently reviewed and accepted.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

---
Fenglin Wu (3):
      soc: qcom: Add pmic-gio GIO framework driver
      soc: qcom: pmic_glink: Add GIO pmic_glink instance
      rtc: Add Qualcomm GIO RTC driver

 drivers/rtc/Kconfig                    |  11 +
 drivers/rtc/Makefile                   |   1 +
 drivers/rtc/rtc-qcom-gio.c             | 153 +++++++
 drivers/soc/qcom/Kconfig               |  29 ++
 drivers/soc/qcom/Makefile              |   2 +
 drivers/soc/qcom/pmic_gio.c            | 707 +++++++++++++++++++++++++++++++++
 drivers/soc/qcom/pmic_glink.c          |  26 +-
 drivers/soc/qcom/pmic_glink_gio.c      | 571 ++++++++++++++++++++++++++
 include/linux/soc/qcom/pmic_gio.h      | 154 +++++++
 include/linux/soc/qcom/pmic_gio_regs.h | 239 +++++++++++
 include/linux/soc/qcom/pmic_glink.h    |   1 +
 11 files changed, 1892 insertions(+), 2 deletions(-)
---
base-commit: 14825c9204bad7f4e0bd3a528cbf4a7e24e757d0
change-id: 20261011-gio-framework-rtc-driver-2026-10-12-8f26c1e53d4b

Best regards,
--  
Fenglin Wu <fenglin.wu@oss.qualcomm.com>

