Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBEOD4DBQKGQEPF4WCFY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id l66si4552wml.0.2017.01.12.16.38.40
        for <rtc-linux@googlegroups.com>;
        Thu, 12 Jan 2017 16:38:41 -0800 (PST)
Date: Fri, 13 Jan 2017 01:38:40 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Russell King <linux@armlinux.org.uk>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: [rtc-linux] Re: [PATCHv5 3/8] rtc: add STM32 RTC driver
Message-ID: <20170113003840.u6uxt7u4qsit3oqt@piout.net>
References: <1484142403-11556-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1484142403-11556-1-git-send-email-amelie.delaunay@st.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 11/01/2017 at 14:46:43 +0100, Amelie Delaunay wrote :
> This patch adds support for the STM32 RTC.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/rtc/Kconfig     |  11 +
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-stm32.c | 727 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 739 insertions(+)
>  create mode 100644 drivers/rtc/rtc-stm32.c
> 

This didn't apply cleanly, please check rtc-next. I don't think I made
any mistake as the issue was only in Kconfig. You probably based your
patches on 4.9 instead of 4.10-rc1.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
