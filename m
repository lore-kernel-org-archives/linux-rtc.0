Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37299 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbdJLMdD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 08:33:03 -0400
Date: Thu, 12 Oct 2017 14:32:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: jz4740: fix loading of rtc driver
Message-ID: <20171012123251.e6jengn5vvmoxzr4@piout.net>
References: <20170918191014.28106-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170918191014.28106-1-malat@debian.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 18/09/2017 at 21:10:13 +0200, Mathieu Malaterre wrote:
> The current timeout for waiting for WRDY is not always sufficient. Always
> increase it to 10000 even on JZ4740. This is technically only required on
> JZ4780, where the current symptoms seen after a hard reboot are:
> 
>   jz4740-rtc 10003000.rtc: rtc core: registered 10003000.rtc as rtc0
>   jz4740-rtc 10003000.rtc: Could not write to RTC registers
>   jz4740-rtc: probe of 10003000.rtc failed with error -5
> 
> Suggested-by: Alex Smith <alex.smith@imgtec.com>
> Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/rtc/rtc-jz4740.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
