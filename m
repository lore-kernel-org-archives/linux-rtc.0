Return-Path: <rtc-linux+bncBDJIP47K7MERBROQ4DCQKGQEKN4XIYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id s64si1505457pfk.0.2017.03.02.06.12.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Mar 2017 06:12:21 -0800 (PST)
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 411A620392
	for <rtc-linux@googlegroups.com>; Thu,  2 Mar 2017 14:12:20 +0000 (UTC)
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com [209.85.161.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 742C920383
	for <rtc-linux@googlegroups.com>; Thu,  2 Mar 2017 14:12:18 +0000 (UTC)
Received: by mail-yw0-f180.google.com with SMTP id v200so56874404ywc.3
        for <rtc-linux@googlegroups.com>; Thu, 02 Mar 2017 06:12:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170302002709.22276-2-sre@kernel.org>
References: <20170220073535.27393-1-sre@kernel.org> <20170302002709.22276-1-sre@kernel.org>
 <20170302002709.22276-2-sre@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 2 Mar 2017 08:11:57 -0600
Message-ID: <CAL_JsqLpVr2zorMrSDZFTVLsMOaYgxexuGGq3iCNhm4zSw13zw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCHv4 2/2] rtc: cpcap: new rtc driver
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Mar 1, 2017 at 6:27 PM, Sebastian Reichel <sre@kernel.org> wrote:
> This driver supports the Motorola CPCAP PMIC found on
> some of Motorola's mobile phones, such as the Droid 4.
>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes since PATCHv3:
>  - Modified DT binding document to mention parent device
> ---
>  .../devicetree/bindings/rtc/cpcap-rtc.txt          |  18 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/rtc/Kconfig                                |   7 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-cpcap.c                            | 332 +++++++++++++++++++++
>  4 files changed, 358 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
>  create mode 100644 drivers/rtc/rtc-cpcap.c

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
