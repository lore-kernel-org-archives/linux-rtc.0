Return-Path: <rtc-linux+bncBCF252X47MMRBMVR52UAKGQETL5SM2A@googlegroups.com>
Received: from zabrina.hetzner-de.towertech.it (zabrina.hetzner-de.towertech.it. [178.63.16.19])
        by gmr-mx.google.com with ESMTP id i8si60856wif.1.2015.04.01.00.05.22
        for <rtc-linux@googlegroups.com>;
        Wed, 01 Apr 2015 00:05:22 -0700 (PDT)
Date: Wed, 1 Apr 2015 09:05:20 +0200
From: Alessandro Zummo <a.zummo@towertech.it>
To: Joe Perches <joe@perches.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] Re: [PATCH 3/3] rtc: hctosys: use function name in
 the error log
Message-ID: <20150401090520.559ead39@linux.lan.towertech.it>
In-Reply-To: <1427858308.18175.30.camel@perches.com>
References: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
	<1427576976-22353-3-git-send-email-aaro.koskinen@iki.fi>
	<20150401030124.GO3849@piout.net>
	<1427858308.18175.30.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, 31 Mar 2015 20:18:28 -0700
Joe Perches <joe@perches.com> wrote:

> Neither __func__ or __FILE__ is really useful here.
> The message is already specific enough without it.
> 
> If anything, it'd probably be better to add
> 
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 Seems reasonable given that pr_fmt is widely
 used elsewhere.

 I don't like too much the need to have one define for
 each file, but it's the way it works :-/

-- 

 Best regards,

 Alessandro Zummo - CEO,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

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
