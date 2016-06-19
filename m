Return-Path: <rtc-linux+bncBDJIP47K7MERBT6YTK5QKGQEOVTUP2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com. [209.85.218.67])
        by gmr-mx.google.com with ESMTPS id o125si147289ith.3.2016.06.19.07.29.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2016 07:29:35 -0700 (PDT)
Received: by mail-oi0-f67.google.com with SMTP id d132so21148299oig.3
        for <rtc-linux@googlegroups.com>; Sun, 19 Jun 2016 07:29:35 -0700 (PDT)
Date: Sun, 19 Jun 2016 09:29:34 -0500
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 03/13] RTC: ds1307: Add DS1341 specific
 power-saving options
Message-ID: <20160619142934.GA8522@rob-hp-laptop>
References: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
 <1465970379-14703-4-git-send-email-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1465970379-14703-4-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jun 14, 2016 at 10:59:29PM -0700, Andrey Smirnov wrote:
> Add DS1341 specific power-saving options that allow to disable certain
> functional aspects of the chip in order to minimize its power
> consumption.

This description doesn't match that you are adding a new binding. It is 
preferred that bindings are a separate patch.

> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../devicetree/bindings/rtc/dallas,ds1341.txt      | 23 ++++++++++++++++++
>  drivers/rtc/rtc-ds1307.c                           | 28 ++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1341.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/dallas,ds1341.txt b/Documentation/devicetree/bindings/rtc/dallas,ds1341.txt
> new file mode 100644
> index 0000000..b8be7a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/dallas,ds1341.txt
> @@ -0,0 +1,23 @@
> +* Dallas DS1341		I2C Serial Real-Time Clock
> +
> +Required properties:
> +
> +- compatible: Should contain "dallas,ds1341".
> +
> +- reg: I2C address for chip
> +
> +Optional properties:
> +
> +- disable-oscillator-stop-flag : Configure chip to disable oscillator
> +  fault detection circuitry
> +
> +- enable-glitch-filter : Configure chip to enable crystal oscillator
> +  output glitch filtering

What determines setting these properties or not?

They should have vendor prefix and be explicit that they are boolean.

Rob

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
