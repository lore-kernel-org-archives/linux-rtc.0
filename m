Return-Path: <rtc-linux+bncBCPKXLX44AMBBN5TTC3QKGQEVJVIKDI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from cvs.linux-mips.org (eddie.linux-mips.org. [148.251.95.138])
        by gmr-mx.google.com with ESMTP id c140si579409wmh.1.2016.03.13.18.53.58
        for <rtc-linux@googlegroups.com>;
        Sun, 13 Mar 2016 18:53:58 -0700 (PDT)
Received: from localhost.localdomain ([127.0.0.1]:41836 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007730AbcCNBx6fdHmk (ORCPT
        <rfc822;rtc-linux@googlegroups.com>); Mon, 14 Mar 2016 02:53:58 +0100
Date: Mon, 14 Mar 2016 02:53:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Burton <paul.burton@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 5/5] MIPS: jz4740: Use the jz4740-rtc driver
 as the power controller
Message-ID: <20160314015353.GB29020@linux-mips.org>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-5-git-send-email-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1457217531-26064-5-git-send-email-paul@crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sat, Mar 05, 2016 at 11:38:51PM +0100, Paul Cercueil wrote:

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/dts/ingenic/jz4740.dtsi |  2 ++
>  arch/mips/jz4740/reset.c               | 64 ----------------------------------

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Feel free to funnel this patch upstream through the RTC tree.  Or I can
carry the whole series, just lemme know.

  Ralf

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
