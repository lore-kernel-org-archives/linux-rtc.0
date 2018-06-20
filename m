Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:48846 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752871AbeFTKoj (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 20 Jun 2018 06:44:39 -0400
Date: Wed, 20 Jun 2018 12:44:27 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtc: mrst: fix error code in probe()
Message-ID: <20180620104427.GB7737@piout.net>
References: <20180612120302.kprwknomakzg7bdn@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180612120302.kprwknomakzg7bdn@kili.mountain>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 12/06/2018 15:03:02+0300, Dan Carpenter wrote:
> We should be returning "retval".  The "mrst_rtc.rtc" variable is a valid
> pointer.
> 
> Fixes: 32b41f93dcaf ("rtc: mrst: switch to devm functions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
