Return-Path: <rtc-linux+bncBDS7HNEFSALRBOGNQC2QKGQEVXHX6NQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 16si721859wmf.2.2016.01.20.16.30.47
        for <rtc-linux@googlegroups.com>;
        Wed, 20 Jan 2016 16:30:47 -0800 (PST)
Date: Thu, 21 Jan 2016 01:30:47 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
	rtc-linux@googlegroups.com, Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH 0/8] rtc: max77686: Extend driver and add
 max77802 support
Message-ID: <20160121003047.GF3367@piout.net>
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 20/01/2016 at 14:14:40 -0300, Javier Martinez Canillas wrote :
> One thing that I'm not sure is how to handle bisectability, in patch #5
> there will be two drivers that matches "rtc-max77802". So I don't know
> if I should use a different platform_device_id name and change in the
> same patch that max77802 is removed or if this is not a big deal so the
> patches could stay as is.
> 

I'm fine with those patches as is.

> I believe all patches should go through the RTC tree with proper acks or
> wait until the RTC patches land to pick the defconfig changes.
> 

I think Olof would prefer the last patches to go through arm-soc.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
