Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49892 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947195AbdEZHmv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 26 May 2017 03:42:51 -0400
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id CA2F820B84
        for <linux-rtc@vger.kernel.org>; Fri, 26 May 2017 09:42:38 +0200 (CEST)
Date: Fri, 26 May 2017 03:08:13 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: Re: [PATCH v2] rtc: ds1307: convert driver to regmap
Message-ID: <20170526010813.qjrnsy4vkqjnhv24@piout.net>
References: <36fd14db-4bd7-dce5-b699-8b621af72f2a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36fd14db-4bd7-dce5-b699-8b621af72f2a@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>
Message-ID: <20170526010813.nqpzwJ8ZQlq48tIc9awIwOGRMF5k9SUrQyMaEEN4VbA@z>

On 10/03/2017 at 18:52:34 +0100, Heiner Kallweit wrote:
> This patch converts the ds1307 driver to using regmap. It's a rather
> big patch and I can test with DS3231 only. With this chip it's
> working fine.
> 
> I'd appreciate if people with other supported hardware could test as
> well.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - rebased on top of latest rtc tree
> ---
>  drivers/rtc/rtc-ds1307.c | 603 +++++++++++++++++------------------------------
>  1 file changed, 221 insertions(+), 382 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
