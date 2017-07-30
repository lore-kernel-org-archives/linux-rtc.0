Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60459 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdG3PGG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 30 Jul 2017 11:06:06 -0400
Date: Sun, 30 Jul 2017 17:06:04 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Colin King <colin.king@canonical.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-max8925: remove redundant check on ret
Message-ID: <20170730150604.d7lhvwx7c4v4knsw@piout.net>
References: <20170607152615.2072-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170607152615.2072-1-colin.king@canonical.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 07/06/2017 at 16:26:15 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check on ret < 0 is redundant as the goto destination is the
> next statment.  Remove this redudant check and goto.
> 
> Detected by CoverityScan, CID#1268785 ("Identical code for different
> branches")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/rtc/rtc-max8925.c | 2 --
>  1 file changed, 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
