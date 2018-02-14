Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:44363 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754489AbeBNHwo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 14 Feb 2018 02:52:44 -0500
Date: Wed, 14 Feb 2018 08:52:42 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Colin King <colin.king@canonical.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1302: remove redundant initializations of pointer
 bp
Message-ID: <20180214075242.GA8219@piout.net>
References: <20180123101727.31028-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123101727.31028-1-colin.king@canonical.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 23/01/2018 at 10:17:27 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointe bp is being initialized and this value is never read, it
> is being updated to the same value later just before it is going to
> be used. Remove the initialization as it is never read and keep
> the setting of bp closer to the use of bp.
> 
> Cleans up clang warnings:
> drivers/rtc/rtc-ds1302.c:115:7: warning: Value stored to 'bp' during
> its initialization is never read
> drivers/rtc/rtc-ds1302.c:46:7: warning: Value stored to 'bp' during
> its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/rtc/rtc-ds1302.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
