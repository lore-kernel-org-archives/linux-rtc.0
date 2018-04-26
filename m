Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:54625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753879AbeDZKWp (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 26 Apr 2018 06:22:45 -0400
In-Reply-To: <20180410114933.24581-3-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-rtc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [2/3] powerpc/powernv: Fix OPAL RTC driver OPAL_BUSY loops
Message-Id: <40WtRl5jlDz9s0R@ozlabs.org>
Date: Thu, 26 Apr 2018 20:22:43 +1000 (AEST)
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, 2018-04-10 at 11:49:32 UTC, Nicholas Piggin wrote:
> The OPAL RTC driver does not sleep in case it gets OPAL_BUSY or
> OPAL_BUSY_EVENT from firmware, which causes large scheduling
> latencies, up to 50 seconds have been observed here when RTC stops
> responding (BMC reboot can do it).
> 
> Fix this by converting it to the standard form OPAL_BUSY loop that
> sleeps.
> 
> Fixes 628daa8d5abfd ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks"
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linux-rtc@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/682e6b4da5cbe8e9a53f979a58c2a9

cheers
