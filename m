Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36703 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdGEVJ3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 5 Jul 2017 17:09:29 -0400
Date: Wed, 5 Jul 2017 23:09:27 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Wan ZongShun <mcuos.com@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-nuc900: fix loop timeout test
Message-ID: <20170705210927.uajd2c5hqz7rb5on@piout.net>
References: <20170623082900.GB7922@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170623082900.GB7922@elgon.mountain>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 23/06/2017 at 11:29:00 +0300, Dan Carpenter wrote:
> We should change this post-op to a pre-op because we want the loop to
> exit with "timeout" set to zero.
> 
> Fixes: 0a89b55364e0 ("nuc900/rtc: change the waiting for device ready implement")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
