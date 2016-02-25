Return-Path: <rtc-linux+bncBDS7HNEFSALRBWMLXW3AKGQECY6NMYY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si219484wmd.1.2016.02.25.10.20.09
        for <rtc-linux@googlegroups.com>;
        Thu, 25 Feb 2016 10:20:09 -0800 (PST)
Date: Thu, 25 Feb 2016 19:20:08 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Henderson <joshua.henderson@microchip.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v3 1/2] dt/bindings: Add bindings for the
 PIC32 real time clock
Message-ID: <20160225182008.GI12073@piout.net>
References: <1456421449-18225-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1456421449-18225-1-git-send-email-joshua.henderson@microchip.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 25/02/2016 at 10:30:43 -0700, Joshua Henderson wrote :
> Document the devicetree bindings for the real time clock found
> on Microchip PIC32 class devices.
> 
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>
> --
> Changes since v2: None
> Changes since v1: None
> ---
>  .../bindings/rtc/microchip,pic32-rtc.txt           |   21 ++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt
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
