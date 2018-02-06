Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:40150 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeBFCN3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 5 Feb 2018 21:13:29 -0500
Date: Tue, 6 Feb 2018 03:13:13 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Brandon Martin <martinbv@mothictech.com>
Cc: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        a.zummo@towertech.it, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: remove rtc-at32ap700x
Message-ID: <20180206021313.GO3404@piout.net>
References: <20180118200846.14368-1-clabbe.montjoie@gmail.com>
 <20180119072733.dkswccdbnisbmqi6@samfundet.no>
 <20180119085835.GW2678@piout.net>
 <b1ad9b75-5a1f-f84c-da49-917f491325d5@mothictech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b1ad9b75-5a1f-f84c-da49-917f491325d5@mothictech.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 05/02/2018 at 20:09:32 -0500, Brandon Martin wrote:
> On 01/19/2018 03:58 AM, Alexandre Belloni wrote:
> > Well, my plan was to keep it for a little while, but whatever :)
> 
> As far as I know, the AVR32 AP7x architecture has been commercially dead for far longer than it was ever active.  I'd agree - axe it if support for the overall architecture is on its way out, too.

If you had a look at Linus' tree, you'd have seen that the driver is
already removed.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
