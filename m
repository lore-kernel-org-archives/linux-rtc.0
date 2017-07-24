Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:34924
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751799AbdGXEyY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 24 Jul 2017 00:54:24 -0400
Date: Mon, 24 Jul 2017 06:54:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
cc: Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        linux-mips@linux-mips.org, kbuild-all@01.org
Subject: Re: [PATCH v3 2/8] MIPS: ranchu: Add Goldfish RTC driver (fwd)
Message-ID: <alpine.DEB.2.20.1707240652320.3169@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Please check line 203; it seems that the tested value is unsigned.

julia

---------- Forwarded message ----------
Date: Mon, 24 Jul 2017 11:40:38 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v3 2/8] MIPS: ranchu: Add Goldfish RTC driver

Hi Miodrag,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.13-rc2 next-20170721]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Aleksandar-Markovic/MIPS-Add-virtual-Ranchu-board-as-a-generic-based-board/20170724-062318
:::::: branch date: 5 hours ago
:::::: commit date: 5 hours ago

>> drivers/rtc/rtc-goldfish.c:203:5-16: WARNING: Unsigned expression compared with zero: rtcdrv -> irq < 0

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 3b43c4b417a02749f734942456b41eb397e389ae
vim +203 drivers/rtc/rtc-goldfish.c

3b43c4b4 Miodrag Dinic 2017-07-21  181
3b43c4b4 Miodrag Dinic 2017-07-21  182  static int goldfish_rtc_probe(struct platform_device *pdev)
3b43c4b4 Miodrag Dinic 2017-07-21  183  {
3b43c4b4 Miodrag Dinic 2017-07-21  184  	struct resource *r;
3b43c4b4 Miodrag Dinic 2017-07-21  185  	struct goldfish_rtc *rtcdrv;
3b43c4b4 Miodrag Dinic 2017-07-21  186  	int err;
3b43c4b4 Miodrag Dinic 2017-07-21  187
3b43c4b4 Miodrag Dinic 2017-07-21  188  	rtcdrv = devm_kzalloc(&pdev->dev, sizeof(*rtcdrv), GFP_KERNEL);
3b43c4b4 Miodrag Dinic 2017-07-21  189  	if (rtcdrv == NULL)
3b43c4b4 Miodrag Dinic 2017-07-21  190  		return -ENOMEM;
3b43c4b4 Miodrag Dinic 2017-07-21  191
3b43c4b4 Miodrag Dinic 2017-07-21  192  	platform_set_drvdata(pdev, rtcdrv);
3b43c4b4 Miodrag Dinic 2017-07-21  193
3b43c4b4 Miodrag Dinic 2017-07-21  194  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
3b43c4b4 Miodrag Dinic 2017-07-21  195  	if (r == NULL)
3b43c4b4 Miodrag Dinic 2017-07-21  196  		return -ENODEV;
3b43c4b4 Miodrag Dinic 2017-07-21  197
3b43c4b4 Miodrag Dinic 2017-07-21  198  	rtcdrv->base = devm_ioremap_resource(&pdev->dev, r);
3b43c4b4 Miodrag Dinic 2017-07-21  199  	if (IS_ERR(rtcdrv->base))
3b43c4b4 Miodrag Dinic 2017-07-21  200  		return -ENODEV;
3b43c4b4 Miodrag Dinic 2017-07-21  201
3b43c4b4 Miodrag Dinic 2017-07-21  202  	rtcdrv->irq = platform_get_irq(pdev, 0);
3b43c4b4 Miodrag Dinic 2017-07-21 @203  	if (rtcdrv->irq < 0)
3b43c4b4 Miodrag Dinic 2017-07-21  204  		return -ENODEV;
3b43c4b4 Miodrag Dinic 2017-07-21  205
3b43c4b4 Miodrag Dinic 2017-07-21  206  	rtcdrv->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
3b43c4b4 Miodrag Dinic 2017-07-21  207  					&goldfish_rtc_ops, THIS_MODULE);
3b43c4b4 Miodrag Dinic 2017-07-21  208  	if (IS_ERR(rtcdrv->rtc))
3b43c4b4 Miodrag Dinic 2017-07-21  209  		return PTR_ERR(rtcdrv->rtc);
3b43c4b4 Miodrag Dinic 2017-07-21  210
3b43c4b4 Miodrag Dinic 2017-07-21  211  	err = devm_request_irq(&pdev->dev, rtcdrv->irq, goldfish_rtc_interrupt,
3b43c4b4 Miodrag Dinic 2017-07-21  212  		0, pdev->name, rtcdrv);
3b43c4b4 Miodrag Dinic 2017-07-21  213  	if (err)
3b43c4b4 Miodrag Dinic 2017-07-21  214  		return err;
3b43c4b4 Miodrag Dinic 2017-07-21  215
3b43c4b4 Miodrag Dinic 2017-07-21  216  	return 0;
3b43c4b4 Miodrag Dinic 2017-07-21  217  }
3b43c4b4 Miodrag Dinic 2017-07-21  218

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
