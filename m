Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBPOB73CAKGQECGIKCRA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v70si414328wmf.0.2017.02.11.15.39.41
        for <rtc-linux@googlegroups.com>;
        Sat, 11 Feb 2017 15:39:41 -0800 (PST)
Date: Sun, 12 Feb 2017 00:39:40 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Heiko Schocher <hs@denx.de>, Rob Herring <robh@kernel.org>
Subject: [rtc-linux] Re: [PATCH] bindings: rtc: correct wrong reference in
 required properties
Message-ID: <20170211233940.fagzm6szk6rjn64v@piout.net>
References: <1486496213-11790-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1486496213-11790-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 08/02/2017 at 04:36:53 +0900, Akinobu Mita wrote:
> There are currently two broken bindings descriptions for RTC:
> 
> maxim,ds3231.txt
> pcf8563.txt
> 
> They broke because of a improper RST documentation conversion with
> commit 8c27ceff3604b2 ("docs: fix locations of several documents that got
> moved") and now reference to a non-existing file:
> 
> Documentation/devicetree/bindings/i2c/trivial-admin-guide/devices.rst
> 
> However, the original reference to i2c/trivial-devices should have never
> been made in the first place.
> 
> This change fixes this issue by replacing with correct descriptions.
> 
> Reported-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/maxim,ds3231.txt | 3 ++-
>  Documentation/devicetree/bindings/rtc/pcf8563.txt      | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
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
