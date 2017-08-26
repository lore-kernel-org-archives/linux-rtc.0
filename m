Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33033 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbdHZKpI (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 26 Aug 2017 06:45:08 -0400
Date: Sat, 26 Aug 2017 12:44:57 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/5] rtc: ds1307: factor out more stuff from ds1307_probe
 and improve ds1307_set_time
Message-ID: <20170826104457.sdeeacwgboeectpw@piout.net>
References: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
 <20170826081904.ibsxi7crvi7qop3m@piout.net>
 <9ae42f67-9562-16c4-252d-9f629a31b69e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9ae42f67-9562-16c4-252d-9f629a31b69e@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 26/08/2017 at 12:16:53 +0200, Heiner Kallweit wrote:
> That's exactly my point. The driver is too big already.
> 
> The patches so far increase size of the driver a little, only subsequent
> patches start to reduce it.
> 
> More things like even exporting clocks work the same on all chips
> supporting this feature. Just the layout of the alarm registers usually is
> quite different. Therefore it's my plan to create such a ds1307_lib with all
> the generic code.
> 
> If it helps I can provide the full patch set (as far as I came so far) via
> Github, then you can check whether it's the right direction also from your
> point of view (w/o having to review each single patch in detail already).
> 

Yes, please do that.

> By the way: This current patch set with the 5 patches I have to change,
> so there will be a v2. No need for you to spend reviewing effort on it now.
> 

Ok, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
