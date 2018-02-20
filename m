Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:58274 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeBTJAf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 20 Feb 2018 04:00:35 -0500
Date: Tue, 20 Feb 2018 12:00:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
Subject: [bug report] rtc: m48t59: use generic nvmem
Message-ID: <20180220090025.GA20051@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hello Alexandre Belloni,

This is a semi-automatic email about new static checker warnings.

The patch ce0e0076da3e: "rtc: m48t59: use generic nvmem" from Feb 12, 
2018, leads to the following Smatch complaint:

    drivers/rtc/rtc-m48t59.c:409 m48t59_rtc_probe()
    warn: variable dereferenced before check 'pdata' (see line 391)

drivers/rtc/rtc-m48t59.c
   390			.stride = 1,
   391			.size = pdata->offset,
                                ^^^^^^^^^^^^^
New dereference.

   392			.reg_read = m48t59_nvram_read,
   393			.reg_write = m48t59_nvram_write,
   394			.priv = pdev,
   395		};
   396	
   397		/* This chip could be memory-mapped or I/O-mapped */
   398		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   399		if (!res) {
   400			res = platform_get_resource(pdev, IORESOURCE_IO, 0);
   401			if (!res)
   402				return -EINVAL;
   403		}
   404	
   405		if (res->flags & IORESOURCE_IO) {
   406			/* If we are I/O-mapped, the platform should provide
   407			 * the operations accessing chip registers.
   408			 */
   409			if (!pdata || !pdata->write_byte || !pdata->read_byte)
                             ^^^^^
The existing code assumed "pdata" could be NULL.

   410				return -EINVAL;
   411		} else if (res->flags & IORESOURCE_MEM) {

regards,
dan carpenter
