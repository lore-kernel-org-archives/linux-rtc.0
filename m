Return-Path: <rtc-linux+bncBCFPF2XH6UDBBNFLZDAQKGQEKHIMLGY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from shards.monkeyblade.net (shards.monkeyblade.net. [184.105.139.130])
        by gmr-mx.google.com with ESMTP id i184si659470wmf.1.2016.11.20.13.29.24
        for <rtc-linux@googlegroups.com>;
        Sun, 20 Nov 2016 13:29:24 -0800 (PST)
Date: Sun, 20 Nov 2016 16:29:19 -0500 (EST)
Message-Id: <20161120.162919.145900145134940393.davem@davemloft.net>
To: paul.gortmaker@windriver.com
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com, sparclinux@vger.kernel.org,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/3] rtc: sparc: make starfire explicitly non-modular
From: David Miller <davem@davemloft.net>
In-Reply-To: <20161031185527.20279-3-paul.gortmaker@windriver.com>
References: <20161031185527.20279-1-paul.gortmaker@windriver.com>
	<20161031185527.20279-3-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 31 Oct 2016 14:55:26 -0400

> The Kconfig currently controlling compilation of this code is:
> 
> drivers/rtc/Kconfig:config RTC_DRV_STARFIRE
> drivers/rtc/Kconfig:    bool "Starfire RTC"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the couple traces of modular infrastructure use, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied.
