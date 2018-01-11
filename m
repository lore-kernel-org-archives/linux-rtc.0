Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33755 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeAKXM6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 11 Jan 2018 18:12:58 -0500
Date: Fri, 12 Jan 2018 00:12:56 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Patrick Bruenn <p.bruenn@beckhoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: mxc_v2: remove __exit annotation
Message-ID: <20180111231256.GC2678@piout.net>
References: <20180102094443.3246258-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180102094443.3246258-1-arnd@arndb.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 02/01/2018 at 10:43:33 +0100, Arnd Bergmann wrote:
> The mxc_rtc_remove is incorrectly annotated as __exit:
> 
> `mxc_rtc_remove' referenced in section `.data' of drivers/rtc/rtc-mxc_v2.o: defined in discarded section `.exit.text' of drivers/rtc/rtc-mxc_v2.o
> 
> This should not be done, as devices can be dynamically bound
> and unbound to a driver.
> 
> Fixes: 54c47014b474 ("rtc: add mxc driver for i.MX53 SRTC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-mxc_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
