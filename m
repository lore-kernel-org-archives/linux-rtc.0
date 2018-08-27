Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:52535 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbeH1AxU (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 27 Aug 2018 20:53:20 -0400
Date: Mon, 27 Aug 2018 23:05:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Denis Osterland <Denis.Osterland@diehl.com>,
        linux-rtc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtc: sysfs: fix NULL check in rtc_add_groups()
Message-ID: <20180827210500.GH24549@piout.net>
References: <20180827092234.mj44ruwkglbor3e5@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180827092234.mj44ruwkglbor3e5@kili.mountain>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 27/08/2018 12:22:34+0300, Dan Carpenter wrote:
> devm_kcalloc() returns NULL, it never returns error pointers.  In the
> current code we would return PTR_ERR(NULL) which is success, instead of
> returning the -ENOMEM error code.
> 
> Fixes: a0a1a1ba3032 ("rtc: sysfs: facilitate attribute add to rtc device")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
