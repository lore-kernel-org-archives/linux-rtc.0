Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:53068 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932568AbeFGSLg (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 7 Jun 2018 14:11:36 -0400
Date: Thu, 7 Jun 2018 20:11:24 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh@kernel.org>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtc: pxa: fix probe function
Message-ID: <20180607181124.GC10521@piout.net>
References: <20180607082909.iyukeclgrb3dtjsy@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180607082909.iyukeclgrb3dtjsy@kili.mountain>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 07/06/2018 11:29:09+0300, Dan Carpenter wrote:
> This patch is from static analysis and I don't have the hardware to
> to test it.  I think the test is reversed so now the probe function
> will return success early and the last part of the function is dead
> code.
> 
> Fixes: 3cdf4ad9633e ("rtc: pxa: convert to use shared sa1100 functions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
