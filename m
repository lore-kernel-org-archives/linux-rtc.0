Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBFHR4PBQKGQEVLRPEAI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id h198si138886wmg.1.2017.01.13.07.56.03
        for <rtc-linux@googlegroups.com>;
        Fri, 13 Jan 2017 07:56:03 -0800 (PST)
Date: Fri, 13 Jan 2017 16:55:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Alessandro Zummo <a.zummo@towertech.it>,
	Amelie Delaunay <amelie.delaunay@st.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: stm32: use 32-bit cast for BIT() macro
Message-ID: <20170113155553.gjxfxpald3sqcywi@piout.net>
References: <20170113153311.2611510-1-arnd@arndb.de>
 <20170113153311.2611510-3-arnd@arndb.de>
 <20170113155229.GS14217@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170113155229.GS14217@n2100.armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 13/01/2017 at 15:52:29 +0000, Russell King - ARM Linux wrote :
> On Fri, Jan 13, 2017 at 04:32:53PM +0100, Arnd Bergmann wrote:
> > -#define PWR_CR_DBP			BIT(8)
> > +#define PWR_CR_DBP			(u32)BIT(8)
> 
> Shouldn't that have parens around it as it's no longer a simple expression.
> 

Yes, at least checkpatch complains about it.

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
