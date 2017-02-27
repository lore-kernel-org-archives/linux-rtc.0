Return-Path: <rtc-linux+bncBDJIP47K7MERBXXV2LCQKGQE5AGM3DA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com. [209.85.218.48])
        by gmr-mx.google.com with ESMTPS id 13si2103999iti.0.2017.02.27.15.48.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2017 15:48:46 -0800 (PST)
Received: by mail-oi0-f48.google.com with SMTP id f192so27557668oic.3
        for <rtc-linux@googlegroups.com>; Mon, 27 Feb 2017 15:48:46 -0800 (PST)
Date: Mon, 27 Feb 2017 17:48:45 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCHv3 1/2] dt-bindings: Add vendor prefix for Motorola
Message-ID: <20170227234845.aifccmxp7vu7xwlb@rob-hp-laptop>
References: <20170220073535.27393-1-sre@kernel.org>
 <20170223010353.24351-1-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170223010353.24351-1-sre@kernel.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Feb 23, 2017 at 02:03:52AM +0100, Sebastian Reichel wrote:
> Motorola was involved in semiconductor and mobile phone business.
> The "motrola," prefix is already used by a couple of bindings:

typo.

> 
> * rtc/rtc-cmos.txt
> * mfd/motorola-cpcap.txt
> * regulator/cpcap-regulator.txt
> 
> Apart from that it is used in the DT file for the Droid 4 mobile
> phone.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Otherwise,

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
