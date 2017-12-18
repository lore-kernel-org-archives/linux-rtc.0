Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36211 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933574AbdLRVtv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 18 Dec 2017 16:49:51 -0500
Date: Mon, 18 Dec 2017 22:49:49 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andreas Platschek <andreas.platschek@opentech.at>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: omap: fix unbalanced
 clk_prepare_enable/clk_disable_unprepare
Message-ID: <20171218214949.GB15162@piout.net>
References: <20171206194238.12824-1-andreas.platschek@opentech.at>
 <20171206194238.12824-3-andreas.platschek@opentech.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171206194238.12824-3-andreas.platschek@opentech.at>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 06/12/2017 at 20:42:38 +0100, Andreas Platschek wrote:
> There are 2 error paths after clk_prepare_enable() was called, where
> clk_disable_unprepare() is missing.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Andreas Platschek <andreas.platschek@opentech.at>
> ---
>  drivers/rtc/rtc-omap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
