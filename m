Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161924252A0
	for <linux-rtc@vger.kernel.org>; Fri, 11 Sep 2026 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122164; cv=none; b=ORfHDhJ91a7bsQZfw+urnARkbZC1SP17rtfdgHkET1Dtl6CqrDFzhTOgQHfEizUfQZGQlAhA/bEiIlYfEj6JH+fYq67DmQZJ1opWn/E+iX2qYXRFo106iF5wJy1SfQZbGZBSjQ9TF8SEJCuvc+RikMgfU6U8OHWxBlvZ5ESuns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122164; c=relaxed/simple;
	bh=IzxSwCrhf8d9FMRhv0k7DfYYSIK+phpr001usHYVJgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPCIyDXq7Ht1j7rLtqtBn/EPWAI79XCfdVlXQ1C2SnSyx8I73PR+q8V2yU9jL+iChkSAtU1XfBZfcjIRH16TQ6Vh86hnKfSfiDt/S6bZiFH/T6re91bOeYLLtSbsw1Jzub9B0tDfWcrs0fa4ySy5fA7GHQy5rBwv4brcZWSmJpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iNuMl10J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PCBvd+M4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iNuMl10J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PCBvd+M4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7ksjq3464123
	for <linux-rtc@vger.kernel.org>; Fri, 11 Sep 2026 10:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tDweQGfiDsekOj0T2784PA2rCFWCh+RkBLsA7n7s2rE=; b=iNuMl10JnOkrBvNr
	n2Y5oDnpdHx5rpmFkY4AD9L4wOL2CfWozbGj6GhbcPVGy+3azf9v4cMvSdc4pIq3
	G+MdrFSluFt83raNUpUP0UgtTVrWwCuJYCkSKmR5HHMfJ32Mk5a/8vAq99sgNa24
	OlAjL1QV/kJHxZPM5dI2gO3EMkt48/QnighBWtrYMyabnjUvBmMRCzBPpzw746T/
	q/aZcrQFU7Aym4wZYhN35EC+JO2ecMJLAgFgpUBiMWRU6fhkUoOqBllIpKAW2P0q
	idi9EplvOYdiRzaWbWdDanAPxindBPXXbxi5bBb+ekEoF5vZ/mRjM5Ciy3m7oWz+
	WLnm6Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbdr95hm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Fri, 11 Sep 2026 10:22:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939e1847252so277123785a.1
        for <linux-rtc@vger.kernel.org>; Fri, 11 Sep 2026 03:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789122161; x=1789726961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDweQGfiDsekOj0T2784PA2rCFWCh+RkBLsA7n7s2rE=;
        b=PCBvd+M4TMViz8z7dzLR1BlUgdhCM3sBSLfwfmB4tebHtwwPeQJmVQfqU+LLdz4fcl
         jx3B+N1OKyyZ0XkQzTRsxsb0oR+JeuxOfuAGhyu/sNvBDrW+DTxioZvKb0cqGvxuK64B
         LsGkzFFYzakEvovtg05OYuKpG00p2ikZnHRTJ+IKyow/IcqnmP8RfTZkU3ALCBgRCaLV
         2SiuGt2oviaYrZ+S0B1gUaODRLoUsZAvxvmRTUa76hTjwAnsItE+oL4OebrU01y4DQww
         wY41xkC2OIGRXadZPhIbfj4cdRQtTW7GP3tdYVeUW2IPt5+4czNbVCdxUrEwR6J3SKtX
         I1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789122161; x=1789726961;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tDweQGfiDsekOj0T2784PA2rCFWCh+RkBLsA7n7s2rE=;
        b=jH5WdEGacc1u4jVM7xbZgKGPpVXIuOqgjT381Y15Eo1RSPqY8NLZ0cYzWzlOizwPiJ
         Si6QpJMSUwb2COZjiBDw53YVY9JzQdOgBAJ7eKt5ba0ZNGHPXon2zCkvv0Hl5naWNHQ6
         GaeTdXGSavvcqr8BD2RiCvWoay3TXAWkmGvwT7Lz2+vdDJRg63iDBRfsdHTlX8p7+E2e
         3o/9iZJ6KuQG1e8LdhXlEBOkmMqJ+sivUVqcbnGcxP0Mgp5ablm+/46lcmjaW05atuZW
         z3vq6AP/8284JVqQHf87+S56rYgO6jY/j9orvBFzZIHgXsB+EDXTh9AQVf1akFLPcEDz
         I6QQ==
X-Forwarded-Encrypted: i=1; AKwUvBzppsrh1m7tIiYhXGdYvsQqWcKNpQ5+R2ZJm/IFhPBFEHCbjw0MeK3H9l27llfLaKz0YlWOSUesByY=@vger.kernel.org
X-Gm-Message-State: AFuF++nw87+zs/I7ywBQyW3VHGkNyaHvtpKdrTlR3wLUntw1g897Pye/
	2pyCU6qFU5noPeh1UnZB5F+YK/xJ2BqKeZBsnaem4RQFgbSZqOgs971S52yjJ8H66R1TvTF/dcT
	y9kg5rzTqcdKL0ZYaW2DtCclmrSUb7CJ8WlSYqX/qGjfux+A+3cko4Cs2LNC69Bo=
X-Gm-Gg: AYBFou3w6OQCAVzyP6IL0/zpReuTtwbmEuOerHG/JhoysSA7vZ9Q6bwF1Yi8qtfBFec
	7F2JRJ/UdAdOtnTN0gYD5Swr9zWu/N4EiqrYd2LLQRw8GRPH6of1JG5V7bdg77DH3QBIYgGDUSg
	EVSCQWfZeLhzYIDpkduhIwD/n8ZtlmwwH31tblj95+Sbh4HIE2EhmnW6kbTxpsryh4DyrGnvOHU
	IxJWHwDcMbmwi9wXw2jIpJuogf7WAetErtB5giTzU6KgyqtTrnLcmDw8y25iumZXH9Eh8JJICn1
	tfLMb/KJ5qSWlbftUzwxMFQyUTftsPGg+fs8iyfVg0Tbn4ZKKjNqQBrSKGr6bu57dAudfw3BHHr
	2reK25j2KO8/OHEfV5ckFcumIfQRMimucge2d2apS4oA1I44p7mVHRfiXpCUai6A=
X-Received: by 2002:a05:620a:4482:b0:939:c7dc:8712 with SMTP id af79cd13be357-939d7eaef14mr1043307485a.15.1789122161356;
        Fri, 11 Sep 2026 03:22:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4482:b0:939:c7dc:8712 with SMTP id af79cd13be357-939d7eaef14mr1043304085a.15.1789122160909;
        Fri, 11 Sep 2026 03:22:40 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60a8a89esm63701295e9.1.2026.09.11.03.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 03:22:39 -0700 (PDT)
Message-ID: <81b9d76d-6036-45fa-8dcc-c180d102ef64@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:22:37 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] ARM: orion/dove/mv78xx0: remove all board files
To: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linusw@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc: Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
        Stefan Agner <stefan@agner.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade
 <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Ethan Nelson-Moore <enelsonmoore@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Karl Mehltretter <kmehltretter@gmail.com>,
        "David Hildenbrand (Arm)" <david@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
        Alexander Clouter <alex@digriz.org.uk>,
        "Jeremy J. Peper" <jeremy@jeremypeper.com>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Ulf Hansson <ulfh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-6-arnd@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260908152808.3928630-6-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I9w7WB9LB_bnjLfWfH2ut03wMhQbHeDL
X-Authority-Analysis: v=2.4 cv=PLmaavqC c=1 sm=1 tr=0 ts=6aa3d671 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=P-IC7800AAAA:8 a=qUSviUioAAAA:8 a=bcVNC_F_AAAA:8 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=_jlGtV7tAAAA:8 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8
 a=LCLTMPDaK1Elu1LaZkAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22 a=NaVVo_BLbmHoeYVcMpQ9:22
 a=XlnQEC-7T2amSQPCFme7:22 a=nlm17XC03S6CtCLSeiRr:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: I9w7WB9LB_bnjLfWfH2ut03wMhQbHeDL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NSBTYWx0ZWRfX62c6FS/TJTcw
 N7RGcrOQtTemv8OmU5JrE2BVwdNQxUZSDTlDn9WBgAS2gs9IzybHZHMFxtN3HqfIJSKQM2krkQw
 pxCDl/srotW+SxD/X3I4JoSrdBUQpjk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NSBTYWx0ZWRfX2LUDkxU2XH7N
 7E8Wm2RDaiZXRpCSwQjZVXpa7mCeW70v0IWKkUw7/UUjZHVD+AGIVR3vr0lf+sNHKcBl5VmIju8
 YstXsKbWFXecALlpadE6NrRZDCZ3x4wU4VllGOW79YMMAXLZiQBZqXaN0h6hEHDkejUihm5RkLS
 Gk1Wl+rDSqKuv4eKOEGeZTw36vrzOwpkGBY54s7B68KnEXOadT1HCZDUdMCVl3q1hlcBAqAsX/P
 SwAm2XgGniSkrsPtYkLH0EYzHTunont8Hl8DG92fusAbuAzCj9F3Ws+5b9LrFYAPi0JddzfYdZF
 bz1yPbjT1oShuytVpsBnVloKlpKktuEcfNvN4rQWh30dB9Dv90mAeGYbFQWhH4JuMyQ2FlfkNKd
 lfq5gvIKLmIx24CvdgfmcvLojYt7zvalLWJxp/Fov9pA15z0bOi6j1epAUNpFKgXCOr2Y9Ia5B2
 2NT3ue3qhg6z/NBn9dQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110145

On 9/8/26 17:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'orion' platform is the predecessor to what linux now calls the
> 'mvebu' line of Marvell SoCs, and originally covered orion5x,
> mv78xx0, kirkwood, dove and a few others that do not have any
> upstream support at the moment.
> 
> Only a few board files remain here, these are the ones left
> in 2022 board file purge because they had some level of support
> in Debian or OpenWRT, mostly for commercial NAS or router boxes.
> This distro support is now gone, and nobody has converted the
> board files to devicetree, though the orion5x and dove platforms
> also come with devicetree support for some other machines.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> Cc: Jeremy J. Peper <jeremy@jeremypeper.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: Ulf Hansson <ulfh@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-phy@lists.infradead.org
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-sound@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com> # thermal
