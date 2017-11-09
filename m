Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55144 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbdKIASd (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Nov 2017 19:18:33 -0500
Date: Thu, 9 Nov 2017 01:18:24 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akshay Bhat <akshay.bhat@timesys.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtc: rx8010: Fix for incorrect return value
Message-ID: <20171109001824.ogyxhh2qhycbf2qq@piout.net>
References: <1510171094-4859-1-git-send-email-akshay.bhat@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510171094-4859-1-git-send-email-akshay.bhat@timesys.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 08/11/2017 at 14:58:14 -0500, Akshay Bhat wrote:
> The err variable is not being reset after a successful read. Explicitly
> return 0 at the end of function call to account for all return paths.
> 
> Reported-by: Jens-Peter Oswald <oswald@lre.de>
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
> ---
> v2: Address comments from Alexandre Belloni
> - Return 0 at end of function instead of resetting err variable
> 
>  drivers/rtc/rtc-rx8010.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
