Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBVVD225AKGQENZWCJ4A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id x203si264499wme.0.2016.06.06.08.08.06
        for <rtc-linux@googlegroups.com>;
        Mon, 06 Jun 2016 08:08:06 -0700 (PDT)
Date: Mon, 6 Jun 2016 17:08:05 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alexander Graf <agraf@suse.de>
Cc: rtc-linux@googlegroups.com, leif.lindholm@linaro.org,
	linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [rtc-linux] Re: [PATCH] rtc: efi: Fail probing if RTC reads don't work
Message-ID: <20160606150805.GB3363@piout.net>
References: <1465119356-129799-1-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1465119356-129799-1-git-send-email-agraf@suse.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/06/2016 at 11:35:56 +0200, Alexander Graf wrote :
> While the EFI spec mandates an RTC, not every implementation actually adheres
> to that rule (or can adhere to it - some systems just don't have an RTC).
> 
> For those, we really don't want to probe the EFI RTC driver at all, because if
> we do we'd get a non-functional driver that does nothing useful but only spills
> our kernel log with warnings.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  drivers/rtc/rtc-efi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
