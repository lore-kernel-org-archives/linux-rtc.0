Return-Path: <rtc-linux+bncBDS7HNEFSALRBCPJUK4QKGQE7YQIB4A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a65si1553296wma.0.2016.05.03.07.24.09
        for <rtc-linux@googlegroups.com>;
        Tue, 03 May 2016 07:24:09 -0700 (PDT)
Date: Tue, 3 May 2016 16:23:58 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: thomas.koeller@baslerweb.com
Cc: p_gortmaker@yahoo.com, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [2/4] rtc: rtc-rs5c372: fixed check for 'oscillator
 halted' condition
Message-ID: <20160503142358.GL2335@piout.net>
References: <1275486787-30406-3-git-send-email-thomas.koeller@baslerweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1275486787-30406-3-git-send-email-thomas.koeller@baslerweb.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/06/2010 at 15:53:05 +0200, thomas.koeller@baslerweb.com wrote :
> From: Thomas Koeller <thomas.koeller@baslerweb.com>
> 
> The R2025SD chip, according to its data sheet, sets the /XST
> bit to zero if the oscillator stops. Hence the check for this
> condition was wrong.
> 
> Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
> ---
>  drivers/rtc/rtc-rs5c372.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
