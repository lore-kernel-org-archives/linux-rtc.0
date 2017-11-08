Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58032 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754282AbdKHC2v (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 7 Nov 2017 21:28:51 -0500
Date: Wed, 8 Nov 2017 03:28:44 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akshay Bhat <akshay.bhat@timesys.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rtc: rx8010: Specify correct address for
 RX8010_RESV31
Message-ID: <20171108022844.fvru7wht6n6sb6fa@piout.net>
References: <1509730361-23905-1-git-send-email-akshay.bhat@timesys.com>
 <1509730361-23905-2-git-send-email-akshay.bhat@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509730361-23905-2-git-send-email-akshay.bhat@timesys.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 03/11/2017 at 13:32:40 -0400, Akshay Bhat wrote:
> Define for reserved register 31 had the incorrect address. Specify
> the correct address.
> 
> Reported-by: Jens-Peter Oswald <oswald@lre.de>
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
> ---
>  drivers/rtc/rtc-rx8010.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
