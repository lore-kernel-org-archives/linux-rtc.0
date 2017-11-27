Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-he1eur01on0082.outbound.protection.outlook.com ([104.47.0.82]:47023
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751575AbdK0UaG (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 27 Nov 2017 15:30:06 -0500
Date: Mon, 27 Nov 2017 13:29:55 -0700
From: Jason Gunthorpe <jgg@mellanox.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
        John Stultz <john.stultz@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
Message-ID: <20171127202955.GF13962@mellanox.com>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123112338.GN31757@n2100.armlinux.org.uk>
 <20171123120451.v74j3z2c5oodxlud@piout.net>
 <20171123125300.GO31757@n2100.armlinux.org.uk>
 <20171127201812.GB21126@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171127201812.GB21126@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, Nov 27, 2017 at 09:18:12PM +0100, Alexandre Belloni wrote:
 
> Also, fixing systohc will not fix the offset for people using hwclock or
> any other tools (e.g. systemd).

When I was talking this over with Russel originally I imagined the
systohc fix as a first step, and we could eventually add an rtc API to
let user space do a precise write to the RTC, with the kernel taking
care of the required sleep, etc.

Jason
