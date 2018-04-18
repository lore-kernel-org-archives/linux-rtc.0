Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:56346 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752647AbeDROXS (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Apr 2018 10:23:18 -0400
Date: Wed, 18 Apr 2018 17:23:08 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: robh@kernel.org
Cc: linux-rtc@vger.kernel.org
Subject: [bug report] rtc: pxa: convert to use shared sa1100 functions
Message-ID: <20180418142308.GA13543@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

[ This code is several years old now.  - dan ]

Hello Rob Herring,

The patch 3cdf4ad9633e: "rtc: pxa: convert to use shared sa1100
functions" from May 13, 2015, leads to the following static checker
warning:

	drivers/rtc/rtc-pxa.c:368 pxa_rtc_probe()
	info: return a literal instead of 'ret'

drivers/rtc/rtc-pxa.c
   352          pxa_rtc->base = devm_ioremap(dev, pxa_rtc->ress->start,
   353                                  resource_size(pxa_rtc->ress));
   354          if (!pxa_rtc->base) {
   355                  dev_err(dev, "Unable to map pxa RTC I/O memory\n");
   356                  return -ENOMEM;
   357          }
   358  
   359          pxa_rtc_open(dev);
   360  
   361          sa1100_rtc->rcnr = pxa_rtc->base + 0x0;
   362          sa1100_rtc->rtsr = pxa_rtc->base + 0x8;
   363          sa1100_rtc->rtar = pxa_rtc->base + 0x4;
   364          sa1100_rtc->rttr = pxa_rtc->base + 0xc;
   365          ret = sa1100_rtc_init(pdev, sa1100_rtc);
   366          if (!ret) {
                    ^^^^
This test really looks like it's inverted to me.

   367                  dev_err(dev, "Unable to init SA1100 RTC sub-device\n");
   368                  return ret;
   369          }
   370  
   371          rtsr_clear_bits(pxa_rtc, RTSR_PIALE | RTSR_RDALE1 | RTSR_HZE);
   372  
   373          pxa_rtc->rtc = devm_rtc_device_register(&pdev->dev, "pxa-rtc",
   374                                                  &pxa_rtc_ops, THIS_MODULE);
   375          if (IS_ERR(pxa_rtc->rtc)) {
   376                  ret = PTR_ERR(pxa_rtc->rtc);
   377                  dev_err(dev, "Failed to register RTC device -> %d\n", ret);
   378                  return ret;
   379          }
   380  
   381          device_init_wakeup(dev, 1);
   382  
   383          return 0;


regards,
dan carpenter
