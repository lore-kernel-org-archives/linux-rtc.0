Return-Path: <rtc-linux+bncBDJIP47K7MERBYPJ33AAKGQE2XO2ZII@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id qv3si6524657pab.2.2016.10.31.14.17.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2016 14:17:21 -0700 (PDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C8CA320375
	for <rtc-linux@googlegroups.com>; Mon, 31 Oct 2016 21:17:19 +0000 (UTC)
Received: from mail-yb0-f174.google.com (mail-yb0-f174.google.com [209.85.213.174])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id ED7FD20303
	for <rtc-linux@googlegroups.com>; Mon, 31 Oct 2016 21:17:17 +0000 (UTC)
Received: by mail-yb0-f174.google.com with SMTP id d128so67292755ybh.2
        for <rtc-linux@googlegroups.com>; Mon, 31 Oct 2016 14:17:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161031203951.5444-2-paul@crapouillou.net>
References: <20161030230247.20538-1-paul@crapouillou.net> <20161031203951.5444-1-paul@crapouillou.net>
 <20161031203951.5444-2-paul@crapouillou.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 31 Oct 2016 16:16:56 -0500
Message-ID: <CAL_Jsq+5=QXfCTux1S7ysu8J5qnzU5AXr-0xzRTifnUYtzaQOg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 2/7] Documentation: dt: Add binding info
 for jz4740-rtc driver
To: Paul Cercueil <paul@crapouillou.net>
Cc: "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>, Maarten ter Huurne <maarten@treewalker.org>,
	Lars-Peter Clausen <lars@metafoo.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Oct 31, 2016 at 3:39 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> This commit adds documentation for the device-tree bindings of the
> jz4740-rtc driver, which supports the RTC unit present in the JZ4740 and
> JZ4780 SoCs from Ingenic.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt

Acked-by: Rob Herring <robh@kernel.org>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
