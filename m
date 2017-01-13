Return-Path: <rtc-linux+bncBC2IT2GSZUDRBNVI4LBQKGQE3NR2EGA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com. [62.209.51.94])
        by gmr-mx.google.com with ESMTPS id l66si94251wml.0.2017.01.13.00.47.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2017 00:47:50 -0800 (PST)
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Subject: [rtc-linux] RE: [PATCHv5 3/8] rtc: add STM32 RTC driver
Date: Fri, 13 Jan 2017 08:47:37 +0000
Message-ID: <be3a19059b2e4e0a9bfb8d0c3292dac4@SFHDAG3NODE2.st.com>
References: <1484142403-11556-1-git-send-email-amelie.delaunay@st.com>
 <20170113003840.u6uxt7u4qsit3oqt@piout.net>
In-Reply-To: <20170113003840.u6uxt7u4qsit3oqt@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

> This didn't apply cleanly, please check rtc-next. I don't think I made any mistake
> as the issue was only in Kconfig. You probably based your patches on 4.9
> instead of 4.10-rc1.
Sorry for this inconvenience. You're right, my patches were based on 4.9 to be tested on stm32f4 family.
No mistake found in your conflict resolution in Kconfig.

I'm going to send a new patch to fix warnings introduced by my driver on rtc-next.

Regards,
Amelie

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni@free-electrons.com]
> Sent: vendredi 13 janvier 2017 01:39
> To: Amelie DELAUNAY <amelie.delaunay@st.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Maxime
> Coquelin <mcoquelin.stm32@gmail.com>; Alexandre TORGUE
> <alexandre.torgue@st.com>; Russell King <linux@armlinux.org.uk>; rtc-
> linux@googlegroups.com; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Gabriel FERNANDEZ
> <gabriel.fernandez@st.com>
> Subject: Re: [PATCHv5 3/8] rtc: add STM32 RTC driver
> 
> On 11/01/2017 at 14:46:43 +0100, Amelie Delaunay wrote :
> > This patch adds support for the STM32 RTC.
> >
> > Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> > ---
> >  drivers/rtc/Kconfig     |  11 +
> >  drivers/rtc/Makefile    |   1 +
> >  drivers/rtc/rtc-stm32.c | 727
> > ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 739 insertions(+)
> >  create mode 100644 drivers/rtc/rtc-stm32.c
> >
> 
> This didn't apply cleanly, please check rtc-next. I don't think I made any mistake
> as the issue was only in Kconfig. You probably based your patches on 4.9
> instead of 4.10-rc1.
> 
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
