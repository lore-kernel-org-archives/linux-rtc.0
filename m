Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37322 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938216AbdLRWYu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 18 Dec 2017 17:24:50 -0500
Date: Mon, 18 Dec 2017 23:24:48 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: akinobu.mita@gmail.com, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc-r7301: Fix a possible sleep-in-atomic bug in
 rtc7301_set_time
Message-ID: <20171218222448.GJ15162@piout.net>
References: <1513173364-18424-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513173364-18424-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 13/12/2017 at 21:56:04 +0800, Jia-Ju Bai wrote:
> The driver may sleep under a spinlock.
> The function call path is:
> rtc7301_set_time (acquire the spinlock)
>   usleep_range --> may sleep
> 
> To fix it, usleep_range is replaced with udelay.
> 
> This bug is found by my static analysis tool(DSAC) and checked by my code review.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/rtc/rtc-r7301.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
