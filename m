Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBPU5Y7CAKGQE3QFU3MI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 14si1236022wmn.2.2017.02.01.04.04.13
        for <rtc-linux@googlegroups.com>;
        Wed, 01 Feb 2017 04:04:13 -0800 (PST)
Date: Wed, 1 Feb 2017 13:04:13 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, kbuild-all@01.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [abelloni:rtc-next 21/27] drivers/rtc/rtc-sun6i.c:371:18:
 error: 'rtc' undeclared
Message-ID: <20170201120413.4tr3ioefodq3qx7j@piout.net>
References: <201702011659.gUb4cOaw%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <201702011659.gUb4cOaw%fengguang.wu@intel.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Maxime,

Because that patch was marked for stable, I've fixed it up directly in
my tree.

On 01/02/2017 at 16:32:05 +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
> head:   4c6106406eb18a5aded19540c4b50d262717b959
> commit: 524bc1fcaae8e2bc7d1b5a9b42588642bc3ff777 [21/27] rtc: sun6i: Add some locking
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 524bc1fcaae8e2bc7d1b5a9b42588642bc3ff777
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> Note: the abelloni/rtc-next HEAD 4c6106406eb18a5aded19540c4b50d262717b959 builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/wait.h:8:0,
>                     from include/linux/fs.h:5,
>                     from drivers/rtc/rtc-sun6i.c:25:
>    drivers/rtc/rtc-sun6i.c: In function 'sun6i_rtc_probe':
> >> drivers/rtc/rtc-sun6i.c:371:18: error: 'rtc' undeclared (first use in this function)
>      spin_lock_init(&rtc->lock);
>                      ^
>    include/linux/spinlock.h:296:17: note: in definition of macro 'spin_lock_init'
>      spinlock_check(_lock);    \
>                     ^~~~~
>    drivers/rtc/rtc-sun6i.c:371:18: note: each undeclared identifier is reported only once for each function it appears in
>      spin_lock_init(&rtc->lock);
>                      ^
>    include/linux/spinlock.h:296:17: note: in definition of macro 'spin_lock_init'
>      spinlock_check(_lock);    \
>                     ^~~~~
> 
> vim +/rtc +371 drivers/rtc/rtc-sun6i.c
> 
>    365		struct resource *res;
>    366		int ret;
>    367	
>    368		chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>    369		if (!chip)
>    370			return -ENOMEM;
>  > 371		spin_lock_init(&rtc->lock);
>    372	
>    373		platform_set_drvdata(pdev, chip);
>    374		chip->dev = &pdev->dev;
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



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
