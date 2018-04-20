Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-by2nam03on0046.outbound.protection.outlook.com ([104.47.42.46]:7638
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753823AbeDTHYs (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 20 Apr 2018 03:24:48 -0400
Subject: Re: [PATCH 44/61] rtc: simplify getting .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-renesas-soc@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-rtc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-45-wsa+renesas@sang-engineering.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <6c43fc08-4f73-601f-228c-9a4202d5b5c5@xilinx.com>
Date: Fri, 20 Apr 2018 09:24:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180419140641.27926-45-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 19.4.2018 16:06, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/rtc/rtc-bq4802.c   |  6 ++----
>  drivers/rtc/rtc-ds1216.c   |  6 ++----
>  drivers/rtc/rtc-ds1511.c   |  9 +++------
>  drivers/rtc/rtc-ds1553.c   | 15 +++++----------
>  drivers/rtc/rtc-ds1685.c   | 21 +++++++--------------
>  drivers/rtc/rtc-ds1742.c   |  6 ++----
>  drivers/rtc/rtc-lpc32xx.c  | 16 ++++++----------
>  drivers/rtc/rtc-m48t59.c   | 41 ++++++++++++++++-------------------------
>  drivers/rtc/rtc-mv.c       |  3 +--
>  drivers/rtc/rtc-mxc.c      | 21 +++++++--------------
>  drivers/rtc/rtc-pcap.c     | 15 +++++----------
>  drivers/rtc/rtc-sh.c       | 15 +++++----------
>  drivers/rtc/rtc-stk17ta8.c | 15 +++++----------
>  drivers/rtc/rtc-test.c     |  3 +--
>  drivers/rtc/rtc-zynqmp.c   | 10 ++++------

Acked-by: Michal Simek <michal.simek@xilinx.com> (for zynqmp)

Thanks,
Michal
