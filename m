Return-Path: <rtc-linux+bncBDS7HNEFSALRBMWTQWXAKGQEG3P4OYI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v8si163397wiw.1.2015.08.04.18.41.06
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 18:41:06 -0700 (PDT)
Date: Wed, 5 Aug 2015 03:41:05 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] Re: [PATCH v2 3/3] RTC: switch to using is_visible() to
 control sysfs attributes
Message-ID: <20150805014105.GX3486@piout.net>
References: <1437692468-24788-1-git-send-email-dmitry.torokhov@gmail.com>
 <1437692468-24788-3-git-send-email-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1437692468-24788-3-git-send-email-dmitry.torokhov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 23/07/2015 at 16:01:08 -0700, Dmitry Torokhov wrote :
> Instead of creating wakealarm attribute manually, after the device has been
> registered, let's rely on facilities provided by the attribute groups to
> control which attributes are visible and which are not. This allows to to
> create all needed attributes at once, at the same time that we register RTC
> class device.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
